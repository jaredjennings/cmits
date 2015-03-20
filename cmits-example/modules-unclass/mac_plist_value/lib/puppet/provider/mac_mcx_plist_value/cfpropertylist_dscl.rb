# CMITS - Configuration Management for Information Technology Systems
# Based on <https://github.com/afseo/cmits>.
# Copyright 2015 Jared Jennings <mailto:jjennings@fastmail.fm>.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
require 'puppet'
require 'tempfile'
require 'index_haoha'
require 'puppet/provider/plist_osx_cocoa_common'

# if we can't get the thing we need, we can't provide anything. but we don't
# want the whole Puppet agent to die because of the problem, so we have to
# catch the exception.
begin
  require 'cfpropertylist'
rescue LoadError
  # CFPropertyList won't be defined, and the confine below will fail,
  # marking the provider unsuitable.
end


Puppet::Type.type(:mac_mcx_plist_value).provide :cfpropertylist_dscl do
  desc <<-EOT
    Manage property list values in a directory service on a Mac by using the
    CFPropertyList Ruby gem and the dscl utility.
    EOT

  confine :operatingsystem => :darwin
  defaultfor :operatingsystem => :darwin
  confine :true => defined?(CFPropertyList)
  commands :dscl => '/usr/bin/dscl'

  def _load
    # we don't want to try to parse errors as output
    out = execute(['/usr/bin/dscl', '/Local/Default', '-mcxexport',
                   resource[:record]], :combine => false)
    if out.empty?
      rv = {}
    else
      plist = CFPropertyList::List.new(:data => out)
      rv = CFPropertyList.native_types(plist.value)
    end
    debug "derived #{rv.inspect} from #{out.inspect}"
    return rv
  end

  def _save properties
    debug "new value of all properties: #{properties.inspect}"
    plist = CFPropertyList::List.new
    plist.value = CFPropertyList.guess(properties)
    # We should write another file and move it over this one, but this
    # way we don't have to worry with ownership and permissions.  And
    # plist files should be short enough that we can write them in one
    # or two system calls, so our failure window is small.
    Tempfile.open('mcxplvosxcd') do |f|
      f.print plist.to_str(CFPropertyList::List::FORMAT_XML)
      f.fsync
      dscl '/Local/Default', '-mcximport', resource[:record], f.path
    end
  end

  def _one_exists? is
    is and \
    (is['value'] == _coerce(resource[:value])) and \
    (is['state'] == resource[:mcx_domain].to_s)
  end

  def _create_one place_to_set, last_key
    place_to_set[last_key] = {
      'state' => resource[:mcx_domain].to_s,
      'value' => _coerce(resource[:value])
    }
    debug "set value of #{resource[:key].inspect} " \
    "to #{place_to_set[last_key].inspect}"
  end

  include PlistOSXCocoaCommon
end

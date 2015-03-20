# % CMITS - Configuration Management for Information Technology Systems
# % Based on <https://github.com/afseo/cmits>.
# % Copyright 2015 Jared Jennings <mailto:jjennings@fastmail.fm>.
# %
# % Licensed under the Apache License, Version 2.0 (the "License");
# % you may not use this file except in compliance with the License.
# % You may obtain a copy of the License at
# %
# %    http://www.apache.org/licenses/LICENSE-2.0
# %
# % Unless required by applicable law or agreed to in writing, software
# % distributed under the License is distributed on an "AS IS" BASIS,
# % WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# % See the License for the specific language governing permissions and
# % limitations under the License.
# \section{templates.pp}
# \label{templates}
#
# Here are the primary units of functionality needed to configure nodes within
# our administration. Classes referred to with the \verb!include! directive
# implement smaller units of policy and are covered in the ensuing sections of
# \S\ref{Policy}.
#

class unix_stig_compliance_base {
    include aide
    include ssh::stig
    include stig_misc
    include user::valid
    include user::unnecessary
    include gnome-screensaver::stig
    include shell::stig
    include pam::rhosts
    include at::stig
    include kdump::no
    include network::stig
    include ftp::no
    include pki::ca_certs::system_nss
    include ldap::stig
    include disable_ctrlaltdel
    include snmp::no
    include network::no_bluetooth
}


class example_org_workstation
    include automount
    class { 'gdm::logo':
        source => 'puppet:///gdm/logo/example-org',
    }
    automount::mount { 'apps': from => 'example-data:/vol/apps' }
    class { 'grub::password':
        md5_password => 'ddce269a1e3d054cae349621c198dd52',
    }
}


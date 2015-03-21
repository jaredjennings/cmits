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

# This Makefile creates the files in the build-products subdirectory. See the
# README therein for more details on what the files are.

B = build-products

FILES = \
	cmits-example.pdf \

B_FILES = $(addprefix $B/, $(FILES))

all: $(B_FILES)

$B/cmits-example.pdf: cmits-example/unified-policy-document/main.pdf
	cp $< $@

cmits-example/unified-policy-document/main.pdf:
	cd cmits-example/unified-policy-document; python2.6 make.py

clean:
	rm -f $(B_FILES)
	cd cmits-example/unified-policy-document; python2.6 clean.py

.PHONY: clean

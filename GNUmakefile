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
	texmf.zip \
	cmits-example.pdf \
	shaney-1.12-py2.6.egg \
	shaney-1.12.win32.exe \

B_FILES = $(addprefix $B/, $(FILES))

all: $(B_FILES)

$B/texmf.zip: iadoc/dist/iadoc.zip iacic/dist/iacic.zip
	T=$$(mktemp -d); HERE=$$(pwd); \
	    cd $$T; \
	    mkdir -p texmf/tex/latex; \
	    mkdir -p texmf/doc/latex; \
	    make -C $$HERE/iadoc prefix=foo datadir=$$T docdir=$$T/texmf/doc/latex install; \
	    make -C $$HERE/iacic prefix=foo datadir=$$T docdir=$$T/texmf/doc/latex install; \
	    zip -r texmf.zip texmf; \
	    mv -f texmf.zip $$HERE/$@; \
	    rm -rf $$T

$B/cmits-example.pdf: cmits-example/unified-policy-document/main.pdf
	cp $< $@

$B/shaney-%.egg: shaney/dist/shaney-%.egg
	cp $< $@

# In order to build shaney-x.y.win32.exe, setuptools needs two exe files,
# gui.exe and cli.exe, which appear not to be distributed in the RHEL 6
# python-setuptools package. Go find a tar of setuptools 0.6.x, fish out the
# exe files, and drop them under /usr/lib/python/site-packages/setuptools.
$B/shaney-%.win32.exe: shaney/dist/shaney-%.win32.exe
	cp $< $@

iadoc/dist/iadoc.zip:
	$(MAKE) -C iadoc dist
iacic/dist/iacic.zip:
	$(MAKE) -C iacic dist

cmits-example/unified-policy-document/main.pdf:
	cd cmits-example/unified-policy-document; python2.6 make.py

shaney/dist/shaney-%.egg:
	cd shaney; python2.6 setup.py bdist_egg
shaney/dist/shaney-%.win32.exe:
	cd shaney; python2.6 setup.py bdist_wininst -p win32

clean:
	rm -f $(B_FILES)
	$(MAKE) -C iadoc clean
	$(MAKE) -C iacic clean
	cd cmits-example/unified-policy-document; python2.6 clean.py
	cd shaney; python2.6 setup.py clean

.PHONY: clean

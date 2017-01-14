# Copyright (c) 2017 The pliOS Authors. All rights reserved.
#
# Use of this source code is governed by a MIT-style license that can be found
# in the LICENSE file.

CTNG_VER := 1.22.0
CTNG := $(shell pwd)/out/ctng/bin/ct-ng

.PHONY: all x86_64 armv7

all: x86_64 armv7

armv7: out/armv7-unknown-linux-musleabihf.tar.gz
x86_64: out/x86_64-unknown-linux-musl.tar.gz

out/armv7-unknown-linux-musleabihf.tar.gz: out/armv7
	@cd out && tar -zcvf armv7-unknown-linux-musleabihf.tar.gz armv7

out/x86_64-unknown-linux-musl.tar.gz: out/x86_64
	@cd out && tar -zcvf x86_64-unknown-linux-musl.tar.gz x86_64

out/armv7: out/ctng
	@cd armv7 && $(CTNG) build

out/x86_64: out/ctng
	@cd x86_64 && $(CTNG) build

out/ctng: out/crosstool-ng
	@cd out/crosstool-ng && ./configure --prefix=$(shell pwd)/out/ctng
	@cd out/crosstool-ng && MAKELEVEL=0 make
	@cd out/crosstool-ng && MAKELEVEL=0 make install

out/crosstool-ng:
	@mkdir -p out
	@cd out && wget http://crosstool-ng.org/download/crosstool-ng/crosstool-ng-$(CTNG_VER).tar.bz2
	@cd out && tar xjf crosstool-ng-$(CTNG_VER).tar.bz2


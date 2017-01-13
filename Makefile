# Copyright (c) 2017 The pliOS Authors. All rights reserved.
#
# Use of this source code is governed by a MIT-style license that can be found
# in the LICENSE file.

CTNG_VER := 1.22.0

.PHONY: all

all: out/ctng

out/ctng: out/crosstool-ng
	@cd out/crosstool-ng && ./configure --prefix=$(shell pwd)/out/ctng
	@cd out/crosstool-ng && MAKELEVEL=0 make
	@cd out/crosstool-ng && MAKELEVEL=0 make install

out/crosstool-ng:
	@mkdir -p out
	@cd out && wget http://crosstool-ng.org/download/crosstool-ng/crosstool-ng-$(CTNG_VER).tar.bz2
	@cd out && tar xjf crosstool-ng-$(CTNG_VER).tar.bz2
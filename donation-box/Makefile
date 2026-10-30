# `make` exports each part of donation_box.scad to its own file in stl/ (needs
# the openscad CLI).
# `make dist` bundles each top-level .scad file and any lib/ dependencies into
# a single self-contained file in dist/, for sites that take one .scad file
# (needs uv: https://docs.astral.sh/uv/).
SCADS := $(wildcard *.scad)
PARTS := box lid sign
STLS := $(patsubst %,stl/donation_box_%.stl,$(PARTS))
DISTS := $(patsubst %.scad,dist/%.scad,$(SCADS))

all: $(STLS)

dist: $(DISTS)

stl/donation_box_%.stl: donation_box.scad $(wildcard lib/*.scad)
	openscad -D 'part="$*"' -o $@ $<

dist/%.scad: %.scad $(wildcard lib/*.scad)
	mkdir -p dist
	uvx openscad-packer pack $< -o $@

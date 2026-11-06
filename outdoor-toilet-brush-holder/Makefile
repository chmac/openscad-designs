# `make` exports each part of toilet_brush_holder.scad to its own file in stl/
# (needs the openscad CLI).
# `make dist` bundles each top-level .scad file and any lib/ dependencies into
# a single self-contained file in dist/, for sites that take one .scad file
# (needs uv: https://docs.astral.sh/uv/).
SCADS := $(wildcard *.scad)
PARTS := holder foot
STLS := $(patsubst %,stl/toilet_brush_holder_%.stl,$(PARTS))
DISTS := $(patsubst %.scad,dist/%.scad,$(SCADS))

all: $(STLS)

dist: $(DISTS)

stl/toilet_brush_holder_%.stl: toilet_brush_holder.scad $(wildcard lib/*.scad)
	openscad -D 'part="$*"' -o $@ $<

dist/%.scad: %.scad $(wildcard lib/*.scad)
	mkdir -p dist
	uvx openscad-packer pack $< -o $@

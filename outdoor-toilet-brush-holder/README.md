# toilet-brush-holder

OpenSCAD model for an outdoor toilet brush holder: a round cup with a drain
hole, on three long tapered legs. A separate pointed foot wedges into a tapered socket under
the tip of each leg. Only the feet touch the ground, so it stands on three
points and doesn't rock on uneven ground.

## Layout

- `toilet_brush_holder.scad` – the model; open this in OpenSCAD. Set `part` to
  `holder`, `foot` or `all`
- `stl/` – exported meshes for slicing (`make`), one per part
- `dist/` – single-file bundle for uploading to sites that take one `.scad` (`make dist`)

## Usage

Open `toilet_brush_holder.scad` in OpenSCAD, F5 to preview, F6 to render, then
export STL. Or run `make` to export `stl/toilet_brush_holder_holder.stl` and
`stl/toilet_brush_holder_foot.stl`.

Print one holder and three feet (one per leg). Both print as modelled, no
supports: the legs lie flat on the bed and the sockets open onto it. The foot
prints plug end down, point up.

If the brush is tight or loose, change `clearance`. If the feet are too tight
or loose in the sockets, change `fit_clearance`. The footprint is about
`2 x leg_reach` across, which must fit the bed (256 mm).

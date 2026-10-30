# donation-box

OpenSCAD model for a donation box: an open-topped box and a lid with a slot to
drop money through. The lid is the full outer size of the box, with a ring
underneath that steps inwards and drops inside the box walls.

The front of the box can also carry a sign: a flat card that drops into a
holder on the outside of the wall, with the sides of the holder overhanging the
edges of the card.

## Layout

- `donation_box.scad` – the model; open this in OpenSCAD. Set `part` to `box`,
  `lid`, `sign` or `all`
- `stl/` – exported meshes for slicing (`make`), one per part
- `dist/` – single-file bundles for uploading to sites that take one `.scad` (`make dist`)

## Dependencies

- [OpenSCAD](https://openscad.org) – `brew install --cask openscad`
- [uv](https://docs.astral.sh/uv/) – `brew install uv`. Used to run
  [openscad-packer](https://pypi.org/project/openscad-packer/) via `uvx`, which
  bundles any `lib/` files into one `.scad` for publishing. Nothing else to install.

## Usage

Open `donation_box.scad` in OpenSCAD, F5 to preview, F6 to render, then export STL.
Or run `make` to export `stl/donation_box_box.stl`, `stl/donation_box_lid.stl`
and `stl/donation_box_sign.stl` from the CLI.

The lid is modelled upside down so it prints flat without supports.

To publish, run `make dist` and upload `dist/donation_box.scad`.

## License

[CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) – see `LICENSE`.

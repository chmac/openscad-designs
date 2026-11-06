# schuko-faceplate

OpenSCAD model for a Schuko (CEE 7/4) socket faceplate.

## Origin

This is a derivative of
[Enchufe schuko descatalogado](https://www.thingiverse.com/thing:954926)
by 3Dmatic, published on Thingiverse and licensed under
[Creative Commons Attribution-ShareAlike](https://creativecommons.org/licenses/by-sa/4.0/).

- `schuko_faceplate.scad` – the original `enchufe.scad` from
  <https://www.thingiverse.com/thing:954926/files>, renamed. It was added to this
  repo unmodified; changes made after that are listed below and in git history.

## Changes from the original

- Renamed from `enchufe.scad`.
- Removed the rectangular reinforcement block on top of the body.
- The two larger holes are enlarged from 7 mm to 10 mm diameter and moved from y = ±10 to y = ±9.5, so the centres are 19 mm apart (the CEE 7/4 pin spacing).
- Centre hole is now 3 mm diameter with a 45° chamfer (7 mm across) on the socket face, replacing the 3.5 mm hole and 6 mm counterbore.
- Back wall (the face the holes go through) is 2.8 mm thick, with a 9 mm round block on the back around the centre hole making it 3.75 mm there.
- Removed the four round discs at the corners of the front plate (anti-lift ears for ABS).
- Outer body is a smooth circle (`$fn=80`) instead of 16-sided.
- Socket cavity is 17.5 mm deep from the front face (was about 19.9 mm), matching the CEE 7/3 recess depth. The body is shortened to match: 2.8 mm back wall plus the 9 mm block, 21.25 mm overall. The earth-slot notches and the internal tabs are moved or shortened to follow.
- Front plate is now flat on the front with no step behind it, and has a 2 mm thick rim running back to 10 mm in front of the back of the centre block.

## License

[CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) – see `LICENSE`.

The original is licensed CC BY-SA by 3Dmatic. Adaptations must be shared under
the same license (BY-SA 3.0 permits relicensing under later versions of the same
license), with attribution to the original author as above.

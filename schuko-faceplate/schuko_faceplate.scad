rotate([0,0,0]){
difference(){
        union(){
                // round block on the back of the wall, brings it to 3.75mm at the centre hole
                translate([0,0,18.1])
                        cylinder(d=9, $fn=60, h=19.35-18.1);
                difference(){ 
	                difference(){ //CUERPO CIRCULAR
		                translate([0,0,0])
			                cylinder(r=44/2, $fn=80, h=18.4); // back wall z=15.6..18.4 is 2.8mm thick
		                translate([0,0,-1])
			                cylinder(r=39/2, $fn=80, h=16.6); // ends z=15.6: 17.5mm deep from the front face (z=-1.9)
	                }
                        
	                color([1,1,1]){ //CORTES LATERALES TOMA TIERRA
		                translate([-22,-2,-1])
			                cube([6,4,30]);
		                translate([-19,2,18.4])
			                rotate([90,0,0])
				                cylinder(r=15/2, $fn=3, h=4);

		                translate([16,-2,-1])
			                cube([6,4,30]);
		                translate([19,-2,18.4])
			                rotate([90,0,180])
				                cylinder(r=15/2, $fn=3, h=4);
	                }
                }
        }
        // PERFORACIONES CENTRALES
        translate([0,9.5,0]) // 19mm between centres, CEE 7/4 pin spacing
                cylinder(r=10/2, $fn=60, h=40);
        translate([0,-9.5,0])
                cylinder(r=10/2, $fn=60, h=40);
        translate([0,0,0])
                cylinder(r=3/2, $fn=60, h=40);
        // 45 degree chamfer on the socket face (z=15.6), 7mm across at the face
        translate([0,0,15.6])
                cylinder(d1=7, d2=3, $fn=60, h=2);
        translate([0,0,14.6])
                cylinder(d=7, $fn=60, h=1);
}
//PESTAÑAS INTERNAS LATERALES
translate([5.4/2,16.9,0]) 
        cube([7,3,16.9]);
translate([-5.4/2-7,16.9,0])
        cube([7,3,16.9]);
translate([5.4/2,-20.4,0])
        cube([7,3.5,16.9]);
translate([-5.4/2-7,-20.4,0])
        cube([7,3.5,16.9]);

}

// 2D outline of the face: 80mm square overall (corner centres 37mm out, corner radius 3 outside),
// with corners of radius r.
module face_outline(r) {
        hull() {
                for (x=[-37,37], y=[-37,37])
                        translate([x,y])
                                circle(r=r, $fn=60);
        }
}

difference(){ //FRONTAL: flat front face at z=-1.9 with a rim running back
        union(){
                // face plate, 2mm thick
                translate([0,0,-1.9])
                        linear_extrude(height=2)
                                face_outline(3);
                // rim, 2mm wall, ends z=9.35: 10mm in front of the back of the centre block (z=19.35)
                translate([0,0,-1.9])
                        linear_extrude(height=9.35+1.9)
                                difference(){
                                        face_outline(3);
                                        face_outline(1);
                                }
        }
        translate([0,0,-4])
	        cylinder(r=39/2, $fn=80, h=19);
}

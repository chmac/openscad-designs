rotate([0,0,0]){
difference(){
        union(){
                translate([-6.5,-15,20.9]) //REFUERZO RECTANGULAR SUPERIOR
                        cube([13,30,5]);
                difference(){ 
	                difference(){ //CUERPO CIRCULAR
		                translate([0,0,0])
			                cylinder(r=44/2, $fn=16, h=21.5);
		                translate([0,0,-1])
			                cylinder(r=39/2, $fn=80, h=19);
	                }
                        
	                color([1,1,1]){ //CORTES LATERALES TOMA TIERRA
		                translate([-22,-2,-1])
			                cube([6,4,30]);
		                translate([-19,2,21.5])
			                rotate([90,0,0])
				                cylinder(r=15/2, $fn=3, h=4);

		                translate([16,-2,-1])
			                cube([6,4,30]);
		                translate([19,-2,21.5])
			                rotate([90,0,180])
				                cylinder(r=15/2, $fn=3, h=4);
	                }
                }
        }
        // PERFORACIONES CENTRALES
        translate([0,10,0])
                cylinder(r=7/2, $fn=10, h=40);
        translate([0,-10,0])
                cylinder(r=7/2, $fn=10, h=40);
        translate([0,0,0])
                cylinder(r=3.5/2, $fn=10, h=40);
        translate([0,0,0])
                cylinder(r=6/2, $fn=10, h=20);
}
//PESTAÑAS INTERNAS LATERALES
translate([5.4/2,16.9,0]) 
        cube([7,3,20]);
translate([-5.4/2-7,16.9,0])
        cube([7,3,20]);
translate([5.4/2,-20.4,0])
        cube([7,3.5,20]);
translate([-5.4/2-7,-20.4,0])
        cube([7,3.5,20]);

}

difference(){ //FRONTAL
        union(){
                translate([-25.5,-25.5,0])
	                cube([51,51,1]);
                hull(){
	                translate([-25.5,-25.5,-1.9])
		                cylinder(r=3, $fn=10, h=2);
	                translate([+25.5,-25.5,-1.9])
		                cylinder(r=3, $fn=10, h=2);
	                translate([-25.5,+25.5,-1.9])
		                cylinder(r=3, $fn=10, h=2);
	                translate([+25.5,+25.5,-1.9])
		                cylinder(r=3, $fn=10, h=2);
                }
        }
        translate([0,0,-4])
	        cylinder(r=39/2, $fn=80, h=19);
}


// CIRCULOS DE LAS ESQUINAS PARA QUE ESTAS NO SE LEVANTEN EN IMPRESION CON ABS
translate([30,30,-1.90])
	cylinder(r=7.8/2, $fn=12, h=0.6);
translate([-30,30,-1.90])
	cylinder(r=7.8/2, $fn=12, h=0.6);
translate([-30,-30,-1.90])
	cylinder(r=7.8/2, $fn=12, h=0.6);
translate([30,-30,-1.90])
	cylinder(r=7.8/2, $fn=12, h=0.6);

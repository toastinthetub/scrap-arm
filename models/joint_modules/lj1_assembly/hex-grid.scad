include <BOSL2/std.scad>
// The Belfry OpenSCAD Library V2
// Source: https://github.com/revarbat/BOSL2
// Documentation: https://github.com/revarbat/BOSL2/wiki
// BOSL2 is licensed under BSD 2-Clause License
//    https://github.com/revarbat/BOSL2/blob/master/LICENSE

////////////////////////////////////////////////////////////////////
// cell: takes three parameters and returns a single hexagonal cell
//
//   SW_hole: scalar value that specifies the width across the flats
//     of the interior hexagon
//   height: scalar value that specifies the height/depth of the 
//     cell (i.e. distance from from front to back
//   wall: scalar vale that specifies the thickness of the wall 
//     surrounding the interior hex (hole). e.g. if SW_hole is 8 
//     and wall is 2 then the total width across the flats of the
//     cell is 8 + 2(2) = 12.
////////////////////////////////////////////////////////////////////
module cell(SW_hole, height, wall) {
  tol = 0.001; // used to clean up difference artifacts
  difference() {
    cyl(d=SW_hole+2*wall,h=height,$fn=6,circum=true);
    cyl(d=SW_hole,h=height+tol,$fn=6,circum=true);
  }
}

////////////////////////////////////////////////////////////////////
// grid: takes three parameters and returns the initial grid of 
//    hexagons
//
//    size: 3-vector (x,y,z) that specifies the  size of the cube 
//      that contains the hex grid
//    cell_hole: scalar value specifying width across flats of the 
//      interior hexagon (hole)
//    cell_wall: scalar value that specifies wall thickness of the
//      hexagon
////////////////////////////////////////////////////////////////////
module grid(size,cell_hole,cell_wall) {
  dx=cell_hole*sqrt(3)+cell_wall*sqrt(3);
  dy=cell_hole+cell_wall;

  ycopies(spacing=dy,l=size[1])    
    xcopies(spacing=dx,l=size[0]) {
      cell(SW_hole=cell_hole,
           height=size[2],
           wall=cell_wall);
      right(dx/2)fwd(dy/2)
      cell(SW_hole=cell_hole,
          height=size[2],
          wall=cell_wall);
    }
 }

////////////////////////////////////////////////////////////////////
// mask: creates a mask that is used by the module create_grid()
//   The mask is used to remove extra cells that are outside the 
//   cube that holds the final grid
////////////////////////////////////////////////////////////////////
module mask(size) {
  difference() {
    cuboid(size=2*size);
    cuboid(size=size);
  }
}

////////////////////////////////////////////////////////////////////
// create_grid: creates a rectangular grid of hexagons with a border
//   thickness specified in the parameter (wall).
//
//   size: 3-vector (x,y,z) that specifies the length, width, and 
//     depth of the final grid
//   SW: scalar value that specifies the width across the flats of
//     the interior hexagon (the hole)
//   wall: scalar value that specifies the width of each hexagon's 
//     wall thickness and the thickness of the surrounding
//     rectangular frame
////////////////////////////////////////////////////////////////////
module create_grid(size,SW,wall) {
  b = 2*wall;
  union() {
    difference () {
      cuboid(size=size);
      cuboid(size=[size[0]-b,size[1]-b,size[2]+b]);
    }
  }
  
  difference() {
    grid(size=size,cell_hole=SW,cell_wall=wall);
    mask(size);
  }
}

////////////////////////////////////////////////////////////////////
// Example
// To use call create_grid with
//   size: (x,y,z)
//   SW: (width across the flats of the hex
//   wall: (thickness of wall
////////////////////////////////////////////////////////////////////
//create_grid(size=[100,150,10],SW=20,wall=4);

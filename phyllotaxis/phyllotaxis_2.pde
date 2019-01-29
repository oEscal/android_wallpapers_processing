//global variables
final int BACKGROUND_COLOR = 0, //0 to 255 -> gray scale (0 -> darker; 255 -> whiter)
          MAX_NUMBER_CYCLES = 500,
          DOTS_DIAMETER = 15,
          HUE = 360,
          SATURARION = 100,
          BRIGHTNESS = 100;

int dot_color = 0,  //color in HSB system (corresponds to HUE)
    actual_grow = 1,  //can be 1 or -1 (-1 to decrease the number of dots to be displayed)
    actal_growing_cycle = 0,  //have values betwen 0 and MAX_NUMBER_CYCLES (controls if the actual cycle is a growing or a decreasing cycle)
    cycle = 0;  //total number of cycles 
float x = 0,  //initial dot's x position
      y = 0,  //initial dot's y position
      rotate = 0, //angle in radians to rotate all draw
      c = 10, //from Vagel's formula
      ang,  //auxiliar angle to Vagel's formula's angle
      r,  //from Vagel's formula
      angle,  //from Vagel's formula
      dots_positions[][] = new float[MAX_NUMBER_CYCLES + 1][2]; //matrix with all current dot's positions


//initial conditions
void setup(){
  size(displayWidth, displayHeight);  //full screen
  colorMode(HSB, HUE, SATURARION, BRIGHTNESS); //dot_color defined using HSB system -> better to define random color (just one value to change)
}

void draw(){
  dot_color = cycle%HUE;  //random color based on number of cycles executed util that moment
  background(BACKGROUND_COLOR);

  //rotate all draw to a much more beautiful efect than just place all dots in position
  translate(width/2, height/2);
  rotate(-rotate);

  if(actal_growing_cycle == 0){
    ang = random(360);  //random angle to use in actual phyllotaxis draw
    actual_grow = 1;
    cycle = 0;
  }

  r = c*sqrt(cycle - 1);
  angle = (cycle - 1)*(ang/180)*PI;  //Vagel's formula with a random angle (instead of 137.5º)
  
  //add new dot into position's matrix
  dots_positions[actal_growing_cycle][0] = r*cos(angle) + x; 
  dots_positions[actal_growing_cycle][1] = r*sin(angle) + y;
  
  //draw all dot's of actual cycle with new colors
  for(int num2 = 0; num2 < actal_growing_cycle; num2++){
    stroke(BACKGROUND_COLOR);
    fill(dot_color - 1, SATURARION, BRIGHTNESS);
    dot_color++;
    
    ellipse(dots_positions[num2][0], dots_positions[num2][1], DOTS_DIAMETER, DOTS_DIAMETER);
    
    //begin color if it exceeds max range color
    if(dot_color >= HUE)
      dot_color = 0;
  }
  
  //to decrease the number of dots to be displayed if max number of dots is reached
  if(actal_growing_cycle> MAX_NUMBER_CYCLES - 1)
    actual_grow = -1;
    
  actal_growing_cycle += actual_grow;

  cycle++;
  
  //next angle of rotation
  rotate += PI*frameRate/10000;
  if(rotate == 2*PI)
    rotate = 0;
}

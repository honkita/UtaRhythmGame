import processing.sound.*;
SoundFile sairai; //first song

//array
int[] y1; //declare the array  
int l1 = 0;
int[] y2; //declare the array  
int l2 = 0;
int[] y3; //declare the array  
int l3 = 0;
int[] y4; //declare the array  
int l4 = 0;

//notes audio
float sairaisound = 222;


//background image
PImage sairaiimage;

//font
PFont Note;

//score
int score = 0;

//note spawn
int noterad = 50;
int notehei = 50;
int noterad2 = 40;
int notehei2 = 40;


float[] x1 = {9, 16.5, }; // k most right 
float[] x2 = {10.5, 10.7, 12.3, 18, 19.2, 19.8};//j middle right
float[] x3 = {10, 12, 17.5, 19.5};//f middle left
float[] x4 = {12.6, 20.1};//d most left

//screen
int screen = 1;

void setup() {
  fullScreen();
  /*size(2048, 1500);*/

  //note spawn
  frameRate(30);

  //font
  Note = createFont("Hall Fetica", 50);

  //Sairai 
  sairai = new SoundFile(this, "Sairai.wav"); //first song
  sairaisound = sairai.duration();
  sairaiimage = loadImage("Sairai.png");

  
 
  
  
  if (screen == 1) {
    
      sairai.play();
      sairai.amp(0.5);

  }
  
  }

  void draw() {

    if (screen == 1 || screen == 2) { 

      //background for each song
      if (screen == 1) { // sairai
        background(255);
        image(sairaiimage, 1280, 100);
        fill(0, 0, 0, 120);
        rect(0, 0, 2048, 1500);
      }

      //horizontal line for the notes to hit
      stroke(255);
      strokeWeight(1);
      line(100, 900, 900, 900);


      //rectangular bars
      noStroke();
      fill(200, 200, 200, 100);
      rect(725, 0, 150, 900);

      fill(200, 200, 200, 100);
      rect(525, 0, 150, 900);

      fill(200, 200, 200, 100);
      rect(325, 0, 150, 900);

      fill(200, 200, 200, 100);
      rect(125, 0, 150, 900);

      //lines on bar
      strokeWeight(1.5);
      stroke(255);
      line(725, 0, 725, 900);
      line(875, 0, 875, 900);
      line(525, 0, 525, 900);
      line(675, 0, 675, 900);
      line(325, 0, 325, 900);
      line(475, 0, 475, 900);
      line(125, 0, 125, 900);
      line(275, 0, 275, 900);


      //k note
      noStroke();
      fill(0);
      ellipse(800, 900, 20, 20);
      stroke(0.5);
      strokeWeight(2);
      line(800, 0, 800, 900);
      textFont(Note);
      text("k", 780, 1000);

      //j note
      noStroke();
      fill(0);
      ellipse(600, 900, 20, 20);
      stroke(0.5);
      strokeWeight(2);
      line(600, 0, 600, 900);
      textFont(Note);
      text("j", 600, 1000);

      //f note
      noStroke();
      fill(0);
      ellipse(400, 900, 20, 20);
      stroke(0.5);
      strokeWeight(2);
      line(400, 0, 400, 900);
      textFont(Note);
      text("f", 390, 1000);

      //d note
      noStroke();
      fill(0);
      ellipse(200, 900, 20, 20);
      stroke(0.5);
      strokeWeight(2);
      line(200, 0, 200, 900);
      textFont(Note);
      text("d", 185, 1000);
      
    
    }
    }

      //collision detection
      /*if (keyPressed == true) {
        if (key == 'd') {
          if (y[notecount]<= 950 && y[notecount] >= 850 && x[lane] == 200) {
            y[notecount] = -100;
            score = score + 1000;
          }
        }
        if (key == 'f') {
          if (y[notecount]<= 950 && y[notecount] >= 850 && x[lane] == 400) {
            y[notecount] = -100;
            score = score + 1000;
          }
        }
        if (key == 'j') {
          if (y[notecount]<= 950 && y[notecount] >= 850 && x[lane] == 600) {
            y[notecount] = -100;
            score = score + 1000;
          }
        }
        if (key == 'k') {
          if (y[notecount]<= 950 && y[notecount] >= 850 && x[lane] == 800) {
            y[notecount] = -100;
            score = score + 1000;
          }
        }
      } */
      //note spawn

      //time
      float milli = millis();

     float m = milli/1000;{
     
       //note generation
       for(int j1 = 0; j1 <= 100;j1++){
         if (m + 1.25 >= x1[j1]){
         y1[l1] = y1[l1] + 10;
         fill(0);
         ellipse(800, y1[l1], noterad, notehei);
         fill(246, 132, 108);
         ellipse(800, y1[l1], noterad2, notehei2);
         l1++;
           
         }
       }

     
     
 }

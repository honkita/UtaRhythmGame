import processing.sound.*;
SoundFile sairai; //first song
SoundFile tsunorukimochi; //second song

//sound effects
float tape = 1;
SoundFile file2;

//array
int[] y1 = new int[100]; //declare the array  
int[] y2 = new int[100]; //declare the array  
int[] y3 = new int[100]; //declare the array  
int[] y4 = new int[100]; //declare the array 

float[] x1;
float[] x2;
float[] x3;
float[] x4;

//number of notes per lane for each song
float n1;
float n2;
float n3;
float n4;

//notes audio
float sairaisound = 142;
float tksound = 179;

//note spawn
float sh = 1.5;
//float sh = 0.75;


//background image
PImage sairaiimage;
PImage tsunorukimochiimage;
PImage logo;

//score and combo
int score = 0;
int combo = 0;
int maxcombo = 0;
int totalscore = 100000;


//song boxes
int width = 1000;
int height = 100;

//notes
boolean k = false;
boolean j = false;
boolean f = false;
boolean d = false;

//note type
int perfect = 0;
int great = 0;
int fast = 0;
int slow = 0;
int miss = 0;

//time
float currentm;
float millis;
float m;
float z;

//font 
PFont font; //used for japanese text

//audio
boolean song1 = false;
boolean song2 = false;
int songnumber = 0;

//note spawn
int noterad = 50;
int notehei = 50;
int noterad2 = 40;
int notehei2 = 40;

//button variables
boolean retry = false;


//screen variables
boolean back = false; //screen 5
boolean home = false;
boolean sai = false; //open song 1
boolean tsu = false; //open song 2
boolean start = true; //start screen 
boolean exit = false;

//health bar
int rectx = 200;

//screen
int screen = 3;


void setup() {
  fullScreen();
  //size(displayWidth, displayHeight);

  //note spawn
  frameRate(30);

  //font
  font = createFont("MS-PGothic-48.vlw", 50);

  //logo
  logo = loadImage("LOGO.png");
  logo.resize(200, 200);


  //Sairai 
  sairai = new SoundFile(this, "Sairai.wav"); //first song
  sairaisound = sairai.duration();
  sairaiimage = loadImage("Sairai.png");

  //Tsunoru Kimochi 
  tsunorukimochi = new SoundFile(this, "TsunoruKimochi.mp3"); //second song
  tksound = tsunorukimochi.duration();
  tsunorukimochiimage = loadImage("TsunoruKimochi.jpg");
  tsunorukimochiimage.resize(0, 1200);

  //tap sound
  file2 = new SoundFile(this, "tap.wav"); //tap sound effects
  tape = file2.duration();
}


void draw() {

  //time clock
  millis = millis();

  //background for each song
  if (screen == 1) { // sairai
    imageMode(CORNER);
    background(255);
    image(sairaiimage, 1280, 100);
    fill(0, 0, 0, 120);
    rect(0, 0, displayWidth, displayHeight);
  }

  if (screen == 2) { // tsunoru kimochi
    imageMode(CORNER);
    background(255);
    image(tsunorukimochiimage, 0, 0);
    fill(0, 0, 0, 120);
    rect(0, 0, displayWidth, displayHeight);
  }

  //screen initialization
  if (screen == 1 || screen == 2) { 
    //horizontal line for the notes to hit
    stroke(255);
    strokeWeight(1);
    line(100, 900, 900, 900);

    rectMode(CORNER);

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

    //health bar 

    noStroke();
    fill(255);
    rect(1075, 50, 250, 100);//outer box
    fill(0, 128, 0);
    rect(1100, 75, rectx, 50);//health

    if (rectx >= 200) {
      rectx = 200;
    }

    if (rectx <= 0) {
      if (song1 == true && screen == 1) {
        sairai.stop();
        screen = 3;
      }
      
      if (song2 == true && screen == 2) {
        tsunorukimochi.stop();
        screen = 3;
      }
    }

    //score
    fill(255);
    textSize(50);
    text(score, 1500, 50);

    //combo
    textAlign(CENTER);
    fill(255, 255, 255, 100);
    text(combo, 500, 500);

    rectMode(CORNER);

    //k note
    noStroke();
    fill(0);
    ellipse(800, 900, 20, 20);
    stroke(0.5);
    strokeWeight(2);
    line(800, 0, 800, 900);
    text("k", 780, 1000);

    //j note
    noStroke();
    fill(0);
    ellipse(600, 900, 20, 20);
    stroke(0.5);
    strokeWeight(2);
    line(600, 0, 600, 900);
    text("j", 600, 1000);

    //f note
    noStroke();
    fill(0);
    ellipse(400, 900, 20, 20);
    stroke(0.5);
    strokeWeight(2);
    line(400, 0, 400, 900);
    text("f", 390, 1000);

    //d note
    noStroke();
    fill(0);
    ellipse(200, 900, 20, 20);
    stroke(0.5);
    strokeWeight(2);
    line(200, 0, 200, 900);
    text("d", 185, 1000);

    //rectangle for exiting
    noStroke();
    rectMode(RADIUS);
    fill(100);
    rect(1500, 1000, 150, 50);

    fill(255);
    textAlign(CENTER);
    text("QUIT (Q)", 1500, 1000);


    if (keyPressed == true) {
      if (key == 'q') {
        screen = 5;
        score = 0;
        perfect = 0;
        great = 0;
        fast = 0;
        slow = 0;
        miss = 0;
        combo = 0;
        maxcombo = 0;
        sairai.stop();
        tsunorukimochi.stop();
        y1 = new int[100]; //declare the array  
        y2 = new int[100]; //declare the array  
        y3 = new int[100]; //declare the array  
        y4 = new int[100]; //declare the array
        song1 = false;
        song2 = false;
      }
    }
  }

  //screen 1
  if (screen == 1) {

    if (!sairai.isPlaying()) {
      song1 = true;
      sairai.play();
      sairai.amp(0.1);
      millis = 0;
      m = 0;
    } 

    //end the song to go to a end screen
    if (m >= sairaisound) {
      sairai.stop();
      screen = 3;
    }
  }


  //screen 2
  if (screen == 2) {

    if (!tsunorukimochi.isPlaying()) {
      song2 = true;
      tsunorukimochi.play();
      tsunorukimochi.amp(0.1);
      millis = 0;
      m = 0;
    } 

    //end the song to go to a end screen
    if (m >= tksound) {
      tsunorukimochi.stop();
      screen = 3;
    }
  }

  if (song1 == true && screen == 1) {

    z =  millis / 1000 ;

    m = z - currentm;

    //notes
    float[] x1 = {8.7, 16.5, 22, 24.3, 25.8, 27.1, 31.4, 34.4, 39.7, 42.6, 
      43, 43.6, 43.9, 44.5, 45.1, 45.7, 46.3, 50.9, 51.5, 52.1, 
      52.7, 53.3, 70, 70.6, 71.2, 71.8, 72.4, 77.9, 78.5, 79.2, 
      79.8, 80.4, 86.4, 88.5, 90, 91.4, 94, 95.5, 97.6, 99.2, 
      101.1, 103, 108.5, 109, 120.5, 123.5, 124, 124.5, 136}; // k most right 

    n1 = 49;

    float[] x2 = {10.5, 10.7, 12.3, 18, 18.2, 19.8, 22, 24, 24.5, 26, 
      26.8, 31.6, 34.2, 39.4, 43.6, 44.2, 44.8, 45.4, 46, 50.6, 
      51.2, 51.8, 52.4, 53, 69.7, 70.3, 70.9, 71.5, 72.1, 77.6, 
      78.2, 78.8, 79.5, 80.1, 88, 88.5, 89.8, 90, 91.2, 95.3, 
      95.5, 97.4, 97.6, 99.4, 101.7, 102.6, 108, 121, 123, 125, 
      135.5};//j middle right

    n2 = 51;

    float[] x3 = {10, 12, 17.5, 19.5, 21, 24.7, 26.2, 27.4, 31, 31.8, 
      34, 39.1, 43.3, 50.3, 69.4, 77.3, 87.3, 87.5, 88, 89.4, 
      89.6, 89.8, 91.5, 94.9, 95.1, 95.3, 97, 97.2, 97.4, 99.6, 
      101.4, 102.4, 102.8, 103.6, 106.1, 106.5, 120.5, 125, 135};//f middle left

    n3 = 39;

    float[] x4 = {12.6, 20.3, 25, 25.2, 25.4, 27.4, 32.8, 33, 33.2, 38.8, 
      43, 50, 69.1, 77, 86.4, 87.3, 87.5, 89.4, 89.6, 91, 
      91.8, 92.1, 94, 94.9, 95.1, 97, 97.2, 99, 99.8, 100, 
      103.8, 104.6, 105.4, 105.9, 106.3, 120, 122, 122.5, 124, 123.5, 
      125.5, 134.5};//d most left

    n4 = 42;






    for (int j1 = 0; j1 < n1; j1++) {

      //note generation for lane 1
      if (m + sh >= x1[j1]) {
        y1[j1] = y1[j1] + 10;
        fill(0);
        ellipse(800, y1[j1], noterad, notehei);
        fill(246, 132, 108);
        ellipse(800, y1[j1], noterad2, notehei2);
      }

      //miss no click
      if (y1[j1] >= 1200 && y1[j1] <= 1300 ) {
        y1[j1] = 2000;
        combo = 0;
        k = false;
        miss++;
        rectx = rectx - 10;
        break;
      }

      //collision detection
      if (k == true) {
        println(y1[j1] + ":" + j1);

        //perfect
        if (y1[j1] >= 850 && y1[j1] <= 950 ) {
          file2.play();
          file2.amp(0.1);
          y1[j1] = 2000;
          score = score + 1000;
          combo++;
          k = false;
          perfect++;
          rectx = rectx + 5;
          break;
        }

        //great
        if (y1[j1] >= 800 && y1[j1] <= 850 ) {
          file2.play();
          file2.amp(0.1);
          y1[j1] = 2000;
          score = score + 500;
          combo++;
          k = false;
          great++;
          rectx = rectx + 3;
          break;
        } 
        if (y1[j1] >= 950 && y1[j1] <= 975 ) {
          file2.play();
          file2.amp(0.1);
          y1[j1] = 2000;
          score = score + 500;
          combo++;
          k = false;
          great++;
          rectx = rectx + 3;
          break;
        }

        //fast
        if (y1[j1] >= 750 && y1[j1] <= 800 ) {
          file2.play();
          file2.amp(0.1);
          y1[j1] = 2000;
          score = score + 100;
          combo = 0;
          k = false;
          fast++;
          break;
        }

        //slow
        if (y1[j1] >= 975 && y1[j1] <= 1200 ) {
          file2.play();
          file2.amp(0.1);
          y1[j1] = 2000;
          score = score + 100;
          combo = 0;
          k = false;
          slow++;
          break;
        }

        //miss
        if (y1[j1] >= 1200 && y1[j1] <= 1300 ) {
          y1[j1] = 2000;
          combo = 0;
          k = false;
          miss++;
          rectx = rectx - 10;
          break;
        }
        if (y1[j1] < 750 ) {
          k = false;
        }
      }
    }




    for (int j2 = 0; j2 < n2; j2++) {
      //note generation for lane 2
      if (m + sh >= x2[j2]) {
        y2[j2] = y2[j2] + 10;
        fill(0);
        ellipse(600, y2[j2], noterad, notehei);
        fill(246, 132, 108);
        ellipse(600, y2[j2], noterad2, notehei2);
      }

      //miss no click
      if (y2[j2] >= 1200 && y2[j2] <= 1300 ) {
        y2[j2] = 2000;
        combo = 0;
        j = false;
        miss++;
        rectx = rectx - 10;
        break;
      }

      //collision detection
      if (j == true) {
        println(y2[j2] + ":" + j2);

        //perfect
        if (y2[j2] >= 850 && y2[j2] <= 950 ) {
          file2.play();
          file2.amp(0.1);
          y2[j2] = 2000;
          score = score + 1000;
          combo++;
          perfect++;
          j = false;
          rectx = rectx + 5;
          break;
        }

        //great
        if (y2[j2] >= 800 && y2[j2] <= 850 ) {
          file2.play();
          file2.amp(0.1);
          y2[j2] = 2000;
          score = score + 500;
          combo++;
          great++;
          j = false;
          rectx = rectx + 3;
          break;
        } 
        if (y2[j2] >= 950 && y2[j2] <= 975 ) {
          file2.play();
          file2.amp(0.1);
          y2[j2] = 2000;
          score = score + 500;
          combo++;
          great++;
          j = false;
          rectx = rectx + 3;
          break;
        }

        //fast
        if (y2[j2] >= 750 && y2[j2] <= 800 ) {
          file2.play();
          file2.amp(0.1);
          y2[j2] = 2000;
          score = score + 100;
          combo = 0;
          fast++;
          j = false;
          break;
        }

        //slow
        if (y2[j2] >= 975 && y2[j2] <= 1200 ) {
          file2.play();
          file2.amp(0.1);
          y2[j2] = 2000;
          score = score + 100;
          combo = 0;
          slow++;
          j = false;
          break;
        }

        //miss
        if (y2[j2] >= 1200 && y2[j2] <= 1300 ) {
          y2[j2] = 2000;
          combo = 0;
          miss++;
          j = false;
          rectx = rectx - 10;
          break;
        }
        if (y2[j2] < 750 ) {
          j = false;
        }
      }
    }


    for (int j3 = 0; j3 < n3; j3++) {
      //note generation for lane 3 
      if (m + sh >= x3[j3]) {
        y3[j3] = y3[j3] + 10;
        fill(0);
        ellipse(400, y3[j3], noterad, notehei);
        fill(246, 132, 108);
        ellipse(400, y3[j3], noterad2, notehei2);
      }

      //miss no click
      if (y3[j3] >= 1200 && y3[j3] <= 1300 ) {
        y3[j3] = 2000;
        combo = 0;
        f = false;
        miss++;
        rectx = rectx - 10;
        break;
      }

      //collision detection
      if (f == true) {
        println(y3[j3] + ":" + j3);

        //perfect
        if (y3[j3] >= 850 && y3[j3] <= 950 ) {
          file2.play();
          file2.amp(0.1);
          y3[j3] = 2000;
          score = score + 1000;
          combo++;
          perfect++;
          f = false;
          rectx = rectx + 5;
          break;
        }

        //great
        if (y3[j3] >= 800 && y3[j3] <= 850 ) {
          file2.play();
          file2.amp(0.1);
          y3[j3] = 2000;
          score = score + 500;
          combo++;
          great++;
          f = false;
          rectx = rectx + 3;
          break;
        } 
        if (y3[j3] >= 950 && y3[j3] <= 975 ) {
          file2.play();
          file2.amp(0.1);
          y3[j3] = 2000;
          score = score + 500;
          combo++;
          great++;
          f = false;
          rectx = rectx + 3;
          break;
        }

        //fast
        if (y3[j3] >= 750 && y3[j3] <= 800 ) {
          file2.play();
          file2.amp(0.1);
          y3[j3] = 2000;
          score = score + 100;
          combo = 0;
          fast++;
          f = false;
          break;
        }

        //slow
        if (y3[j3] >= 975 && y3[j3] <= 1200 ) {
          file2.play();
          file2.amp(0.1);
          y3[j3] = 2000;
          score = score + 100;
          combo = 0;
          slow++;
          f = false;
          break;
        }

        //miss
        if (y3[j3] >= 1200 && y3[j3] <= 1300 ) {
          y3[j3] = 2000;
          combo = 0;
          miss++;
          f = false;
          rectx = rectx - 10;
          break;
        }
        if (y3[j3] < 750 ) {
          f = false;
        }
      }
    }


    for (int j4 = 0; j4 < n4; j4++) {
      //note generation for lane 4
      if (m + sh >= x4[j4]) {
        y4[j4] = y4[j4] + 10;
        fill(0);
        ellipse(200, y4[j4], noterad, notehei);
        fill(246, 132, 108);
        ellipse(200, y4[j4], noterad2, notehei2);
      }

      //miss no click
      if (y4[j4] >= 1200 && y4[j4] <= 1300 ) {
        y4[j4] = 2000;
        combo = 0;
        d = false;
        miss++;
        rectx = rectx - 10;
        break;
      }

      //collision detection
      if (d == true) {

        println(y4[j4] + ":" + j4);


        //perfect
        if (y4[j4] >= 850 && y4[j4] <= 950 ) {
          file2.play();
          file2.amp(0.1);
          y4[j4] = 2000;
          score = score + 1000;
          combo++;
          perfect++;
          d = false;
          rectx = rectx + 5;
          break;
        }

        //great
        if (y4[j4] >= 800 && y4[j4] <= 850 ) {
          file2.play();
          file2.amp(0.1);
          y4[j4] = 2000;
          score = score + 500;
          combo++;
          great++;
          d = false;
          rectx = rectx + 3;
          break;
        } 
        if (y4[j4] >= 950 && y4[j4] <= 975 ) {
          file2.play();
          file2.amp(0.1);
          y4[j4] = 2000;
          score = score + 500;
          combo++;
          great++;
          d = false;
          rectx = rectx + 3;
          break;
        }

        //fast
        if (y4[j4] >= 750 && y4[j4] <= 800 ) {
          file2.play();
          file2.amp(0.1);
          y4[j4] = 2000;
          score = score + 100;
          combo = 0;
          fast++;
          d = false;
          break;
        }

        //slow
        if (y4[j4] >= 975 && y4[j4] <= 1200 ) {
          file2.play();
          file2.amp(0.1);
          y4[j4] = 2000;
          score = score + 100;
          combo = 0;
          slow++;
          d = false;
          break;
        }

        //miss
        if (y4[j4] >= 1200 && y4[j4] <= 1300 ) {
          y4[j4] = 2000;
          combo = 0;
          miss++;
          d = false;
          rectx = rectx - 10;
          break;
        }
        if (y4[j4] < 750 ) {
          d = false;
        }
      }
    }
  }


  if (song2 == true && screen == 2) {

    z =  millis / 1000;

    m = z - currentm;

    //notes
    float[] x1 = {11.5, 14.6, 15, 20.5, 20.8, 26.5, 27.2, 28, 32, 45.9, 
      58.1, 67.5, 68.1, 71, 72.8, 74.4, 78.5, 80.5, 84, 89.6, 
      90, 96, 96.5, 101, 101.5, 104.4, 104.9, 117, 142};

    n1 = 29;

    float[] x2 = {11, 14.4, 14.8, 15.2, 20, 20.3, 26.25, 31, 43.6, 45.4, 
      56.5, 56.8, 57.1, 57.4, 57.6, 57.8, 68.4, 70.6, 71.9, 74, 
      75.5, 76, 80, 81, 82.5, 83.5, 89.4, 89.8, 95, 95.5, 
      101, 101.5, 104.4, 104.9, 117.25, 117.5, 136.8, 138.6, 140.1, 153.4, 
      153.8, 154.2};

    n2 = 42;

    float[] x3 = {10.5, 14.2, 19.5, 19.8, 26, 29, 30, 46.2, 46.8, 56.1, 
      68.7, 70.2, 74.6, 79.5, 82, 83, 89.2, 94, 94.5, 101, 
      101.5, 104.4, 104.9, 116.5, 135.9, 137.7, 139.2, 153.2, 153.6, 154, 
      154.4};

    n3 = 31;

    float[] x4 = {10, 14, 19, 19.3, 25.8, 28.5, 29.5, 41, 41.9, 42.8, 
      43.3, 43.8, 44, 44.9, 46.5, 55.5, 69, 69.8, 79, 81.5, 
      84.5, 89, 93, 93.5, 100, 101.5, 104.4, 104.9, 116, 135, 
      138.9};

    n4 = 31;







    for (int j1 = 0; j1 < n1; j1++) {

      //note generation for lane 1
      if (m + sh >= x1[j1]) {
        y1[j1] = y1[j1] + 10;
        fill(0);
        ellipse(800, y1[j1], noterad, notehei);
        fill(246, 132, 108);
        ellipse(800, y1[j1], noterad2, notehei2);
      }

      //miss no click
      if (y1[j1] >= 1200 && y1[j1] <= 1300 ) {
        y1[j1] = 2000;
        combo = 0;
        k = false;
        miss++;
        rectx = rectx - 10;
        break;
      }

      //collision detection
      if (k == true) {
        println(y1[j1] + ":" + j1);

        //perfect
        if (y1[j1] >= 850 && y1[j1] <= 950 ) {
          file2.play();
          file2.amp(0.1);
          y1[j1] = 2000;
          score = score + 1000;
          combo++;
          k = false;
          perfect++;
          rectx = rectx + 5;
          break;
        }

        //great
        if (y1[j1] >= 800 && y1[j1] <= 850 ) {
          file2.play();
          file2.amp(0.1);
          y1[j1] = 2000;
          score = score + 500;
          combo++;
          k = false;
          great++;
          rectx = rectx + 3;
          break;
        } 
        if (y1[j1] >= 950 && y1[j1] <= 975 ) {
          file2.play();
          file2.amp(0.1);
          y1[j1] = 2000;
          score = score + 500;
          combo++;
          k = false;
          great++;
          rectx = rectx + 3;
          break;
        }

        //fast
        if (y1[j1] >= 750 && y1[j1] <= 800 ) {
          file2.play();
          file2.amp(0.1);
          y1[j1] = 2000;
          score = score + 100;
          combo = 0;
          k = false;
          fast++;
          break;
        }

        //slow
        if (y1[j1] >= 975 && y1[j1] <= 1200 ) {
          file2.play();
          file2.amp(0.1);
          y1[j1] = 2000;
          score = score + 100;
          combo = 0;
          k = false;
          slow++;
          break;
        }

        //miss
        if (y1[j1] >= 1200 && y1[j1] <= 1300 ) {
          y1[j1] = 2000;
          combo = 0;
          k = false;
          miss++;
          rectx = rectx - 10;
          break;
        }
        if (y1[j1] < 750 ) {
          k = false;
        }
      }
    }


    for (int j2 = 0; j2 < n2; j2++) {
      //note generation for lane 2
      if (m + sh >= x2[j2]) {
        y2[j2] = y2[j2] + 10;
        fill(0);
        ellipse(600, y2[j2], noterad, notehei);
        fill(246, 132, 108);
        ellipse(600, y2[j2], noterad2, notehei2);
      }

      //miss no click
      if (y2[j2] >= 1200 && y2[j2] <= 1300 ) {
        y2[j2] = 2000;
        combo = 0;
        j = false;
        miss++;
        rectx = rectx - 10;
        break;
      }

      //collision detection
      if (j == true) {
        println(y2[j2] + ":" + j2);

        //perfect
        if (y2[j2] >= 850 && y2[j2] <= 950 ) {
          file2.play();
          file2.amp(0.1);
          y2[j2] = 2000;
          score = score + 1000;
          combo++;
          perfect++;
          j = false;
          rectx = rectx + 5;
          break;
        }

        //great
        if (y2[j2] >= 800 && y2[j2] <= 850 ) {
          file2.play();
          file2.amp(0.1);
          y2[j2] = 2000;
          score = score + 500;
          combo++;
          great++;
          j = false;
          break;
        } 
        if (y2[j2] >= 950 && y2[j2] <= 975 ) {
          file2.play();
          file2.amp(0.1);
          y2[j2] = 2000;
          score = score + 500;
          combo++;
          great++;
          j = false;
          break;
        }

        //fast
        if (y2[j2] >= 750 && y2[j2] <= 800 ) {
          file2.play();
          file2.amp(0.1);
          y2[j2] = 2000;
          score = score + 100;
          combo = 0;
          fast++;
          j = false;
          break;
        }

        //slow
        if (y2[j2] >= 975 && y2[j2] <= 1200 ) {
          file2.play();
          file2.amp(0.1);
          y2[j2] = 2000;
          score = score + 100;
          combo = 0;
          slow++;
          j = false;
          break;
        }

        //miss
        if (y2[j2] >= 1200 && y2[j2] <= 1300 ) {
          y2[j2] = 2000;
          combo = 0;
          miss++;
          j = false;
          rectx = rectx - 10;
          break;
        }
        if (y2[j2] < 750 ) {
          j = false;
        }
      }
    }


    for (int j3 = 0; j3 < n3; j3++) {
      //note generation for lane 3 
      if (m + sh >= x3[j3]) {
        y3[j3] = y3[j3] + 10;
        fill(0);
        ellipse(400, y3[j3], noterad, notehei);
        fill(246, 132, 108);
        ellipse(400, y3[j3], noterad2, notehei2);
      }

      //miss no click
      if (y3[j3] >= 1200 && y3[j3] <= 1300 ) {
        y3[j3] = 2000;
        combo = 0;
        f = false;
        miss++;
        rectx = rectx - 10;
        break;
      }

      //collision detection
      if (f == true) {
        println(y3[j3] + ":" + j3);

        //perfect
        if (y3[j3] >= 850 && y3[j3] <= 950 ) {
          file2.play();
          file2.amp(0.1);
          y3[j3] = 2000;
          score = score + 1000;
          combo++;
          perfect++;
          f = false;
          rectx = rectx + 5;
          break;
        }

        //great
        if (y3[j3] >= 800 && y3[j3] <= 850 ) {
          file2.play();
          file2.amp(0.1);
          y3[j3] = 2000;
          score = score + 500;
          combo++;
          great++;
          f = false;
          rectx = rectx + 3;
          break;
        } 
        if (y3[j3] >= 950 && y3[j3] <= 975 ) {
          file2.play();
          file2.amp(0.1);
          y3[j3] = 2000;
          score = score + 500;
          combo++;
          great++;
          f = false;
          rectx = rectx + 3;
          break;
        }

        //fast
        if (y3[j3] >= 750 && y3[j3] <= 800 ) {
          file2.play();
          file2.amp(0.1);
          y3[j3] = 2000;
          score = score + 100;
          combo = 0;
          fast++;
          f = false;
          break;
        }

        //slow
        if (y3[j3] >= 975 && y3[j3] <= 1200 ) {
          file2.play();
          file2.amp(0.1);
          y3[j3] = 2000;
          score = score + 100;
          combo = 0;
          slow++;
          f = false;
          break;
        }

        //miss
        if (y3[j3] >= 1200 && y3[j3] <= 1300 ) {
          y3[j3] = 2000;
          combo = 0;
          miss++;
          f = false;
          rectx = rectx - 10;
          break;
        }
        if (y3[j3] < 750 ) {
          f = false;
        }
      }
    }


    for (int j4 = 0; j4 < n4; j4++) {
      //note generation for lane 4
      if (m + sh >= x4[j4]) {
        y4[j4] = y4[j4] + 10;
        fill(0);
        ellipse(200, y4[j4], noterad, notehei);
        fill(246, 132, 108);
        ellipse(200, y4[j4], noterad2, notehei2);
      }

      //miss no click
      if (y4[j4] >= 1200 && y4[j4] <= 1300 ) {
        y4[j4] = 2000;
        combo = 0;
        d = false;
        miss++;
        rectx = rectx - 10;
        break;
      }

      //collision detection
      if (d == true) {

        println(y4[j4] + ":" + j4);


        //perfect
        if (y4[j4] >= 850 && y4[j4] <= 950 ) {
          file2.play();
          file2.amp(0.1);
          y4[j4] = 2000;
          score = score + 1000;
          combo++;
          perfect++;
          d = false;
          rectx = rectx + 5;
          break;
        }

        //great
        if (y4[j4] >= 800 && y4[j4] <= 850 ) {
          file2.play();
          file2.amp(0.1);
          y4[j4] = 2000;
          score = score + 500;
          combo++;
          great++;
          d = false;
          rectx = rectx + 3;
          break;
        } 
        if (y4[j4] >= 950 && y4[j4] <= 975 ) {
          file2.play();
          file2.amp(0.1);
          y4[j4] = 2000;
          score = score + 500;
          combo++;
          great++;
          d = false;
          rectx = rectx + 3;
          break;
        }

        //fast
        if (y4[j4] >= 750 && y4[j4] <= 800 ) {
          file2.play();
          file2.amp(0.1);
          y4[j4] = 2000;
          score = score + 100;
          combo = 0;
          fast++;
          d = false;
          break;
        }

        //slow
        if (y4[j4] >= 975 && y4[j4] <= 1200 ) {
          file2.play();
          file2.amp(0.1);
          y4[j4] = 2000;
          score = score + 100;
          combo = 0;
          slow++;
          d = false;
          break;
        }

        //miss
        if (y4[j4] >= 1200 && y4[j4] <= 1300 ) {
          y4[j4] = 2000;
          combo = 0;
          miss++;
          d = false;
          rectx = rectx - 10;
          break;
        }
        if (y4[j4] < 750 ) {
          d = false;
        }
      }
    }
  }





  //score screen 
  if (screen == 3) {

    //score letter
    int perfects = perfect * 1000;
    int greats = great * 500;
    int fasts = fast * 100;
    int slows = slow * 100;
    int misses = miss * 100;




    if (song1 == true) {
      totalscore = 181000;
    }

    if (song2 == true) {
      totalscore = 133000;
    }


    float percentage = 100 * (perfects + greats + fasts + slows + misses) / totalscore;

    background(255);
    textAlign(CENTER);
    textSize(100);
    fill(0);
    text("RESULTS", displayWidth/4, displayHeight/5); //results name

    //box to hold state the division of notes and letter score
    fill(0, 0, 0, 50);
    noStroke();
    rectMode(RADIUS);
    rect(displayWidth/4, 6 * displayHeight/10, displayWidth/5, displayHeight/3);//note division
    rect(3 * displayWidth/4, 4 * displayHeight/10, displayWidth/5, displayHeight/3);//letter score

    //buttons
    rect(1100, 900, 200, 50);
    if (mouseX >= 900 && mouseX <= 1300 && mouseY >= 850 && mouseY <= 950) {
      home = true;
    } else {
      home = false;
    }

    rect(1600, 900, 200, 50);
    if (mouseX >= 1400 && mouseX <= 1800 && mouseY >= 850 && mouseY <= 950) {
      retry = true;
    } else {
      retry = false;
    }


    //text in buttons
    fill(0);
    textSize(50);
    textAlign(CENTER, CENTER);
    text("Retry", 1600, 900);
    text("Home", 1100, 900);

    fill(0);
    textSize(40);
    textAlign(CORNER, CENTER);
    text("PERFECT: " + perfect, displayWidth/8, 4 * displayHeight/10); //display perfects
    text("GREAT: " + great, displayWidth/8, 5 * displayHeight/10); //display greats
    text("FAST: " + fast, displayWidth/8, 6 * displayHeight/10); //display fasts
    text("SLOW: " + slow, displayWidth/8, 7 * displayHeight/10); //display slows
    text("MISS: " + miss, displayWidth/8, 8 * displayHeight/10); //display perfects


    //letter score

    textAlign(CENTER, CENTER);
    textSize(400); 
    if (percentage >= 95) {
      text("S", 3*displayWidth/4, 4 * displayHeight/10);
    } else if (percentage >= 90) {
      text("A", 3*displayWidth/4, 4 * displayHeight/10);
    } else if (percentage >= 80) {
      text("B", 3*displayWidth/4, 4 * displayHeight/10);
    } else if (percentage >= 70) {
      text("C", 3*displayWidth/4, 4 * displayHeight/10);
    } else if (percentage >= 60) {
      text("D", 3*displayWidth/4, 4 * displayHeight/10);
    } else {
      text("F", 3*displayWidth/4, 4 * displayHeight/10);
    }
  }

  //HOME SCREEN
  if (screen == 4) {
    background(255); 

    //logo
    imageMode(CENTER);
    image(logo, displayWidth/2, displayHeight/2);

    //text
    textFont(font);
    fill(0);
    textAlign(CENTER);
    text("CLICK ANYWHERE TO START", displayWidth / 2, 4 * displayHeight/5);

    if (mousePressed == true) {
      screen = 5;
    }
  }



  //song select screen
  if (screen == 5) {
    background(255);
    noStroke();


    //songs
    fill(0, 0, 0, 100);
    rectMode(CORNER);
    rect(100, 100, width, height); //song #1
    rect(100, 250, width, height); //song #2
    rect(100, 900, 200, 100);

    //back button
    if (mouseX >= 100 && mouseX<= 300 && mouseY >= 900 && mouseY <= 1000) {
      back = true;
    } else {
      back = false;
    }

    //box text
    textAlign(CENTER);
    fill(0);
    textFont(font);


    //song 1
    textSize(50);
    text("\u518D\u6765", 200, 150);
    textSize(20);
    text("\u5C0F\u6797\u4FE1\u4E00", 200, 190);

    if (mouseX >= 100 && mouseX <= 1100 && mouseY >= 100 && mouseY <= 200) {
      sai = true;
    } else {
      sai = false;
    }



    //song 2
    textSize(50);
    text("\u30C4\u30CE\u30EB\u30AD\u30E2\u30C1", 300, 290);
    textSize(20);
    text("CHiCO with HoneyWorks", 275, 340);

    if (mouseX >= 100 && mouseX <= 1100 && mouseY >= 250 && mouseY <= 350) {
      tsu = true;
    } else {
      tsu = false;
    }

    //back button
    textSize(50);
    text("Back", 200, 975);
  }
}

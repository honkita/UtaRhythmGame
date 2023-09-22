import processing.sound.*;
SoundFile sairai; //first song
SoundFile tsunorukimochi; //second song

//sound effects
float tape = 1;
SoundFile file2;

char[] letters = {'d', 'f', 'j', 'k'};

//array
int[] y1 = new int[100]; //declare the array  
int[] y2 = new int[100]; //declare the array  
int[] y3 = new int[100]; //declare the array  
int[] y4 = new int[100]; //declare the array 

//songs
HashMap<String,Song> songs = new HashMap<String,Song>();
s sr = new sairai();
s tk = new tsunorukimochi();

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
int width;
int height = 100;
int laneWidth;
int buttonWidth;

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
int noterad;
int notehei;
int noterad2;
int notehei2;

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
int screen = 0;


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
  
  width = displayWidth/3 * 2;
  buttonWidth = displayWidth/4;
  laneWidth = displayWidth/20;
  noterad = displayWidth/30;
  notehei = displayWidth/30;
  noterad2 = displayWidth/30 - displayWidth/50;
  notehei2 = displayWidth/30 - displayWidth/50;


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
  
  songs.put("sairai", new Song (sr.returnx1(), sr.returnx2(), sr.returnx3(), sr.returnx4()));
  songs.put("tsunorukimochi", new Song (tk.returnx1(), tk.returnx2(), tk.returnx3(), tk.returnx4()));
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
    line(displayWidth/16 - laneWidth, displayHeight/8*7, displayWidth/16 * 7 + laneWidth, displayHeight/8*7);

    rectMode(CORNER);

    

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
    text(combo, displayWidth/4, displayHeight/2);

    rectMode(CORNER);
 
    for(int i = 0; i < 4; i++){
      noStroke();
      fill(200, 200, 200, 100);
      strokeWeight(1.5);
      stroke(255);
      line(displayWidth/16 * (2 * i + 1) - laneWidth / 2, 0, displayWidth/16 * (2 * i + 1) - laneWidth / 2, displayHeight/8*7);
      line(displayWidth/16 * (2 * i + 1) + laneWidth / 2, 0, displayWidth/16 * (2 * i + 1) + laneWidth / 2, displayHeight/8*7);
      rect(displayWidth/16 * (2 * i + 1) - laneWidth / 2, 0, laneWidth, displayHeight/8*7);
      noStroke();
      fill(0);
      ellipse(displayWidth/16 * (2 * i + 1), displayHeight/8*7, 20, 20);
      stroke(0.5);
      strokeWeight(2);
      line(displayWidth/16 * (2 * i + 1), 0, displayWidth/16 * (2 * i + 1), displayHeight/8*7);
      textAlign(CENTER);
      text(letters[i], displayWidth/16 * (2 * i + 1), displayHeight/32*31);
    }

    //rectangle for exiting
    noStroke();
    rectMode(RADIUS);
    fill(100);
    rect(displayWidth/16 * 13, displayHeight/8*7, 150, 50);

    fill(255);
    textAlign(CENTER);
    text("QUIT (Q)", displayWidth/16 * 13, displayHeight/8*7 + 25);


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

  if ((screen == 1 && song1 == true) ||(screen == 2 && song2 == true)) {

    z =  millis / 1000 ;
    m = z - currentm;
    String song = "";
    
    if (song1) {
      song = "sairai";
    } else{
      song= "tsunorukimochi";
    }
    
    
    float[] x1 = songs.get(song).x1;
    float[] x2 = songs.get(song).x2;
    float[] x3 = songs.get(song).x3;
    float[] x4 = songs.get(song).x4;
    
    
    n1 = songs.get(song).x1.length;
    n2 = songs.get(song).x2.length;
    n3 = songs.get(song).x3.length;
    n4 = songs.get(song).x4.length;
    



    for (int j1 = 0; j1 < n1; j1++) {

      //note generation for lane 1
      if (m + sh >= x1[j1]) {
        y1[j1] = y1[j1] + 10;
        fill(0);
        ellipse(displayWidth/16 * 7, y1[j1], noterad, notehei);
        fill(246, 132, 108);
        ellipse(displayWidth/16 * 7, y1[j1], noterad2, notehei2);
      }

      //miss no click
      if (y1[j1] >=  displayHeight/8*7*1.25 && y1[j1] <= 1300 ) {
        y1[j1] = 2000;
        combo = 0;
        k = false;
        miss++;
        rectx = rectx - 10;
        break;
      }

      //collision detection
      if (k == true) {
        //perfect
        if (y1[j1] >= displayHeight/8*7*0.9 && y1[j1] <= displayHeight/8*7*1.1 ) {
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
        if (y1[j1] >=  displayHeight/8*7*0.8 && y1[j1] <= displayHeight/8*7*0.9 ) {
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
        if (y1[j1] >= displayHeight/8*7*1.1 && y1[j1] <=  displayHeight/8*7*1.2 ) {
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
        if (y1[j1] >=  displayHeight/8*7*0.75 && y1[j1] <=  displayHeight/8*7*0.8 ) {
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
        if (y1[j1] >=  displayHeight/8*7*1.2 && y1[j1] <=  displayHeight/8*7*1.25 ) {
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
        if (y1[j1] >=  displayHeight/8*7*1.25 && y1[j1] <= 1300 ) {
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
        ellipse(displayWidth/16 * 5, y2[j2], noterad, notehei);
        fill(246, 132, 108);
        ellipse(displayWidth/16 * 5, y2[j2], noterad2, notehei2);
      }

      //miss no click
      if (y2[j2] >=  displayHeight/8*7*1.25 && y2[j2] <= 1300 ) {
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
        if (y2[j2] >= displayHeight/8*7*0.9 && y2[j2] <= displayHeight/8*7*1.1 ) {
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
        if (y2[j2] >=  displayHeight/8*7*0.8 && y2[j2] <= displayHeight/8*7*0.9 ) {
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
        if (y2[j2] >= displayHeight/8*7*1.1 && y2[j2] <=  displayHeight/8*7*1.2 ) {
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
        if (y2[j2] >=  displayHeight/8*7*0.75 && y2[j2] <=  displayHeight/8*7*0.8 ) {
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
        if (y2[j2] >=  displayHeight/8*7*1.2 && y2[j2] <=  displayHeight/8*7*1.25 ) {
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
        if (y2[j2] >=  displayHeight/8*7*1.25 && y2[j2] <= 1300 ) {
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
        ellipse(displayWidth/16 * 3, y3[j3], noterad, notehei);
        fill(246, 132, 108);
        ellipse(displayWidth/16 * 3, y3[j3], noterad2, notehei2);
      }

      //miss no click
      if (y3[j3] >=  displayHeight/8*7*1.25 && y3[j3] <= 1300 ) {
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
        if (y3[j3] >= displayHeight/8*7*0.9 && y3[j3] <= displayHeight/8*7*1.1 ) {
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
        if (y3[j3] >=  displayHeight/8*7*0.8 && y3[j3] <= displayHeight/8*7*0.9 ) {
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
        if (y3[j3] >= displayHeight/8*7*1.1 && y3[j3] <=  displayHeight/8*7*1.2 ) {
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
        if (y3[j3] >=  displayHeight/8*7*0.75 && y3[j3] <=  displayHeight/8*7*0.8 ) {
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
        if (y3[j3] >=  displayHeight/8*7*1.2 && y3[j3] <=  displayHeight/8*7*1.25 ) {
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
        if (y3[j3] >=  displayHeight/8*7*1.25 && y3[j3] <= 1300 ) {
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
        ellipse(displayWidth/16, y4[j4], noterad, notehei);
        fill(246, 132, 108);
        ellipse(displayWidth/16, y4[j4], noterad2, notehei2);
      }

      //miss no click
      if (y4[j4] >=  displayHeight/8*7*1.25 && y4[j4] <= 1300 ) {
        y4[j4] = 2000;
        combo = 0;
        d = false;
        miss++;
        rectx = rectx - 10;
        break;
      }

      //collision detection
      if (d == true) {

        //perfect
        if (y4[j4] >= displayHeight/8*7*0.9 && y4[j4] <= displayHeight/8*7*1.1 ) {
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
        if (y4[j4] >=  displayHeight/8*7*0.8 && y4[j4] <= displayHeight/8*7*0.9 ) {
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
        if (y4[j4] >= displayHeight/8*7*1.1 && y4[j4] <=  displayHeight/8*7*1.2 ) {
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
        if (y4[j4] >=  displayHeight/8*7*0.75 && y4[j4] <=  displayHeight/8*7*0.8 ) {
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
        if (y4[j4] >=  displayHeight/8*7*1.2 && y4[j4] <=  displayHeight/8*7*1.25 ) {
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
        if (y4[j4] >=  displayHeight/8*7*1.25 && y4[j4] <= 1300 ) {
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
    rect(displayWidth/10 * 6, displayHeight/8*7, width, 50);
    if (mouseX >= displayWidth/10 * 6  && mouseX <= displayWidth/10 * 6 + width && mouseY >= displayHeight/8*7*0.9 && mouseY <= displayHeight/8*7*1.1) {
      home = true;
    } else {
      home = false;
    }

    rect(1600, displayHeight/8*7, 200, 50);
    if (mouseX >= 1400 && mouseX <= 1800 && mouseY >= displayHeight/8*7*0.9 && mouseY <= displayHeight/8*7*1.1) {
      retry = true;
    } else {
      retry = false;
    }


    //text in buttons
    fill(0);
    textSize(50);
    textAlign(CENTER, CENTER);
    text("Retry", 1600, displayHeight/8*7);
    text("Home", 1100, displayHeight/8*7);

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
  if (screen == 0) {
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
    
    rect(displayWidth/20, displayHeight/20 * 17, width/2, height);
    
    for(int i = 0; i < songs.size(); i++){
      rect(displayWidth/20, displayHeight/20 * (3 * (i + 1) - 1), width, height);
    }
      
    //box text
    textAlign(LEFT);
    fill(0);
    textFont(font);
    

    //back button
    if (mouseX >= displayWidth/20 && mouseX<= displayWidth/20 + width/2 && mouseY >= displayHeight/20 * 17 && mouseY <=  displayHeight/20 * 17 + height) {
      back = true;
    } else {
      back = false;
    }
    
    //back button
    textSize(50);
    text("Back", displayWidth/20, displayHeight/40 * 39);

    
    


    //song 1
    textSize(50);
    text("\u518D\u6765", displayWidth/20, displayHeight/20 * 2.5);
    textSize(20);
    text("\u5C0F\u6797\u4FE1\u4E00", displayWidth/20, displayHeight/20 * 3.5);

    if (mouseX >= displayWidth/20 && mouseX <= displayWidth/20 + width/2 && mouseY >= displayHeight/20 * 2 && mouseY <= displayHeight/20 * 2 + height) {
      sai = true;
    } else {
      sai = false;
    }



    //song 2
    textSize(50);
    text("\u30C4\u30CE\u30EB\u30AD\u30E2\u30C1", displayWidth/20, displayHeight/20 * 5.5);
    textSize(20);
    text("CHiCO with HoneyWorks", displayWidth/20, displayHeight/20 * 6.5);

    if (mouseX >= displayWidth/20 && mouseX <= displayWidth/20 + width/2 && mouseY >= displayHeight/20 * 5 && mouseY <= displayHeight/20 * 5 + height) {
      tsu = true;
    } else {
      tsu = false;
    }

    
  }
}

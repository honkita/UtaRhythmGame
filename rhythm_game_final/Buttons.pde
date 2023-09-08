void mouseClicked() { 


    if (retry == true) {
      score = 0;
      perfect = 0;
      great = 0;
      fast = 0;
      slow = 0;
      miss = 0;
      combo = 0;
      maxcombo = 0;
      y1 = new int[100]; //declare the array  
      y2 = new int[100]; //declare the array  
      y3 = new int[100]; //declare the array  
      y4 = new int[100]; //declare the array
      currentm = millis()/1000;
      rectx = 200;
      
      if (song1 == true) {
        screen = 1;
      }
      if (song2 == true) {
        screen = 2;
      }
    }

    if (home == true) {
      song1 = false;
      song2 = false;
      score = 0;
      perfect = 0;
      great = 0;
      fast = 0;
      slow = 0;
      miss = 0;
      combo = 0;
      screen = 5;
      
    }
  

  if (screen == 5) {

    if (back == true) {
      screen = 4;
    }

    if (sai == true) {
      screen = 1;
      y1 = new int[100]; //declare the array  
      y2 = new int[100]; //declare the array  
      y3 = new int[100]; //declare the array  
      y4 = new int[100]; //declare the array
      currentm = millis()/1000;
      rectx = 200;
    }

    if (tsu == true) {
      screen = 2; 
      y1 = new int[100]; //declare the array  
      y2 = new int[100]; //declare the array  
      y3 = new int[100]; //declare the array  
      y4 = new int[100]; //declare the array
      currentm = millis()/1000;
      rectx = 200;
    }
  }
}

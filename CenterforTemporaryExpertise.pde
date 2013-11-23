import processing.video.*;

Movie[] myMovie = new Movie[9]; 
int movieCount = 9; 

//since the index numbers run from 0-9, this is the way to exit the loop. 
int selectedMovie = -1; 
boolean newMovieSelected = false;
boolean canSelect= true; 

int sw= 200; 
int sh= 200; 
int cols = 3; 
int rows = 3; 

int videoSize= 600; 

void setup() {
  size(600, 600);

  //initialize the first 9 videos, and place them on the matrix 
  for (int i = 0; i < 9; i++) {
    myMovie[i] = new Movie(this, "video" + i + ".mov");
    myMovie[i].loop();
    myMovie[i].jump(1.0);
    myMovie[i].pause();
    println("myMovie" + i + "is doing something");
  }
  printAllMovies();
}

void draw() {

  // Play movie fullscreen
  if (newMovieSelected) {
    image(myMovie[selectedMovie], 0, 0, videoSize, videoSize);

    // When the movie is done
    if (myMovie[selectedMovie].time() == myMovie[selectedMovie].duration()) {
      //Stop playing it
      myMovie[selectedMovie].stop();
      
      //bring it back to the first second frame and pause, before redrawing
      myMovie[selectedMovie].loop();
      myMovie[selectedMovie].jump(1.0);
      myMovie[selectedMovie].pause();

      
      canSelect = true;
      printAllMovies();
      newMovieSelected = false;
    }
  }
}


void mouseClicked() {
  if (canSelect)
  {
    //This indicates where the mouse is clicking and makes the program run through all the movies
    for (int col=0; col <cols; col ++)
      for (int row = 0; row <rows; row++) { 
        int xLeft = col*sw;
        int xRight = xLeft + sw;
        int yTop = row*sh;
        int yBottom = yTop + sh;

        //then, here we create the buttons for the clicking. 
        if (mouseX > xLeft && mouseX < xRight && mouseY > yTop && mouseY < yBottom) {
          selectedMovie = (col + (row *cols));
          println(selectedMovie + " has been CLICKED!!!");
          myMovie[selectedMovie].play();
          newMovieSelected = true;
          canSelect = false;
        }
      }
  }
  else
    println("stop clicking when you cannot click");
}

void printAllMovies() {
  for (int col=0; col <cols; col ++) {
    for (int row = 0; row <rows; row++) { 
      //this figures out where they are in the matrix
      image( myMovie [(col + (row *cols))], (col*sw), (row*sh), sw, sh);
    }
  }
}

void movieEvent(Movie m) {
  m.read();
}



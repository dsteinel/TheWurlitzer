import ddf.minim.*;
import ddf.minim.analysis.*;
 
Minim minim;
AudioInput in;
FFT fft;
/* =========== MINIM ============ */
String note;// name of the note
int n;//int value midi note
color c;//color
float hertz;//frequency in hertz
float midi;//float midi note
int noteNumber;//variable for the midi note
 
int sampleRate= 44100;//sapleRate of 44100
 
float [] max= new float [sampleRate/2];//array that contains the half of the sampleRate size, because FFT only reads the half of the sampleRate frequency. This array will be filled with amplitude values.
float maximum;//the maximum amplitude of the max array
float frequency;//the frequency in hertz
/* ================================= */

int holdFreq = 0;
int theNote = 0;
int noteHit = 0;
int theHitNote = 1;

int numReadings = 10;
float [] readings = new float [numReadings];
int index = 0;
float total = 0;
float average = 0;

void setup()
{
  size(460, 460);
  minim = new Minim(this);
  minim.debugOn();
  in = minim.getLineIn(Minim.MONO, 4096, sampleRate);
  fft = new FFT(in.left.size(), sampleRate);
}
 
void draw()
{
  background(0);//black BG
  drawGrid();
  textSize(20); //size of the text
  fill(0,255,255);
  text (frequency-6+" hz", 10, 20);//display the frequency in hertz
  pushStyle();
  fill(c);
  text ("note "+note, 120, 20);//display the note name
  popStyle();
  /*if (frameCount% (60*0.5) == 0) {
    findNote();
    
    total= total - readings[index];         
    readings[index] = frequency; 
    total= total + readings[index];       
    index = index + 1;                    
  
    if (index >= numReadings) {            
      index = 0;      
    }      
    average = total / numReadings; 
    println(average);
  }*/
}
 
float findNote() {
  fft.forward(in.left);
  for (int f=0;f<sampleRate/2;f++) { //analyses the amplitude of each frequency analysed, between 0 and 22050 hertz
    max[f]=fft.getFreq(float(f)); //each index is correspondent to a frequency and contains the amplitude value 
  }
  maximum=max(max);//get the maximum value of the max array in order to find the peak of volume
 
  for (int i=0; i<max.length; i++) {// read each frequency in order to compare with the peak of volume
    if (max[i] == maximum) {//if the value is equal to the amplitude of the peak, get the index of the array, which corresponds to the frequency
      frequency= i;
    }
  }
  
  total= total - readings[index];         
  readings[index] = frequency; 
  total= total + readings[index];       
  index = index + 1;                    

  if (index >= numReadings) {            
    index = 0;      
  }      
  average = total / numReadings; 
  println(average);
  
  println("frequency" + " " + frequency);
  
  midi= 69+12*(log((frequency-6)/440));// formula that transform frequency to midi numbers
  n= int (midi);//cast to int
 
//the octave have 12 tones and semitones. So, if we get a modulo of 12, we get the note names independently of the frequency  
//println(n);
drawNotes(n);

return frequency;
}

public int drawNotes(float n){
  if (n%12==9)
  {
    note = ("a");
    c = color (255, 0, 0);
    fill(c);
    float drawX = 0;
    rect(drawX, drawX, 40, 40);
    drawX=drawX+60;
    rect(0, drawX, 40, 40);
    rect(drawX, 0, 40, 40);
    rect(drawX, drawX, 40, 40);
  }
 
  if (n%12==10)
  {
    note = ("a#");
    c = color (255, 0, 80);
    fill(c);
    float drawX = 120;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    drawX=drawX+60;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
  }
 
  if (n%12==11)
  {
    note = ("b");
    c = color (255, 0, 150);
    fill(c);
    float drawX = 240;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    drawX=drawX+60;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
  }
 
  if (n%12==0)
  {
    note = ("c");
    holdFreq += 1;
    c = color (200, 0, 255);
    fill(c);
    float drawX = 360;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    drawX=drawX+60;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    if (frameCount% (60*3) == 0) {
      if (holdFreq > 3) {
        /* LÖSE ANIMATION AUS */
      }
      holdFreq=0;
    }
  }
 
  if (n%12==1)
  {
    note = ("c#");
    c = color (100, 0, 255);
    fill(c);
    float drawX = 120;
    rect(0, drawX, 40, 40);
    rect(60, drawX, 40, 40);
    drawX=drawX+60;
    rect(0, drawX, 40, 40);
    rect(60, drawX, 40, 40);
  }
 
  if (n%12==2)
  {
    note = ("d");
    c = color (0, 0, 255);
    fill(c);
    float drawX = 120;
    rect(drawX, drawX, 40, 40);
    rect(180, drawX, 40, 40);
    drawX=drawX+60;
    rect(drawX, drawX, 40, 40);
    rect(120, drawX, 40, 40);
  }
 
  if (n%12==3)
  {
    note = ("d#");
    noteHit = 3;
    c = color (0, 50, 255);
    fill(c);
    float drawX = 120;
    rect(300, drawX, 40, 40);
    rect(240, drawX, 40, 40);
    drawX=drawX+60;
    rect(300, drawX, 40, 40);
    rect(240, drawX, 40, 40);
  }
 
  if (n%12==4)
  {
    note = ("e");
    noteHit = 7;
    c = color (0, 150, 255);
    fill(c);
    float drawX = 120;
    rect(360, drawX, 40, 40);
    rect(420, drawX, 40, 40);
    drawX=drawX+60;
    rect(420, drawX, 40, 40);
    rect(360, drawX, 40, 40);
  }
 
  if (n%12==5)
  {
    note = ("f");
    noteHit = 5;
    c = color (0, 255, 255);
    fill(c);
    float drawX = 240;
    rect(0, drawX, 40, 40);
    rect(60, drawX, 40, 40);
    drawX=drawX+60;
    rect(0, drawX, 40, 40);
    rect(60, drawX, 40, 40);
  }
 
  if (n%12==6)
  {
    note = ("f#");
    noteHit = 6;
    c = color (0, 255, 0);
    fill(c);
    float drawX = 240;
    rect(120, drawX, 40, 40);
    rect(180, drawX, 40, 40);
    drawX=drawX+60;
    rect(180, drawX, 40, 40);
    rect(120, drawX, 40, 40);
  }
 
  if (n%12==7)
  {
    note = ("g");
    noteHit = 1;
    c = color (255, 255, 0);
    fill(c);
    float drawX = 240;
    rect(240, drawX, 40, 40);
    rect(300, drawX, 40, 40);
    drawX=drawX+60;
    rect(240, drawX, 40, 40);
    rect(300, drawX, 40, 40);
  }
 
  if (n%12==8)
  {
    note = ("g#");
    noteHit = 8;
    c = color (255, 150, 0);
    fill(c);
    float drawX = 240;
    rect(360, drawX, 40, 40);
    rect(420, drawX, 40, 40);
    drawX=drawX+60;
    rect(360, drawX, 40, 40);
    rect(420, drawX, 40, 40);
  }
  return noteHit;
}

void drawGrid(){
  //println(noteHit);
  
  float x = 0;
  while (x<width) {
    fill(255);
    float y = 0;
    while(y<height){
      rect(x, y, 40, 40);
      y = y + 60;
    }
    x = x + 60;
  }
  
  findNote(); //find note function
  if (theHitNote == noteHit){
    //println("NOW");
    for(int i = 0; i<480; i=i+60){
      c = color (255, 150, 0);
      fill(c);
      rect(i, i, 40, 40);
    }
  } 
  noteToFind(theHitNote); //should be random!!
}
 
void stop()
{
  // always close Minim audio classes when you are done with them
  in.close();
  minim.stop();
 
  super.stop();
}

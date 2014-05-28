import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 
import ddf.minim.analysis.*; 
import processing.serial.*; 
import cc.arduino.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class sketch_8x8_LampenGolf extends PApplet {






Arduino arduino;
Minim minim;
AudioInput in;
FFT fft;

/* =========== MINIM ============ */
String note; // name of the note
int midiNote; //int value midi note
int prevMidiNote;
int c; //color
float hertz; //frequency in hertz
float midi; //float midi note
int noteNumber; //variable for the midi note

int sampleRate= 44100;

float [] max= new float [sampleRate/2];//array that contains the half of the sampleRate size, because FFT only reads the half of the sampleRate frequency. This array will be filled with amplitude values.
float maximum;//the maximum amplitude of the max array
float frequency;//the frequency in hertz
/* ================================= */
/**** ARDUINO STUFF ****/
int col[] = {
  10, 11, 12, 13, 14, 15, 16, 17
};
int row[] = {
  2, 3, 4, 5, 6, 7, 8, 9
};

int COMPAREFREQUENCY[] = {
  720, 690, 660, 630, 600, 570, 540, 510, 480, 450, 420, 390, 360, 330, 300, 270, 240
};

float freqTeiler = 7.5f;
int HIGHESFREQ = 720;

float ALLFREQS[] = {
  HIGHESFREQ-freqTeiler, HIGHESFREQ-freqTeiler*2, HIGHESFREQ-freqTeiler*3, HIGHESFREQ-freqTeiler*4, 
  HIGHESFREQ-freqTeiler*5, HIGHESFREQ-freqTeiler*6, HIGHESFREQ-freqTeiler*7, HIGHESFREQ-freqTeiler*8, 
  HIGHESFREQ-freqTeiler*9, HIGHESFREQ-freqTeiler*10, HIGHESFREQ-freqTeiler*11, HIGHESFREQ-freqTeiler*12,
  HIGHESFREQ-freqTeiler*13, HIGHESFREQ-freqTeiler*14, HIGHESFREQ-freqTeiler*15, HIGHESFREQ-freqTeiler*16, 
  HIGHESFREQ-freqTeiler*17, HIGHESFREQ-freqTeiler*18, HIGHESFREQ-freqTeiler*19, HIGHESFREQ-freqTeiler*20,
  HIGHESFREQ-freqTeiler*21, HIGHESFREQ-freqTeiler*22, HIGHESFREQ-freqTeiler*23, HIGHESFREQ-freqTeiler*24, 
  HIGHESFREQ-freqTeiler*25, HIGHESFREQ-freqTeiler*26, HIGHESFREQ-freqTeiler*27, HIGHESFREQ-freqTeiler*28, 
  HIGHESFREQ-freqTeiler*29, HIGHESFREQ-freqTeiler*30, HIGHESFREQ-freqTeiler*31, HIGHESFREQ-freqTeiler*32, 
  HIGHESFREQ-freqTeiler*33, HIGHESFREQ-freqTeiler*34, HIGHESFREQ-freqTeiler*35, HIGHESFREQ-freqTeiler*36, 
  HIGHESFREQ-freqTeiler*37, HIGHESFREQ-freqTeiler*38, HIGHESFREQ-freqTeiler*39, HIGHESFREQ-freqTeiler*40, 
  HIGHESFREQ-freqTeiler*41, HIGHESFREQ-freqTeiler*42, HIGHESFREQ-freqTeiler*43, HIGHESFREQ-freqTeiler*44, 
  HIGHESFREQ-freqTeiler*45, HIGHESFREQ-freqTeiler*46, HIGHESFREQ-freqTeiler*47, HIGHESFREQ-freqTeiler*48, 
  HIGHESFREQ-freqTeiler*49, HIGHESFREQ-freqTeiler*50, HIGHESFREQ-freqTeiler*51, HIGHESFREQ-freqTeiler*52, 
  HIGHESFREQ-freqTeiler*53, HIGHESFREQ-freqTeiler*54, HIGHESFREQ-freqTeiler*55, HIGHESFREQ-freqTeiler*56, 
  HIGHESFREQ-freqTeiler*57, HIGHESFREQ-freqTeiler*58, HIGHESFREQ-freqTeiler*59, HIGHESFREQ-freqTeiler*60, 
  HIGHESFREQ-freqTeiler*61, HIGHESFREQ-freqTeiler*62, HIGHESFREQ-freqTeiler*63, HIGHESFREQ-freqTeiler*64
};



/**** OTHER VARS ****/
int theNote = 0;
int noteHit = 0;
int theHitNote = 1;

int numReadings = 10;
float [] readings = new float [numReadings];
int index = 0;
float total = 0;
float average = 0;
float previousFrequency = 0;
float currentFrequency = 0;


public void setup()
{
  size(460, 460);
  minim = new Minim(this);
  minim.debugOn();
  in = minim.getLineIn(Minim.STEREO, 4096, sampleRate);
  fft = new FFT(in.left.size(), sampleRate);
  println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[3], 57600);

  for (int i = 0; i < 8; i++) {
    arduino.pinMode(col[i], Arduino.OUTPUT);
    arduino.pinMode(row[i], Arduino.OUTPUT);
    arduino.digitalWrite(row[i], Arduino.HIGH);
    arduino.digitalWrite(col[i], Arduino.LOW);
  }
}

public void draw()
{
  background(0);
  drawGrid();
  textSize(20);
  fill(0, 255, 255);
  text (frequency-6+" hz", 10, 20);//display the frequency in hertz
  fill(c);
  //text ("note "+note, 120, 20);//display the note name
  
  if (frameCount% (60*1) == 0) {
    findNote();
  }
  noteToFind(theHitNote);

  println(frequency);
  drawNotes(midiNote);
  
  if (theHitNote == noteHit) {
    animation();
  }
}

public void drawGrid() {
  float x = 0;
  while (x<width) {
    fill(255);
    float y = 0;
    while (y<height) {
      rect(x, y, 40, 40);
      y = y + 60;
    }
    x = x + 60;
  }
}

public void stop()
{
  // always close Minim audio classes when you are done with them
  in.close();
  minim.stop();

  super.stop();
}

public void resetLed() {
  arduino.digitalWrite(lastLedArr[0], Arduino.HIGH);
  arduino.digitalWrite(lastLedArr[1], Arduino.LOW);
  arduino.digitalWrite(lastLedArr[2], Arduino.HIGH);
  arduino.digitalWrite(lastLedArr[3], Arduino.LOW);
}

public float findNote() {
  fft.forward(in.left);
  for (int f=0;f<sampleRate/2;f++) { //analyses the amplitude of each frequency analysed, between 0 and 22050 hertz
    max[f]=fft.getFreq(PApplet.parseFloat(f)); //each index is correspondent to a frequency and contains the amplitude value
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
    average = total / numReadings; 
    //println(average);    
    index = 0;
  }      

  midi= 69+14*(log((frequency-6)/440));// formula that transform frequency to midi numbers
  midiNote = PApplet.parseInt (midi);//cast to int
  return frequency;
}
public void noteToFind(int whichNote) {
///////// FOURTH ROW
  println(whichNote);
  if (whichNote == 0) {
    c = color (100, 0, 255);
    fill(c);
    float drawX = 0;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    drawX=drawX+60;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    arduino.digitalWrite(col[6], Arduino.HIGH);
    arduino.digitalWrite(col[7], Arduino.HIGH);
    arduino.digitalWrite(row[7], Arduino.LOW);
    arduino.digitalWrite(row[6], Arduino.LOW);
  }
  if (whichNote == 1) {
    c = color (100, 100, 255);
    fill(c);
    float drawX = 120;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    drawX=drawX+60;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    arduino.digitalWrite(col[6], Arduino.HIGH);
    arduino.digitalWrite(col[7], Arduino.HIGH);
    arduino.digitalWrite(row[4], Arduino.LOW);
    arduino.digitalWrite(row[5], Arduino.LOW);
   }
   if (whichNote == 2) {
    c = color (100, 150, 255);
    fill(c);
    float drawX = 240;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    drawX=drawX+60;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    arduino.digitalWrite(col[6], Arduino.HIGH);
    arduino.digitalWrite(col[7], Arduino.HIGH);
    arduino.digitalWrite(row[3], Arduino.LOW);
    arduino.digitalWrite(row[2], Arduino.LOW);
   }
   if (whichNote == 3) {
    c = color (100, 200, 255);
    fill(c);
    float drawX = 360;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    drawX=drawX+60;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    arduino.digitalWrite(col[6], Arduino.HIGH);
    arduino.digitalWrite(col[7], Arduino.HIGH);
    arduino.digitalWrite(row[1], Arduino.LOW);
    arduino.digitalWrite(row[0], Arduino.LOW);
   }
   
///////// THIRD ROW
   if (whichNote == 4) {
    c = color (255, 255, 0);
    fill(c);
    float drawX = 0;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    drawX=drawX+60;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
   }
   if (whichNote == 5) {
    c = color (255, 200, 0);
    fill(c);
    float drawX = 120;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    drawX=drawX+60;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
   }
   if (whichNote == 6) {
    c = color (255, 130, 0);
    fill(c);
    float drawX = 240;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    drawX=drawX+60;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
   }
   if (whichNote == 7) {
    c = color (255, 90, 0);
    fill(c);
    float drawX = 360;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    drawX=drawX+60;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
   }
   
   ///////// SECOND ROW
   
   if (whichNote == 8) {
    c = color (255, 0, 255);
    fill(c);
    float drawX = 0;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    drawX=drawX+60;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
   }
   if (whichNote == 9) {
    c = color (255, 0, 190);
    fill(c);
    float drawX = 120;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    drawX=drawX+60;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
   }
   if (whichNote == 10) {
    c = color (255, 0, 140);
    fill(c);
    float drawX = 240;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    drawX=drawX+60;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
   }
   if (whichNote == 11) {
    c = color (255, 0, 90);
    fill(c);
    float drawX = 360;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    drawX=drawX+60;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
   }
   
   ///////// FIRST ROW
   
   if (whichNote == 12) {
    c = color (255, 200, 0);
    fill(c);
    float drawX = 0;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    drawX=drawX+60;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
   }
   if (whichNote == 13) {
    c = color (255, 150, 0);
    fill(c);
    float drawX = 120;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    drawX=drawX+60;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
   }
   if (whichNote == 14) {
    c = color (255, 20, 0);
    fill(c);
    float drawX = 240;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    drawX=drawX+60;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
   }
   if (whichNote == 15) {
    c = color (255, 100, 0);
    fill(c);
    float drawX = 360;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    drawX=drawX+60;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
   }
}

public void animationCorrectNote(int number){
  for (int thisrow = 0; thisrow < 8; thisrow++) {
    // Turn on all LEDS
      arduino.digitalWrite(row[thisrow], Arduino.LOW);
      arduino.digitalWrite(col[thisrow], Arduino.HIGH);      
   }
   delay(500);
       for (int thisrow = 0; thisrow < 8; thisrow++) {
    // Turn off all LEDS
      arduino.digitalWrite(row[thisrow], Arduino.HIGH);
      arduino.digitalWrite(col[thisrow], Arduino.LOW);      
   }
}
public int drawNotes(float n) {
  resetLed(); 
  ///////// FIRST ROW
  if (frequency > COMPAREFREQUENCY[1] && frequency <= COMPAREFREQUENCY[0])
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
    arduino.digitalWrite(col[6], Arduino.HIGH);
    arduino.digitalWrite(col[7], Arduino.HIGH);
    arduino.digitalWrite(row[7], Arduino.LOW);
    arduino.digitalWrite(row[6], Arduino.LOW);
  } 
  if (frequency > COMPAREFREQUENCY[2] && frequency <= COMPAREFREQUENCY[1])
  {
    note = ("a");
    c = color (255, 0, 0);
    fill(c);
    float drawX = 120;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    drawX=drawX+60;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    arduino.digitalWrite(col[6], Arduino.HIGH);
    arduino.digitalWrite(col[7], Arduino.HIGH);
    arduino.digitalWrite(row[4], Arduino.LOW);
    arduino.digitalWrite(row[5], Arduino.LOW);
  } 
  if (frequency > COMPAREFREQUENCY[3] && frequency <= COMPAREFREQUENCY[2])
  {
    note = ("a");
    c = color (255, 0, 0);
    fill(c);
    float drawX = 240;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    drawX=drawX+60;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    arduino.digitalWrite(col[6], Arduino.HIGH);
    arduino.digitalWrite(col[7], Arduino.HIGH);
    arduino.digitalWrite(row[2], Arduino.LOW);
    arduino.digitalWrite(row[3], Arduino.LOW);
  } 

  if (frequency > COMPAREFREQUENCY[4] && frequency <= COMPAREFREQUENCY[3])
  {
    note = ("a");
    c = color (255, 0, 0);
    fill(c);
    float drawX = 360;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    drawX=drawX+60;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    arduino.digitalWrite(col[6], Arduino.HIGH);
    arduino.digitalWrite(col[7], Arduino.HIGH);
    arduino.digitalWrite(row[0], Arduino.LOW);
    arduino.digitalWrite(row[1], Arduino.LOW);
  }


  ///////// THIRD ROW

    if (frequency > COMPAREFREQUENCY[8] && frequency <= COMPAREFREQUENCY[7])
  {
    note = ("c#");
    c = color (100, 0, 255);
    fill(c);
    float drawX = 360;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    drawX=drawX+60;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    arduino.digitalWrite(col[4], Arduino.HIGH);
    arduino.digitalWrite(col[5], Arduino.HIGH);
    arduino.digitalWrite(row[0], Arduino.LOW);
    arduino.digitalWrite(row[1], Arduino.LOW);
  }
  if (frequency > COMPAREFREQUENCY[7] && frequency <= COMPAREFREQUENCY[6])
  {
    note = ("c");
    c = color (200, 0, 255);
    fill(c);
    float drawX = 240;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    drawX=drawX+60;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    arduino.digitalWrite(col[4], Arduino.HIGH);
    arduino.digitalWrite(col[5], Arduino.HIGH);
    arduino.digitalWrite(row[2], Arduino.LOW);
    arduino.digitalWrite(row[3], Arduino.LOW);
  }

  if (frequency > COMPAREFREQUENCY[6] && frequency <= COMPAREFREQUENCY[5])
  {
    note = ("b");
    c = color (255, 0, 150);
    fill(c);
    float drawX = 120;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    drawX=drawX+60;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    arduino.digitalWrite(col[4], Arduino.HIGH);
    arduino.digitalWrite(col[5], Arduino.HIGH);
    arduino.digitalWrite(row[4], Arduino.LOW);
    arduino.digitalWrite(row[5], Arduino.LOW);
  }
  if (frequency > COMPAREFREQUENCY[5] && frequency <= COMPAREFREQUENCY[4])
  {
    note = ("a#");
    c = color (255, 0, 80);
    fill(c);
    float drawX = 0;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    drawX=drawX+60;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    arduino.digitalWrite(col[4], Arduino.HIGH);
    arduino.digitalWrite(col[5], Arduino.HIGH);
    arduino.digitalWrite(row[6], Arduino.LOW);
    arduino.digitalWrite(row[7], Arduino.LOW);
  }


  ///////// SECOND ROW
  if (frequency > COMPAREFREQUENCY[9] && frequency <= COMPAREFREQUENCY[8])
  {
    note = ("d");
    c = color (0, 0, 255);
    fill(c);
    float drawX = 0;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    drawX=drawX+60;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    arduino.digitalWrite(col[2], Arduino.HIGH);
    arduino.digitalWrite(col[3], Arduino.HIGH);
    arduino.digitalWrite(row[6], Arduino.LOW);
    arduino.digitalWrite(row[7], Arduino.LOW);
  }
  if (frequency > COMPAREFREQUENCY[10] && frequency <= COMPAREFREQUENCY[9])
  {
    note = ("d#");
    noteHit = 3;
    c = color (0, 50, 255);
    fill(c);
    float drawX = 120;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    drawX=drawX+60;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    arduino.digitalWrite(col[2], Arduino.HIGH);
    arduino.digitalWrite(col[3], Arduino.HIGH);
    arduino.digitalWrite(row[4], Arduino.LOW);
    arduino.digitalWrite(row[5], Arduino.LOW);
  }
  if (frequency > COMPAREFREQUENCY[11] && frequency <= COMPAREFREQUENCY[10])
  {
    note = ("e");
    noteHit = 7;
    c = color (0, 150, 255);
    fill(c);
    float drawX = 240;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    drawX=drawX+60;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    arduino.digitalWrite(col[2], Arduino.HIGH);
    arduino.digitalWrite(col[3], Arduino.HIGH);
    arduino.digitalWrite(row[2], Arduino.LOW);
    arduino.digitalWrite(row[3], Arduino.LOW);
  }
  if (frequency > COMPAREFREQUENCY[12] && frequency <= COMPAREFREQUENCY[11])
  {
    note = ("f");
    noteHit = 5;
    c = color (0, 255, 255);
    fill(c);
    float drawX = 360;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    drawX=drawX+60;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    arduino.digitalWrite(col[2], Arduino.HIGH);
    arduino.digitalWrite(col[3], Arduino.HIGH);
    arduino.digitalWrite(row[0], Arduino.LOW);
    arduino.digitalWrite(row[1], Arduino.LOW);
  }

  ///////// FIRST ROW
  if (frequency > COMPAREFREQUENCY[13] && frequency <= COMPAREFREQUENCY[12])
  {
    note = ("f#");
    noteHit = 6;
    c = color (0, 255, 0);
    fill(c);
    float drawX = 0;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    drawX=drawX+60;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    arduino.digitalWrite(col[0], Arduino.HIGH);
    arduino.digitalWrite(col[1], Arduino.HIGH);
    arduino.digitalWrite(row[6], Arduino.LOW);
    arduino.digitalWrite(row[7], Arduino.LOW);
  }
  if (frequency > COMPAREFREQUENCY[14] && frequency <= COMPAREFREQUENCY[13])
  {
    note = ("g");
    noteHit = 1;
    c = color (255, 255, 0);
    fill(c);
    float drawX = 120;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    drawX=drawX+60;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    arduino.digitalWrite(col[0], Arduino.HIGH);
    arduino.digitalWrite(col[1], Arduino.HIGH);
    arduino.digitalWrite(row[4], Arduino.LOW);
    arduino.digitalWrite(row[5], Arduino.LOW);
  }
  if (frequency > COMPAREFREQUENCY[15] && frequency <= COMPAREFREQUENCY[14])
  {
    note = ("g");
    noteHit = 1;
    c = color (255, 255, 0);
    fill(c);
    float drawX = 240;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    drawX=drawX+60;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    arduino.digitalWrite(col[0], Arduino.HIGH);
    arduino.digitalWrite(col[1], Arduino.HIGH);
    arduino.digitalWrite(row[2], Arduino.LOW);
    arduino.digitalWrite(row[3], Arduino.LOW);
  }
  if (frequency > COMPAREFREQUENCY[16] && frequency <= COMPAREFREQUENCY[15])
  {
    note = ("g");
    noteHit = 1;
    c = color (255, 255, 0);
    fill(c);
    float drawX = 360;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    drawX=drawX+60;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    arduino.digitalWrite(col[0], Arduino.HIGH);
    arduino.digitalWrite(col[1], Arduino.HIGH);
    arduino.digitalWrite(row[0], Arduino.LOW);
    arduino.digitalWrite(row[1], Arduino.LOW);
  } 




  //  if (n%12==9)
  //  {
  //    note = ("g#");
  //    noteHit = 8;
  //    c = color (255, 150, 0);
  //    fill(c);
  //    float drawX = 240;
  //    rect(360, drawX, 40, 40);
  //    rect(420, drawX, 40, 40);
  //    drawX=drawX+60;
  //    rect(360, drawX, 40, 40);
  //    rect(420, drawX, 40, 40);
  //  }
  //
  //  if (n%12==10)
  //  {
  //    note = ("g");
  //    noteHit = 1;
  //    c = color (255, 255, 0);
  //    fill(c);
  //    float drawX = 240;
  //    rect(240, drawX, 40, 40);
  //    rect(300, drawX, 40, 40);
  //    drawX=drawX+60;
  //    rect(240, drawX, 40, 40);
  //    rect(300, drawX, 40, 40);
  //    arduino.digitalWrite(col[2], Arduino.HIGH);
  //    arduino.digitalWrite(col[3], Arduino.HIGH);
  //    arduino.digitalWrite(row[2], Arduino.LOW);
  //    arduino.digitalWrite(row[3], Arduino.LOW);
  //  }
  //
  //  if (n%12==11)
  //  {
  //    note = ("f#");
  //    noteHit = 6;
  //    c = color (0, 255, 0);
  //    fill(c);
  //    float drawX = 240;
  //    rect(120, drawX, 40, 40);
  //    rect(180, drawX, 40, 40);
  //    drawX=drawX+60;
  //    rect(180, drawX, 40, 40);
  //    rect(120, drawX, 40, 40);
  //    arduino.digitalWrite(col[2], Arduino.HIGH);
  //    arduino.digitalWrite(col[3], Arduino.HIGH);
  //    arduino.digitalWrite(row[4], Arduino.LOW);
  //    arduino.digitalWrite(row[5], Arduino.LOW);
  //  }
  //
  //  if (n%12==0)
  //  {
  //    note = ("f");
  //    noteHit = 5;
  //    c = color (0, 255, 255);
  //    fill(c);
  //    float drawX = 240;
  //    rect(0, drawX, 40, 40);
  //    rect(60, drawX, 40, 40);
  //    drawX=drawX+60;
  //    rect(0, drawX, 40, 40);
  //    rect(60, drawX, 40, 40);
  //    arduino.digitalWrite(col[2], Arduino.HIGH);
  //    arduino.digitalWrite(col[3], Arduino.HIGH);
  //    arduino.digitalWrite(row[6], Arduino.LOW);
  //    arduino.digitalWrite(row[7], Arduino.LOW);
  //  }
  //
  //  if (n%12==1)
  //  {
  //    note = ("e");
  //    noteHit = 7;
  //    c = color (0, 150, 255);
  //    fill(c);
  //    float drawX = 120;
  //    rect(360, drawX, 40, 40);
  //    rect(420, drawX, 40, 40);
  //    drawX=drawX+60;
  //    rect(420, drawX, 40, 40);
  //    rect(360, drawX, 40, 40);
  //    arduino.digitalWrite(col[4], Arduino.HIGH);
  //    arduino.digitalWrite(col[5], Arduino.HIGH);
  //    arduino.digitalWrite(row[0], Arduino.LOW);
  //    arduino.digitalWrite(row[1], Arduino.LOW);
  //  }
  //
  //  if (n%12==2)
  //  {
  //    note = ("d#");
  //    noteHit = 3;
  //    c = color (0, 50, 255);
  //    fill(c);
  //    float drawX = 120;
  //    rect(300, drawX, 40, 40);
  //    rect(240, drawX, 40, 40);
  //    drawX=drawX+60;
  //    rect(300, drawX, 40, 40);
  //    rect(240, drawX, 40, 40);
  //    arduino.digitalWrite(col[4], Arduino.HIGH);
  //    arduino.digitalWrite(col[5], Arduino.HIGH);
  //    arduino.digitalWrite(row[2], Arduino.LOW);
  //    arduino.digitalWrite(row[3], Arduino.LOW);
  //  }
  //
  //  if (n%12==3)
  //  {
  //    note = ("d");
  //    c = color (0, 0, 255);
  //    fill(c);
  //    float drawX = 120;
  //    rect(drawX, drawX, 40, 40);
  //    rect(180, drawX, 40, 40);
  //    drawX=drawX+60;
  //    rect(drawX, drawX, 40, 40);
  //    rect(120, drawX, 40, 40);
  //    arduino.digitalWrite(col[4], Arduino.HIGH);
  //    arduino.digitalWrite(col[5], Arduino.HIGH);
  //    arduino.digitalWrite(row[4], Arduino.LOW);
  //    arduino.digitalWrite(row[5], Arduino.LOW);
  //  }
  //
  //  if (n%12==4)
  //  {
  //    note = ("c#");
  //    c = color (100, 0, 255);
  //    fill(c);
  //    float drawX = 120;
  //    rect(0, drawX, 40, 40);
  //    rect(60, drawX, 40, 40);
  //    drawX=drawX+60;
  //    rect(0, drawX, 40, 40);
  //    rect(60, drawX, 40, 40);
  //    arduino.digitalWrite(col[4], Arduino.HIGH);
  //    arduino.digitalWrite(col[5], Arduino.HIGH);
  //    arduino.digitalWrite(row[6], Arduino.LOW);
  //    arduino.digitalWrite(row[7], Arduino.LOW);
  //  }
  //
  //  if (n%12==5)
  //  {
  //    note = ("c");
  //    c = color (200, 0, 255);
  //    fill(c);
  //    float drawX = 360;
  //    rect(drawX, 0, 40, 40);
  //    rect(drawX, 60, 40, 40);
  //    drawX=drawX+60;
  //    rect(drawX, 0, 40, 40);
  //    rect(drawX, 60, 40, 40);
  //    arduino.digitalWrite(col[6], Arduino.HIGH);
  //    arduino.digitalWrite(col[7], Arduino.HIGH);
  //    arduino.digitalWrite(row[0], Arduino.LOW);
  //    arduino.digitalWrite(row[1], Arduino.LOW);
  //  }
  //
  //  if (n%12==6)
  //  {
  //    note = ("b");
  //    c = color (255, 0, 150);
  //    fill(c);
  //    float drawX = 240;
  //    rect(drawX, 0, 40, 40);
  //    rect(drawX, 60, 40, 40);
  //    drawX=drawX+60;
  //    rect(drawX, 0, 40, 40);
  //    rect(drawX, 60, 40, 40);
  //    arduino.digitalWrite(col[6], Arduino.HIGH);
  //    arduino.digitalWrite(col[7], Arduino.HIGH);
  //    arduino.digitalWrite(row[2], Arduino.LOW);
  //    arduino.digitalWrite(row[3], Arduino.LOW);
  //  }
  //
  //  if (n%12==7)
  //  {
  //    note = ("a#");
  //    c = color (255, 0, 80);
  //    fill(c);
  //    float drawX = 120;
  //    rect(drawX, 0, 40, 40);
  //    rect(drawX, 60, 40, 40);
  //    drawX=drawX+60;
  //    rect(drawX, 0, 40, 40);
  //    rect(drawX, 60, 40, 40);
  //    arduino.digitalWrite(col[6], Arduino.HIGH);
  //    arduino.digitalWrite(col[7], Arduino.HIGH);
  //    arduino.digitalWrite(row[4], Arduino.LOW);
  //    arduino.digitalWrite(row[5], Arduino.LOW);
  //  }
  //
  //  if (n%12==8)
  //  {
  //    note = ("a");
  //    c = color (255, 0, 0);
  //    fill(c);
  //    float drawX = 0;
  //    rect(drawX, drawX, 40, 40);
  //    drawX=drawX+60;
  //    rect(0, drawX, 40, 40);
  //    rect(drawX, 0, 40, 40);
  //    rect(drawX, drawX, 40, 40);
  //    arduino.digitalWrite(col[6], Arduino.HIGH);
  //    arduino.digitalWrite(col[7], Arduino.HIGH);
  //    arduino.digitalWrite(row[6], Arduino.LOW);
  //    arduino.digitalWrite(row[7], Arduino.LOW);
  //  } 
  return noteHit;
}

public void animation(){
  println("HELL YEAH");
  theHitNote = (int)random(0,15);
  for(int i = 0; i<8; i++){
    arduino.digitalWrite(col[i], Arduino.HIGH);
    arduino.digitalWrite(row[i], Arduino.LOW);
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "sketch_8x8_LampenGolf" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 
import ddf.minim.analysis.*; 
import ddf.minim.ugens.*; 
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

public class TheWurlitzer extends PApplet {








Arduino arduino;
Minim minim;
AudioInput in;
AudioOutput out;
Oscil       wave;

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
//float frequency;//the frequency in hertz
/* ================================= */
/**** ARDUINO STUFF ****/
int LED[] = {
  1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 
  11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 
  21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 
  31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 
  41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 
  51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 
  61, 62, 63, 64, 65
};

int COMPAREFREQUENCY[] = {
  720, 690, 660, 630, 600, 570, 540, 510, 480, 450, 420, 390, 360, 330, 300, 270, 240
};

float freqTeiler = 7.5f;
int HIGHESFREQ = 720;
int[] lastSingLedArr = new int[4];
int[] lastFindLedArr = new int[4];

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
int currentSingingNote = 0;
int previouscurrentSingingNote = 0;
int noteToHit = 1;
float previousMillis = 0;
float currentMillis;

int numReadings = 2;
float [] readings = new float [numReadings];
int index = 0;
float total = 0;
float average = 0;
float previousFrequency = 0;
float currentFrequency = 0;
int MEASUREFREQHOLD = 0;

int displayTheHitNotes = 1;

public void setup()
{
  size(460, 460);
  minim = new Minim(this);
  arduino = new Arduino(this, Arduino.list()[3], 57600);
  
  minim.debugOn();
  in = minim.getLineIn(Minim.STEREO, 4096, sampleRate);
  out = minim.getLineOut();
  
  wave = new Oscil( 700, 1.5f, Waves.SINE );
  wave.patch( out );
  wave.setWaveform( Waves.SINE );
  wave.setFrequency(0);
  
  fft = new FFT(in.left.size(), sampleRate);

  for (int i = 0; i<65; i++) {
    arduino.pinMode(LED[i], Arduino.OUTPUT);
    arduino.digitalWrite(LED[i], Arduino.LOW);
  } 

}

public void draw()
{
  currentMillis = millis();

  //displayNotesToFind(noteToHit);
  
  if (frameCount% (60*1) == 0) {
    calcFreq();
  }


  if (noteToHit == currentSingingNote) {
    MEASUREFREQHOLD += 1;
    if(MEASUREFREQHOLD == 1)
      previousMillis = currentMillis + 2500;
  }else if(noteToHit != currentSingingNote){
    MEASUREFREQHOLD = 0;
    previousMillis = 0;
  }
  if(MEASUREFREQHOLD >= 1){
    //println("currentMillis: " + currentMillis + "  |  " + "previousMillis: " + previousMillis);
    if (previousMillis - currentMillis < 0) {  
      animation();
      println("NEXT NOTE TO HIT: " + noteToHit);
      wave.setFrequency(0);
      displayNotesToFind(noteToHit);
      delay(5000);
      resetFindLed();
      resetSingingLed();
      resetAllLed();
      println("finished");
    }
  }
  //println("lastSingLedArr" + lastSingLedArr[0] + " " + lastSingLedArr[1]+ " " + lastSingLedArr[2] + " " + lastSingLedArr[3]);
  //println("lastFindLedArr" + lastFindLedArr[0] + " " + lastFindLedArr[1]+ " " + lastFindLedArr[2] + " " + lastFindLedArr[3]);

}

public void drawGrid() {
  float x = 0;
  while (x<width) {
    fill(150);
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
  in.close();
  minim.stop();
  super.stop();
}

public void keyPressed() {
}

public void resetAllLed(){
  for (int i = 0; i < 65; i++) {
    arduino.digitalWrite(LED[i], Arduino.LOW);
  }
}

public float calcFreq() {
  float frequency = 0;

  background(0);
  drawGrid();
  fill(c);


  fft.forward(in.left);
  for (int f=0;f<sampleRate/2;f++) { //analyses the amplitude of each frequency analysed, between 0 and 22050 hertz
    max[f]=fft.getFreq(PApplet.parseFloat(f)); //each index is correspondent to a frequency and contains the amplitude value
  }
  maximum=max(max);//get the maximum value of the max array in order to find the peak of volume

  for (int i=0; i<max.length; i++) {// read each frequency in order to compare with the peak of volume
    if (max[i] == maximum) {//if the value is equal to the amplitude of the peak, get the index of the array, which corresponds to the frequency
      frequency = i;
    }
  }

  total= total - readings[index];         
  readings[index] = frequency; 
  total= total + readings[index];       
  index = index + 1;                    

  if (index >= numReadings) {  
    average = total / numReadings; 
    index = 0;
  }      

  midi= 69+14*(log((frequency-6)/440));// formula that transform frequency to midi numbers
  midiNote = PApplet.parseInt (midi);//cast to int
  if(readings[0] != readings[1]){
    resetSingingLed();
    displaySingingNotes(frequency);
  }

  textSize(20);
  fill(0, 255, 255);
  text (frequency-6+" hz", 10, 20);//display the frequency in hertz
  
  return frequency;
}
public void resetFindLed(){
  arduino.digitalWrite(LED[lastFindLedArr[0]], Arduino.LOW);
  arduino.digitalWrite(LED[lastFindLedArr[1]], Arduino.LOW);
  arduino.digitalWrite(LED[lastFindLedArr[2]], Arduino.LOW);
  arduino.digitalWrite(LED[lastFindLedArr[3]], Arduino.LOW);
  println("RESET");
}

public void displayNotesToFind(int whichNote) {
///////// FOURTH ROW
  resetFindLed();
  resetAllLed();
  //println(whichNote);
  println("CALL");

  if (whichNote == 0) {
    c = color (100, 0, 255);
    fill(c);
    float drawX = 0;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    drawX=drawX+60;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    lastFindLedArr[0] = 0;
    lastFindLedArr[1] = 1;
    lastFindLedArr[2] = 2;
    lastFindLedArr[3] = 3;
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
    lastFindLedArr[0] = 4;
    lastFindLedArr[1] = 5;
    lastFindLedArr[2] = 6;
    lastFindLedArr[3] = 7;
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
    lastFindLedArr[0] = 8;
    lastFindLedArr[1] = 9;
    lastFindLedArr[2] = 10;
    lastFindLedArr[3] = 11;
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
    lastFindLedArr[0] = 12;
    lastFindLedArr[1] = 13;
    lastFindLedArr[2] = 14;
    lastFindLedArr[3] = 15;
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
    lastFindLedArr[0] = 16;
    lastFindLedArr[1] = 17;
    lastFindLedArr[2] = 18;
    lastFindLedArr[3] = 19;
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
    lastFindLedArr[0] = 20;
    lastFindLedArr[1] = 21;
    lastFindLedArr[2] = 22;
    lastFindLedArr[3] = 23;
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
    lastFindLedArr[0] = 24;
    lastFindLedArr[1] = 25;
    lastFindLedArr[2] = 26;
    lastFindLedArr[3] = 27;
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
    lastFindLedArr[0] = 28;
    lastFindLedArr[1] = 29;
    lastFindLedArr[2] = 30;
    lastFindLedArr[3] = 31;
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
    lastFindLedArr[0] = 32;
    lastFindLedArr[1] = 33;
    lastFindLedArr[2] = 34;
    lastFindLedArr[3] = 35;
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
    lastFindLedArr[0] = 36;
    lastFindLedArr[1] = 37;
    lastFindLedArr[2] = 38;
    lastFindLedArr[3] = 39;
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
    lastFindLedArr[0] = 40;
    lastFindLedArr[1] = 41;
    lastFindLedArr[2] = 42;
    lastFindLedArr[3] = 43;
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
    lastFindLedArr[0] = 44;
    lastFindLedArr[1] = 45;
    lastFindLedArr[2] = 46;
    lastFindLedArr[3] = 47;
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
    lastFindLedArr[0] = 48;
    lastFindLedArr[1] = 49;
    lastFindLedArr[2] = 50;
    lastFindLedArr[3] = 51;
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
    lastFindLedArr[0] = 52;
    lastFindLedArr[1] = 53;
    lastFindLedArr[2] = 54;
    lastFindLedArr[3] = 55;
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
    lastFindLedArr[0] = 56;
    lastFindLedArr[1] = 57;
    lastFindLedArr[2] = 58;
    lastFindLedArr[3] = 59;
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
    lastFindLedArr[0] = 60;
    lastFindLedArr[1] = 61;
    lastFindLedArr[2] = 62;
    lastFindLedArr[3] = 63;
}
    
  arduino.digitalWrite(LED[lastFindLedArr[0]], Arduino.HIGH); // COL
  arduino.digitalWrite(LED[lastFindLedArr[1]], Arduino.HIGH); // COL
  arduino.digitalWrite(LED[lastFindLedArr[2]], Arduino.HIGH);  // ROW
  arduino.digitalWrite(LED[lastFindLedArr[3]], Arduino.HIGH);  // ROW

  displayTheHitNotes = 0;
}


public void resetSingingLed() {
  arduino.digitalWrite(LED[lastSingLedArr[0]], Arduino.LOW);
  arduino.digitalWrite(LED[lastSingLedArr[1]], Arduino.LOW);
  arduino.digitalWrite(LED[lastSingLedArr[2]], Arduino.LOW);
  arduino.digitalWrite(LED[lastSingLedArr[3]], Arduino.LOW);
  wave.setFrequency( 0 );
}

public int displaySingingNotes(float frequency) {
  ///////// FIRST ROW
  resetSingingLed();

  if (frequency > COMPAREFREQUENCY[1] && frequency <= COMPAREFREQUENCY[0] || frequency > COMPAREFREQUENCY[0])
  {
    currentSingingNote = 0;
    c = color (255, 0, 0);
    fill(c);
    float drawX = 0;
    rect(drawX, drawX, 40, 40);
    drawX=drawX+60;
    rect(0, drawX, 40, 40);
    rect(drawX, 0, 40, 40);
    rect(drawX, drawX, 40, 40);
    lastSingLedArr[0] = 64;
    lastSingLedArr[1] = 63;
    lastSingLedArr[2] = 56;
    lastSingLedArr[3] = 55;
  } 
  if (frequency > COMPAREFREQUENCY[2] && frequency <= COMPAREFREQUENCY[1])
  {
    currentSingingNote = 1;
    c = color (255, 0, 0);
    fill(c);
    float drawX = 120;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    drawX=drawX+60;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    lastSingLedArr[0] = 62;
    lastSingLedArr[1] = 61;
    lastSingLedArr[2] = 54;
    lastSingLedArr[3] = 53;
  } 
  if (frequency > COMPAREFREQUENCY[3] && frequency <= COMPAREFREQUENCY[2])
  {
    currentSingingNote = 2;
    c = color (255, 0, 0);
    fill(c);
    float drawX = 240;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    drawX=drawX+60;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    lastSingLedArr[0] = 60;
    lastSingLedArr[1] = 59;
    lastSingLedArr[2] = 52;
    lastSingLedArr[3] = 51;
  } 

  if (frequency > COMPAREFREQUENCY[4] && frequency <= COMPAREFREQUENCY[3])
  {
    currentSingingNote = 3;
    c = color (255, 0, 0);
    fill(c);
    float drawX = 360;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    drawX=drawX+60;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    lastSingLedArr[0] = 58;
    lastSingLedArr[1] = 57;
    lastSingLedArr[2] = 48;
    lastSingLedArr[3] = 49;
  }

  ///////// THIRD ROW
  if (frequency > COMPAREFREQUENCY[5] && frequency <= COMPAREFREQUENCY[4])
  {
    currentSingingNote = 4;
    c = color (255, 0, 80);
    fill(c);
    float drawX = 0;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    drawX=drawX+60;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    lastSingLedArr[0] = 56;
    lastSingLedArr[1] = 55;
    lastSingLedArr[2] = 47;
    lastSingLedArr[3] = 46;
  }
  if (frequency > COMPAREFREQUENCY[6] && frequency <= COMPAREFREQUENCY[5])
  {
    currentSingingNote = 5;
    c = color (255, 0, 150);
    fill(c);
    float drawX = 120;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    drawX=drawX+60;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    lastSingLedArr[0] = 54;
    lastSingLedArr[1] = 53;
    lastSingLedArr[2] = 45;
    lastSingLedArr[3] = 44;
  }
  if (frequency > COMPAREFREQUENCY[7] && frequency <= COMPAREFREQUENCY[6])
  {
    currentSingingNote = 6;
    c = color (200, 0, 255);
    fill(c);
    float drawX = 240;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    drawX=drawX+60;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    lastSingLedArr[0] = 52;
    lastSingLedArr[1] = 51;
    lastSingLedArr[2] = 43;
    lastSingLedArr[3] = 42;
  }
  if (frequency > COMPAREFREQUENCY[8] && frequency <= COMPAREFREQUENCY[7])
  {
    currentSingingNote = 7;
    c = color (100, 0, 255);
    fill(c);
    float drawX = 360;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    drawX=drawX+60;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    lastSingLedArr[0] = 50;
    lastSingLedArr[1] = 49;
    lastSingLedArr[2] = 41;
    lastSingLedArr[3] = 40;
  }

  ///////// SECOND ROW
  if (frequency > COMPAREFREQUENCY[9] && frequency <= COMPAREFREQUENCY[8])
  {
    currentSingingNote = 8;
    c = color (0, 0, 255);
    fill(c);
    float drawX = 0;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    drawX=drawX+60;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    lastSingLedArr[0] = 48;
    lastSingLedArr[1] = 47;
    lastSingLedArr[2] = 39;
    lastSingLedArr[3] = 38;
  }
  if (frequency > COMPAREFREQUENCY[10] && frequency <= COMPAREFREQUENCY[9])
  {
    currentSingingNote = 9;
    c = color (0, 50, 255);
    fill(c);
    float drawX = 120;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    drawX=drawX+60;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    lastSingLedArr[0] = 46;
    lastSingLedArr[1] = 45;
    lastSingLedArr[2] = 37;
    lastSingLedArr[3] = 36;
  }
  if (frequency > COMPAREFREQUENCY[11] && frequency <= COMPAREFREQUENCY[10])
  {
    currentSingingNote = 10;
    c = color (0, 150, 255);
    fill(c);
    float drawX = 240;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    drawX=drawX+60;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    lastSingLedArr[0] = 44;
    lastSingLedArr[1] = 43;
    lastSingLedArr[2] = 35;
    lastSingLedArr[3] = 34;
  }
  if (frequency > COMPAREFREQUENCY[12] && frequency <= COMPAREFREQUENCY[11])
  {
    currentSingingNote = 11;
    c = color (0, 255, 255);
    fill(c);
    float drawX = 360;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    drawX=drawX+60;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    lastSingLedArr[0] = 42;
    lastSingLedArr[1] = 41;
    lastSingLedArr[2] = 33;
    lastSingLedArr[3] = 32;
  }

  ///////// FIRST ROW
  if (frequency > COMPAREFREQUENCY[13] && frequency <= COMPAREFREQUENCY[12])
  {
    currentSingingNote = 12;
    c = color (0, 255, 0);
    fill(c);
    float drawX = 0;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    drawX=drawX+60;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    lastSingLedArr[0] = 40;
    lastSingLedArr[1] = 39;
    lastSingLedArr[2] = 31;
    lastSingLedArr[3] = 30;
  }
  if (frequency > COMPAREFREQUENCY[14] && frequency <= COMPAREFREQUENCY[13])
  {
    currentSingingNote = 13;
    c = color (255, 255, 0);
    fill(c);
    float drawX = 120;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    drawX=drawX+60;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    lastSingLedArr[0] = 38;
    lastSingLedArr[1] = 37;
    lastSingLedArr[2] = 29;
    lastSingLedArr[3] = 28;
  }
  if (frequency > COMPAREFREQUENCY[15] && frequency <= COMPAREFREQUENCY[14])
  {
    currentSingingNote = 14;
    c = color (255, 255, 0);
    fill(c);
    float drawX = 240;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    drawX=drawX+60;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    lastSingLedArr[0] = 36;
    lastSingLedArr[1] = 35;
    lastSingLedArr[2] = 27;
    lastSingLedArr[3] = 26;
  }
  if (frequency > COMPAREFREQUENCY[16] && frequency <= COMPAREFREQUENCY[15] || frequency < COMPAREFREQUENCY[16])
  {
    currentSingingNote = 15;
    c = color (255, 255, 0);
    fill(c);
    float drawX = 360;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    drawX=drawX+60;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    lastSingLedArr[0] = 34;
    lastSingLedArr[1] = 33;
    lastSingLedArr[2] = 25;
    lastSingLedArr[3] = 24;
  } 

  arduino.digitalWrite(LED[lastSingLedArr[0]], Arduino.HIGH); // COL
  arduino.digitalWrite(LED[lastSingLedArr[1]], Arduino.HIGH); // COL
  arduino.digitalWrite(LED[lastSingLedArr[2]], Arduino.HIGH);  // ROW
  arduino.digitalWrite(LED[lastSingLedArr[3]], Arduino.HIGH);  // ROW
  
  return currentSingingNote;
}

public void animation(){
  println("HELL YEAH");
  noteToHit = (int)random(0,15);
  
  println("NEW NOTE:" + " " + noteToHit);
  for (int i = 0; i < 64; i++) {
    arduino.digitalWrite(LED[i], Arduino.HIGH);
  }

  for (int i = 0; i < 20; i++) {
    int randomFreqToPlay = (int)random(0, 63);
    int randomLED = (int)random(0, 63);
    wave.setAmplitude( 1 );
    wave.setFrequency( ALLFREQS[randomFreqToPlay] );
    println(randomFreqToPlay);
    arduino.digitalWrite(LED[randomLED], Arduino.HIGH);
    delay(300);
    resetAllLed();
    delay(100);
  }

  //displayNotesToFind(noteToHit);
//  for(int y = 0; y<height; y += 60){
//    for(int x = 0; x<width; x += 60){
//      background(0);
//      rect(x, y, 40, 40);
//      rect(x, y, 40, 40);
//      delay(100);
//    }
//  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "TheWurlitzer" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}

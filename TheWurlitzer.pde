import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;

import processing.serial.*;
import cc.arduino.*;

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
color c; //color
float hertz; //frequency in hertz
float midi; //float midi note
int noteNumber; //variable for the midi note

int sampleRate= 44100;

float [] max= new float [sampleRate/2];//array that contains the half of the sampleRate size, because FFT only reads the half of the sampleRate frequency. This array will be filled with amplitude values.
float maximum;//the maximum amplitude of the max array
//float frequency;//the frequency in hertz
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

float freqTeiler = 7.5;
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

void setup()
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

  for (int i = 0; i < 8; i++) {
    arduino.pinMode(col[i], Arduino.OUTPUT);
    arduino.pinMode(row[i], Arduino.OUTPUT);
    arduino.digitalWrite(row[i], Arduino.HIGH);
    arduino.digitalWrite(col[i], Arduino.LOW);
  }

}

void draw()
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

void drawGrid() {
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

void stop()
{
  in.close();
  minim.stop();
  super.stop();
}

void keyPressed() {
  for (int i = 0; i < 8; i++) {
    arduino.digitalWrite(row[i], Arduino.HIGH);
    arduino.digitalWrite(col[i], Arduino.LOW);
  }
}

void resetAllLed(){
  for (int i = 0; i < 8; i++) {
    arduino.digitalWrite(row[i], Arduino.HIGH);
    arduino.digitalWrite(col[i], Arduino.LOW);
  }
}


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

int ledBlinkState = 0;
float previousBlinkMillis = 0.0f;

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

float frequency = 0;

/* ================================= */
/**** ARDUINO STUFF ****/
// int LED[] = {
//   2, 3, 4, 5, 6, 7, 8, 9, 
//   10, 11, 12, 13, 14, 15, 16, 17, 
//   18, 19, 20, 21, 22, 23, 24, 25, 
//   26, 27, 28, 29, 30, 31, 32, 33, 
//   34, 35, 36, 37, 38, 39, 40, 41,
//   42, 43, 44, 45, 46, 47, 48, 49, 
//   50, 51, 52, 53, 54, 55, 56, 57, 
//   58, 59, 60, 61, 62, 63, 64, 65
// };

int LED[] = {
  2, 3, 4, 5, 6, 7, 8, 9, 
  10, 11, 12, 13, 14, 15, 16, 17, 
  18, 19, 20, 21, 22, 23, 24, 25, 
  26, 27, 28, 29, 30, 31, 32, 33, 
  34, 35, 36, 37, 38, 39, 40, 41,
  42, 43, 44, 45, 46, 47, 48, 49, 
  50, 51, 52, 53, 69, 68, 67, 66,
  65, 64, 63, 62, 61, 60, 59, 58
};

int FREQUENCY_TO_HIT[] = {
  220, 246, 261, 293, 329, 349, 392, 440, 493, 523, 587, 659, 698, 784
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
int currentSingingNote = 0;
int previouscurrentSingingNote = 0;
int noteToHit = 1;
float previousMillis = 0;
float currentMillis;
float timeToHoldTheFreq = 2500;

int numReadings = 2;
float [] readings = new float [numReadings];
int index = 0;
float total = 0;
float average = 0;
float previousFrequency = 0;
float currentFrequency = 0;
int MEASUREFREQHOLD = 0;
boolean startGame = true;
boolean playHitTone = true;

int hitTollerance = 0;
boolean youHitIt = false;

public void setup()
{
  size(460, 460);
  minim = new Minim(this);
  arduino = new Arduino(this, Arduino.list()[3], 57600);
  
  //minim.debugOn();
  in = minim.getLineIn(Minim.STEREO, 4096, sampleRate);
  out = minim.getLineOut();
  
  wave = new Oscil( 700, 1.5f, Waves.SINE );
  wave.patch( out );
  wave.setWaveform( Waves.SINE );
  wave.setFrequency(0);
  
  fft = new FFT(in.left.size(), sampleRate);

  for (int i = 0; i < 64; i++) {
    arduino.pinMode(LED[i], Arduino.OUTPUT);
    arduino.digitalWrite(LED[i], Arduino.LOW);
  } 
}

public void draw()
{
  /* TEST LEDS */
// for (int i = 0; i<64; i++) {
//   arduino.digitalWrite(LED[i], Arduino.HIGH);
//   delay(100);
//   arduino.digitalWrite(LED[i], Arduino.LOW);
// }
arduino.pinMode(2, Arduino.OUTPUT);
arduino.digitalWrite(2, Arduino.LOW);

  // currentMillis = millis();

  // if (startGame) 
  // {
  //   noteToHit = (int)random(0,13);
  //   displayNotesToFind();
  //   startGame = false;
  //   println("noteToHit: "+noteToHit);
  // }
  
  // if (frameCount% (60*0.6) == 0) {
  //   calcFreq();
  // }

  // if (youHitIt)
  // {
  //   MEASUREFREQHOLD += 1;

  //   if(MEASUREFREQHOLD == 1){
  //     previousMillis = currentMillis + timeToHoldTheFreq;
  //     resetAllLed();
  //   }
    
  //   println(previousMillis);
  //   if (previousMillis - currentMillis > timeToHoldTheFreq - timeToHoldTheFreq/8) 
  //   {
  //     for (int i = 2; i < 10; ++i) {
  //       arduino.digitalWrite(i, Arduino.HIGH);
  //     }
  //   }
  //   else if (previousMillis - currentMillis > timeToHoldTheFreq - timeToHoldTheFreq/8*2) 
  //   {
  //     for (int i = 11; i < 18; ++i) {
  //       arduino.digitalWrite(i, Arduino.HIGH);
  //     }
  //   }
  //   else if (previousMillis - currentMillis > timeToHoldTheFreq - timeToHoldTheFreq/8*3) 
  //   {
  //     for (int i = 18; i < 26; ++i) {
  //       arduino.digitalWrite(i, Arduino.HIGH);
  //     }
  //   }
  //   else if (previousMillis - currentMillis > timeToHoldTheFreq - timeToHoldTheFreq/8*4) 
  //   {
  //     for (int i = 26; i < 33; ++i) {
  //       arduino.digitalWrite(i, Arduino.HIGH);
  //     }
  //   }
  //   else if (previousMillis - currentMillis > timeToHoldTheFreq - timeToHoldTheFreq/8*5) 
  //   {
  //     for (int i = 33; i < 42; ++i) {
  //       arduino.digitalWrite(i, Arduino.HIGH);
  //     }
  //   }
  //   else if (previousMillis - currentMillis > timeToHoldTheFreq - timeToHoldTheFreq/8*6) 
  //   {
  //     for (int i = 42; i < 49; ++i) {
  //       arduino.digitalWrite(i, Arduino.HIGH);
  //     }
  //   }
  //   else if (previousMillis - currentMillis > timeToHoldTheFreq - timeToHoldTheFreq/8*7) 
  //   {
  //     for (int i = 49; i < 58; ++i) {
  //       arduino.digitalWrite(i, Arduino.HIGH);
  //     }
  //   }
  //   else if (previousMillis - currentMillis > timeToHoldTheFreq - timeToHoldTheFreq/8*8) 
  //   {
  //     for (int i = 58; i < 65; ++i) {
  //       arduino.digitalWrite(i, Arduino.HIGH);
  //     }
  //   }
  // }
  // else if (!youHitIt){
  //   MEASUREFREQHOLD = 0;
  //   previousMillis = 0;
  // }

  // else if(frequency != FREQUENCY_TO_HIT[noteToHit] || youHitIt == false)
  // {
  //   MEASUREFREQHOLD = 0;
  //   previousMillis = 0;
  //   previousBlinkMillis = 0;
  // }
  
  // if(MEASUREFREQHOLD >= 1 && previousMillis - currentMillis < 0)
  // {
  //   println("HIT!");
  
  //   animation();
  //   wave.setFrequency(0);

  //   resetSingingLed();

  //   noteToHit = (int)random(0,13);
  //   println("NEXT NOTE TO HIT: " + noteToHit);

  //   delay(2000);
  //   displayNotesToFind();
    
  //   println("finished");
  // }
}

public void roadToAnimation(float frequency){
  resetSingingLed();
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
  resetSingingLed();
  //resetAllLed();
  // displayNotesToFind();
  println("RESET SINGING LED");  
}

public void resetAllLed(){
  for (int i = 0; i < 64; i++) {
    arduino.digitalWrite(LED[i], Arduino.LOW);
  }
}

public void resetSingingLed(){
  for (int i = 0; i < 64; i++) {
    arduino.digitalWrite(LED[i], Arduino.LOW);
  }
  arduino.digitalWrite(LED[27], Arduino.HIGH);
  arduino.digitalWrite(LED[28], Arduino.HIGH);
  arduino.digitalWrite(LED[35], Arduino.HIGH);
  arduino.digitalWrite(LED[36], Arduino.HIGH);
}

public void calcFreq() {

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

  readings[index] = frequency; 
  index = index + 1;                    

  if (index >= numReadings) {  
    average = total / numReadings; 
    index = 0;
  }      

  if (frequency > 200 && frequency < 800) {
    midi= 69+14*(log((frequency-6)/440));// formula that transform frequency to midi numbers
    midiNote = PApplet.parseInt (midi);
    if(readings[0] != readings[1]){
      resetSingingLed();
    }
    else {
      displaySingingNotes(frequency);
    }
  }
  

  textSize(20);
  fill(0, 255, 255);
  text (frequency-6+" hz", 10, 20);//display the frequency in hertz
  
}
public void resetFindLed(){
    arduino.digitalWrite(lastFindLedArr[0], Arduino.LOW);
    arduino.digitalWrite(lastFindLedArr[1], Arduino.LOW);
    arduino.digitalWrite(lastFindLedArr[2], Arduino.LOW);
    arduino.digitalWrite(lastFindLedArr[3], Arduino.LOW);
    println("RESET FIND LED");
}

public void displayNotesToFind() {
    
    arduino.digitalWrite(29, Arduino.HIGH);
    arduino.digitalWrite(30, Arduino.HIGH);
    arduino.digitalWrite(37, Arduino.HIGH);
    arduino.digitalWrite(38, Arduino.HIGH);

    if (playHitTone) {
        wave.setAmplitude( 3 );
        println("ALLFREQS[noteToHit]: "+FREQUENCY_TO_HIT[noteToHit]);
        wave.setFrequency( FREQUENCY_TO_HIT[noteToHit] );
        delay(2000);
        wave.setAmplitude( 0 );   
        playHitTone = false;      
    }
}


public int displaySingingNotes(float frequency) {
  ///////// FOURTH ROW

  println("frequency: " + frequency);
  hitTollerance = FREQUENCY_TO_HIT[noteToHit]*5/100;
  println("hitTollerance: "+hitTollerance);


  if (frequency > FREQUENCY_TO_HIT[noteToHit] - (FREQUENCY_TO_HIT[noteToHit]*20)/100 && frequency < FREQUENCY_TO_HIT[noteToHit] || 
    frequency > FREQUENCY_TO_HIT[noteToHit] && frequency < FREQUENCY_TO_HIT[noteToHit]+(FREQUENCY_TO_HIT[noteToHit]*20)/100)
  {
    outerRing();
    delay(300);

    if (frequency > FREQUENCY_TO_HIT[noteToHit] - (FREQUENCY_TO_HIT[noteToHit]*15)/100 && frequency < FREQUENCY_TO_HIT[noteToHit] || 
    frequency > FREQUENCY_TO_HIT[noteToHit] && frequency < FREQUENCY_TO_HIT[noteToHit] + (FREQUENCY_TO_HIT[noteToHit]*15)/100)
    {
      middleRing();
      delay(300);

      if (frequency > FREQUENCY_TO_HIT[noteToHit] - (FREQUENCY_TO_HIT[noteToHit]*7.5f)/100 && frequency < FREQUENCY_TO_HIT[noteToHit] || 
      frequency > FREQUENCY_TO_HIT[noteToHit] && frequency < FREQUENCY_TO_HIT[noteToHit] + (FREQUENCY_TO_HIT[noteToHit]*7.5f)/100)
      {
        innerRing();
        delay(300);
        if (frequency > FREQUENCY_TO_HIT[noteToHit]-hitTollerance && frequency < FREQUENCY_TO_HIT[noteToHit]+hitTollerance)
        {
          youHitIt = true;   
        }
      }
    }
  }
 
  else if (frequency < FREQUENCY_TO_HIT[noteToHit] - (FREQUENCY_TO_HIT[noteToHit]*20)/100 || 
    frequency > FREQUENCY_TO_HIT[noteToHit] + (FREQUENCY_TO_HIT[noteToHit]*20)/100)
  {
    resetSingingLed();
    youHitIt = false;
  }
  return currentSingingNote;
}


public void outerRing(){
  for (int left = 2; left < 10; left++) {
    arduino.digitalWrite(left, Arduino.HIGH);
  }
  for (int down = 10; down < 59; down = down + 8) {
    arduino.digitalWrite(down, Arduino.HIGH);
  }
  for (int right = 59; right < 66; right++) {
    arduino.digitalWrite(right, Arduino.HIGH);
  }
  for (int up = 17; up < 65; up = up + 8) {
    arduino.digitalWrite(up, Arduino.HIGH);
  }
}
public void middleRing(){
  for (int left = 11; left < 18; left++) {
    arduino.digitalWrite(left, Arduino.HIGH);
  }
  for (int down = 19; down < 52; down = down + 8) {
    arduino.digitalWrite(down, Arduino.HIGH);
  }
  for (int right = 52; right < 57; right++) {
    arduino.digitalWrite(right, Arduino.HIGH);
  }
  for (int up = 16; up < 59; up = up + 8) {
    arduino.digitalWrite(up, Arduino.HIGH);
  }
}

public void innerRing(){
  for (int left = 20; left < 24; left++) {
    arduino.digitalWrite(left, Arduino.HIGH);
  }
  for (int down = 20; down < 45; down = down + 8) {
    arduino.digitalWrite(down, Arduino.HIGH);
  }
  for (int right = 45; right < 48; right++) {
    arduino.digitalWrite(right, Arduino.HIGH);
  }
  for (int up = 24; up < 49; up = up + 8) {
    arduino.digitalWrite(up, Arduino.HIGH);
  }
}
public void animation(){
  println("HELL YEAH");

  for (int i = 0; i < 20; i++) {
    int randomFreqToPlay = (int)random(0, 63);
    int randomDelay = (int)random(100, 300);
    int randomLED = (int)random(0, 63);
    wave.setAmplitude( 3 );
    wave.setFrequency( ALLFREQS[randomFreqToPlay] );
    println(randomFreqToPlay);
    arduino.digitalWrite(LED[randomLED], Arduino.HIGH);
    delay(randomDelay);
    resetAllLed();
    delay(100);
    playHitTone = true;
    youHitIt = false;
  }
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

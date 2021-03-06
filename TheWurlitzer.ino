#include "notes.h"
#include <TimedAction.h>

/**************** FREQ COUNTER ****************/
volatile unsigned long firstPulseTime;
volatile unsigned long lastPulseTime;
volatile unsigned long numPulses;
unsigned int timeToMeasure = 50;
/* ================================= */

/**** ARDUINO STUFF ****/

const int LED[] = {
  69, 3, 4, 5, 6, 7, 8, 9, 
  10, 11, 12, 13, 14, 15, 16, 17,
  18, 19, 20, 21, 22, 23, 24, 25, 
  26, 27, 28, 29, 30, 31, 32, 33, 
  34, 35, 36, 66, 38, 39, 40, 41, 
  42, 43, 44, 45, 46, 47, 48, 49, 
  50, 51, 52, 53, 54, 55, 56, 57, 
  58, 59, 60, 61, 62, 63, 64, 65
};

const int FREQUENCY_TO_HIT[] = {
  220, 246, 261, 293, 329, 349, 392, 440, 493, 523, 587, 659, 698, 784
};

const int PLAY_THE_HIT_NOTE[] = {
  NOTE_A3, NOTE_B3, NOTE_C4, NOTE_D4, NOTE_E4, NOTE_F4, NOTE_G4, NOTE_A4, NOTE_B4, NOTE_C5, NOTE_D5, 
  NOTE_E5, NOTE_F5, NOTE_G5
};

const int ledAnimation[] = {
  B10000001,B10000010,B10000100,B10001000,B10100000,B11000000,B11100000,B11010000,
  B11001000,B11000100,B11000010,B11000001,B11101000,B11100101,B11100001,B11100001,
  B11110000,B11110100,B11110010,B11110001,B11001001,B11100101,B10110110,B11011001,
  B10000000,B10010000,B10000000,B10000000,B10110010,B10110011,B10010000,B11011011,
  B10011000,B10100100,B10000000,B10111001,B10001110,B10001110,B10100100,B10111010,
  B10000101,B10011011,B10111000,B10001110,B11001110,B10011010,B10010010,B11111111
};

const int melody[] = {
  NOTE_C4, NOTE_CS4, NOTE_D4, NOTE_DS4, NOTE_E4, NOTE_F4, NOTE_FS4, NOTE_G4, NOTE_GS4, NOTE_A4, NOTE_AS4, NOTE_B4
};

const int noteDurations[] = {
  4, 8, 8, 4, 4 , 8 , 8 , 4, 4, 8, 8, 4, 4 , 8 , 8 , 4,4, 4, 8, 8, 4, 4 , 8 , 8 ,4,
  4, 4, 8, 8, 4, 4 , 8 , 8 ,4 
};

/**** OTHER VARS ****/
boolean startGame = true;
boolean disableFirstLevel = false;
boolean noOneSings = true;
const int resetFaderMaxValue = 10;

int currentLevel = 0;
int currentSingingNote = 0;
int noteToHit;

int maxCounterValue = 10;
int littleCounter = 0;
int levelOneSinging = 0;
int levelTwoSinging = 0;

int resetFader = 0; 
boolean readyForNext = true;

int hitTollerance = 0;

TimedAction timedAction = TimedAction(20000,playToneAgain);

void setup()
{
  Serial.begin(9600);
  for (int i = 0; i < 65; i++) {
    pinMode(LED[i], OUTPUT);
    digitalWrite(LED[i], LOW);
  }
  randomSeed(analogRead(13));
}

void loop()
{
  displaySingingNotes();
  if (startGame) 
  {
    noteToHit = random(0,13);
    currentLevel = 1;
    tone(68, FREQUENCY_TO_HIT[noteToHit], 1000);
    delay(1000);
    noTone(68);
    startGame = false;
  }

  if(noOneSings){
    timedAction.check();
    Serial.println("HERHEHR");
  }
  displayNotesToFind(currentLevel);
}

void allLedOn(){
  // digital pins - PORTE = 0,1 & 4 sind PIN 2,1,0
  PORTA = B11111111;
  PORTB = B11111111;
  PORTC = B11111111;
  PORTD = B11111111;
  PORTE = B11101100;
  PORTF = B11111111;
  PORTG = B11111111;
  PORTH = B11111111;
  PORTJ = B11111111;
  PORTL = B11111111;
  //analog pins
  PORTF = B11111111;
  PORTK = B11111111;
}

void playToneAgain(){
  tone(68, FREQUENCY_TO_HIT[noteToHit], 1000);
  delay(1000);
  noTone(68);
}


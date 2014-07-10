#include "notes.h"

/**************** FREQ COUNTER ****************/
volatile unsigned long firstPulseTime;
volatile unsigned long lastPulseTime;
volatile unsigned long numPulses;
unsigned int timeToMeasure = 250;
/* ================================= */

int ledBlinkState = 0;
float previousBlinkMillis = 0.0;
byte incomingByte;

/**** ARDUINO STUFF ****/

int LED[] = {
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

/***** MELODY *****/
 int melodyNotes[] = {
   NOTE_B0, NOTE_C1, NOTE_CS1, NOTE_D1, NOTE_DS1, NOTE_E1, NOTE_F1, NOTE_FS1, 
   NOTE_G1, NOTE_GS1, NOTE_A1, NOTE_AS1, NOTE_B1, NOTE_C2, NOTE_CS2, NOTE_D2,  
   NOTE_DS2, NOTE_E2, NOTE_F2, NOTE_FS2, NOTE_G2, NOTE_GS2, NOTE_A2, NOTE_AS2, 
   NOTE_B2, NOTE_C3, NOTE_CS3, NOTE_D3, NOTE_DS3, NOTE_E3, NOTE_F3, NOTE_FS3, 
   NOTE_G3, NOTE_GS3, NOTE_A3, NOTE_AS3, NOTE_B3, NOTE_C4, NOTE_CS4, NOTE_D4,  
   NOTE_DS4, NOTE_E4, NOTE_F4, NOTE_FS4, NOTE_G4, NOTE_GS4, NOTE_A4, NOTE_AS4, 
   NOTE_B4, NOTE_C5, NOTE_CS5, NOTE_D5, NOTE_DS5, NOTE_E5, NOTE_F5, NOTE_FS5, 
   NOTE_G5, NOTE_GS5, NOTE_A5, NOTE_AS5, NOTE_B5, NOTE_C6, NOTE_CS6, NOTE_D6
 };

const int melody[] = {
  NOTE_G4, NOTE_G4,NOTE_G4, NOTE_E4, NOTE_B4,NOTE_G4, NOTE_E4, NOTE_B4, NOTE_G4};


const int noteDurations[] = {
  4, 8, 8, 4, 4 , 8 , 8 , 4 };


/**** OTHER VARS ****/

int currentLevel = 0;
int currentSingingNote = 0;
int previouscurrentSingingNote = 0;
int noteToHit;

int currentMillis = 0;
int repeatMillis = 0;
int timeToRepeat = 5000;

boolean startGame = true;

int hitTollerance = 0;
boolean youHitIt = false;

int currentFreq;

int timetoHoldFreq = 1000;


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
  /* TEST LEDS */
   
  //allLedOn();

  unsigned long currentMillis = millis();

  if (startGame) 
  {
    //noteToHit = random(0,13);
    noteToHit = 5;
    repeatMillis = currentMillis + timeToRepeat;


    displaySingingNotes(currentLevel);

    currentLevel = 1;
    for (int i = 0; i < 65; ++i) {
      digitalWrite(LED[i], HIGH);
    }
    tone(68, PLAY_THE_HIT_NOTE[noteToHit], 1000);
    // displayNotesToFind(currentLevel);
    delay(1000);
    noTone(68);
    startGame = false;
  }
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
  PORTK = B10111111;
}


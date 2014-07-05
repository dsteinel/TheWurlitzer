 #include "notes.h"

/**************** FREQ COUNTER ****************/
volatile unsigned long firstPulseTime;
volatile unsigned long lastPulseTime;
volatile unsigned long numPulses;
unsigned int timeToMeasure = 10;
/* ================================= */

int ledBlinkState = 0;
float previousBlinkMillis = 0.0;

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

int FREQUENCY_TO_HIT[] = {
  220, 246, 261, 293, 329, 349, 392, 440, 493, 523, 587, 659, 698, 784
};

int HIGHESFREQ = 720;

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


/**** OTHER VARS ****/
int currentSingingNote = 0;
int previouscurrentSingingNote = 0;
int noteToHit = 1;
float previousMillis = 0;
float currentMillis;
float timeToHoldTheFreq = 2500;

int index = 0;
int MEASUREFREQHOLD = 0;
boolean startGame = true;
boolean playHitTone = true;

int hitTollerance = 0;
boolean youHitIt = false;

int currentFreq;
int usableFreq;

void setup()
{
  Serial.begin(9600);
  for (int i = 0; i < 65; i++) {
    pinMode(LED[i], OUTPUT);
    digitalWrite(LED[i], LOW);
  } 
}

void loop()
{
  /* TEST LEDS */
//    for (int i = 0; i<65; i++) {
//      digitalWrite(LED[i], HIGH);
//      delay(250);
//      digitalWrite(LED[i], LOW);
//    }
  

  int frequency = readFrequency(timeToMeasure);
  currentMillis = millis();

  if (startGame) 
  {
    //    noteToHit = (int)random(0,13);
    noteToHit = 5;
    displayNotesToFind();
    startGame = false;
  }

  //  displaySingingNotes();



  /***** OUTER RING *****/
  Serial.println(frequency);
  hitTollerance = FREQUENCY_TO_HIT[noteToHit]*5/100;
  //  Serial.println(FREQUENCY_TO_HIT[noteToHit]);


  if (frequency > FREQUENCY_TO_HIT[noteToHit] - (FREQUENCY_TO_HIT[noteToHit]*20)/100 && frequency < FREQUENCY_TO_HIT[noteToHit] || 
    frequency > FREQUENCY_TO_HIT[noteToHit] && frequency < FREQUENCY_TO_HIT[noteToHit]+(FREQUENCY_TO_HIT[noteToHit]*20)/100)
  {
    outerRing();


    if (frequency > FREQUENCY_TO_HIT[noteToHit] - (FREQUENCY_TO_HIT[noteToHit]*15)/100 && frequency < FREQUENCY_TO_HIT[noteToHit] || 
      frequency > FREQUENCY_TO_HIT[noteToHit] && frequency < FREQUENCY_TO_HIT[noteToHit] + (FREQUENCY_TO_HIT[noteToHit]*15)/100)
    {

      middleRing();

      frequency = readFrequency(timeToMeasure);

      if (frequency > FREQUENCY_TO_HIT[noteToHit] - (FREQUENCY_TO_HIT[noteToHit]*7.5)/100 && frequency < FREQUENCY_TO_HIT[noteToHit] || 
        frequency > FREQUENCY_TO_HIT[noteToHit] && frequency < FREQUENCY_TO_HIT[noteToHit] + (FREQUENCY_TO_HIT[noteToHit]*7.5)/100)
      {

        innerRing();

        frequency = readFrequency(timeToMeasure);

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

  if (youHitIt)
  {
    Serial.println("YEAH");
    MEASUREFREQHOLD += 1;

    if(MEASUREFREQHOLD == 1){
      previousMillis = currentMillis + timeToHoldTheFreq;
      resetAllLed();
    }

    if (previousMillis - currentMillis > timeToHoldTheFreq - timeToHoldTheFreq/8) 
    {
      for (int i = 2; i < 10; ++i) {
        digitalWrite(i, HIGH);
        digitalWrite(LED[0], HIGH);
      }
    }
    else if (previousMillis - currentMillis > timeToHoldTheFreq - timeToHoldTheFreq/8*2) 
    {
      for (int i = 11; i < 18; ++i) {
        digitalWrite(i, HIGH);
      }
    }
    else if (previousMillis - currentMillis > timeToHoldTheFreq - timeToHoldTheFreq/8*3) 
    {
      for (int i = 18; i < 26; ++i) {
        digitalWrite(i, HIGH);
      }
    }
    else if (previousMillis - currentMillis > timeToHoldTheFreq - timeToHoldTheFreq/8*4) 
    {
      for (int i = 26; i < 33; ++i) {
        digitalWrite(i, HIGH);
      }
    }
    else if (previousMillis - currentMillis > timeToHoldTheFreq - timeToHoldTheFreq/8*5) 
    {
      for (int i = 33; i < 42; ++i) {
        digitalWrite(i, HIGH);
      }
    }
    else if (previousMillis - currentMillis > timeToHoldTheFreq - timeToHoldTheFreq/8*6) 
    {
      for (int i = 42; i < 49; ++i) {
        digitalWrite(i, HIGH);
      }
    }
    else if (previousMillis - currentMillis > timeToHoldTheFreq - timeToHoldTheFreq/8*7) 
    {
      for (int i = 49; i < 58; ++i) {
        digitalWrite(i, HIGH);
      }
    }
    else if (previousMillis - currentMillis > timeToHoldTheFreq - timeToHoldTheFreq/8*8) 
    {
      for (int i = 58; i < 65; ++i) {
        digitalWrite(i, HIGH);
      }
    }
  }
  else if (!youHitIt){
    MEASUREFREQHOLD = 0;
    previousMillis = 0;
  }

  else if(currentFreq != FREQUENCY_TO_HIT[noteToHit] || youHitIt == false)
  {
    MEASUREFREQHOLD = 0;
    previousMillis = 0;
    previousBlinkMillis = 0;
  }

  if(MEASUREFREQHOLD >= 1 && previousMillis - currentMillis < 0)
  {
    Serial.println("HIT!");

    animation();

    resetSingingLed();

    noteToHit = (int)random(0,13);
    Serial.println("NEXT NOTE TO HIT: " + noteToHit);

    delay(2000);
    displayNotesToFind();

    Serial.println("finished");
  }
}


void roadToAnimation(float frequency){
  resetSingingLed();
}

void resetAllLed(){
  for (int i = 0; i < 64; i++) {
    digitalWrite(LED[i], LOW);
  }
}

void resetSingingLed(){
  for (int i = 0; i < 64; i++) {
    digitalWrite(LED[i], LOW);
  }
  digitalWrite(LED[27], HIGH);
  digitalWrite(LED[28], HIGH);
  digitalWrite(LED[36], HIGH);
  digitalWrite(LED[35], HIGH);

}






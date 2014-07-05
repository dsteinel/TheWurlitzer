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
  3, 4, 5, 6, 7, 8, 9, 
  10, 11, 12, 13, 14, 15, 16, 17, 
  18, 19, 20, 21, 22, 23, 24, 25, 
  26, 27, 28, 29, 30, 31, 32, 33, 
  34, 35, 36, 37, 38, 39, 40, 41,
  42, 43, 44, 45, 46, 47, 48, 49, 
  50, 51, 52, 53, 54, 55, 56, 57,
  58, 59, 60, 61, 62, 63, 64, 65
};

int FREQUENCY_TO_HIT[] = {
  220, 246, 261, 293, 329, 349, 392, 440, 493, 523, 587, 659, 698, 784
};

float freqTeiler = 7.5;
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
  for (int i = 0; i < 63; i++) {
    pinMode(LED[i], OUTPUT);
    digitalWrite(LED[i], LOW);
  } 
}

void loop()
{
  /* TEST LEDS */
//  for (int i = 0; i<64; i++) {
//    digitalWrite(LED[i], HIGH);
//    delay(250);
//    digitalWrite(LED[i], LOW);
//  }


  currentMillis = millis();

  if (startGame) 
  {
//    noteToHit = (int)random(0,13);
    noteToHit = 5;
    displayNotesToFind();
    startGame = false;
  }

  displaySingingNotes(readFrequency(timeToMeasure));
  

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
    digitalWrite(29, HIGH);
    digitalWrite(30, HIGH);
    digitalWrite(37, HIGH);
    digitalWrite(38, HIGH);
}



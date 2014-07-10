/****** if equal = youHitIt = true ********/

void displaySingingNotes() {
  int singingLevel = 0;
  int maxFreqLoop = 5;
  int averageFreq;
  int hitTollerance = FREQUENCY_TO_HIT[noteToHit]*7/100;
  int frequency = readFrequency(timeToMeasure);
<<<<<<< HEAD
=======

>>>>>>> 8fdf2bb06ea7f44bde81846be9464d8bf6ac9fbf
  Serial.println(frequency);

  for(int i; i<maxFreqLoop; i++){
   frequencyArray[i] = readFrequency(timeToMeasure);
   int sumFrequencyValue += frequencyArray[i];
   if(i == maxFreqLoop){
    averageFreq = sumFrequencyValue/maxFreqLoop;
  }
}

Serial.print("averageFreq: ");
Serial.println(averageFreq);


if (frequency > (FREQUENCY_TO_HIT[noteToHit] - 150) || frequency < (FREQUENCY_TO_HIT[noteToHit] + 150))
{
  youHitIt = false;
}

/********* TOO LOW *********/

if (frequency > (FREQUENCY_TO_HIT[noteToHit] - 150) && frequency < (FREQUENCY_TO_HIT[noteToHit] - 100))
{
  singingLevel = 1;
} 

if (frequency > (FREQUENCY_TO_HIT[noteToHit]) - 100 && frequency < (FREQUENCY_TO_HIT[noteToHit] - 50))
{
  singingLevel = 2;
}

if (frequency > (FREQUENCY_TO_HIT[noteToHit] - 50) && frequency < (FREQUENCY_TO_HIT[noteToHit] - hitTollerance))
{
  singingLevel = 3;
}

/********* TOO HIGH *********/

if(frequency < (FREQUENCY_TO_HIT[noteToHit] + 150) && frequency > (FREQUENCY_TO_HIT[noteToHit] + 100))
{
  singingLevel = 4;
}

if(frequency < (FREQUENCY_TO_HIT[noteToHit] + 100) && frequency > (FREQUENCY_TO_HIT[noteToHit] + 50))
{
  singingLevel = 5;
}

if(frequency < (FREQUENCY_TO_HIT[noteToHit] + 50) && frequency > (FREQUENCY_TO_HIT[noteToHit] + hitTollerance))
{
  singingLevel = 6;
}

if(frequency < (FREQUENCY_TO_HIT[noteToHit] - 150) || frequency > (FREQUENCY_TO_HIT[noteToHit] + 150))
{
  resetSingingLed(currentLevel);
}

singingLEDLevel(singingLevel);

/********* IF HIT *********/

if(frequency >= (FREQUENCY_TO_HIT[noteToHit] - hitTollerance) && 
  frequency < (FREQUENCY_TO_HIT[noteToHit] + hitTollerance))
{
  /********** DO SOME FANCY STUFF **********/
  for (int i = 0; i < 65; ++i) {
    digitalWrite(LED[i], HIGH);
  }
  /* ================================= */
  Serial.print("currentMillis");
  Serial.println(millis());
  Serial.print("previous");
  Serial.println(millis());

  if ((millis() - repeatMillis) > timetoHoldFreq)
  {
    repeatMillis = millis();

    Serial.println("HIT!");
    animation();

    resetSingingLed(currentLevel);

    noteToHit = (int)random(0,13);
    Serial.println("NEXT NOTE TO HIT: " + noteToHit);
    currentLevel++;

    delay(2000);

    displayNotesToFind(currentLevel);

    if(currentLevel > 4){
      currentLevel = 1;
        //finishAnimation();
      }
    }
    //return currentSingingNote;
  }

  else
  repeatMillis = millis();
}

void singingLEDLevel(int tooHighTooLow){
  resetSingingLed(currentLevel);

  /********* TOO LOW *********/
  switch (tooHighTooLow) {
    // case 0:
    // break;
    case 1:
    /**** FIRST ROW ****/
    PORTK = B10000000; // P69
    PORTB = B00011000; // P10 && P50
    PORTD = B00001000; // P18
    PORTA = B00010000; // P26
    PORTC = B00001000; // P34
    PORTL = B10000000; // P42
    PORTF = B00010000; // P58
    break;

    case 2:
    /**** FIRST ROW ****/
    PORTK = B10000000; // P69
    PORTB = B00011000; // P10 && P50
    PORTD = B00001000; // P18
    PORTA = B00010000; // P26
    PORTC = B00001000; // P34
    PORTL = B10000000; // P42
    PORTF = B00010000; // P58


    /**** SECOND ROW ****/
    PORTE = B00100000; // P3
    PORTB = B00100100; // P11 && 51
    PORTD = B00000100; // P19
    PORTA = B00100000; // P27
    PORTC = B00000100; // P35
    PORTL = B01000000; // P43
    PORTF = B00100000; // P59

    break;

    case 3:
    /**** FIRST ROW ****/
    PORTK = B10000000; // P69
    PORTB = B00011000; // P10 && P50
    PORTD = B00001000; // P18
    PORTA = B00010000; // P26
    PORTC = B00001000; // P34
    PORTL = B10000000; // P42
    PORTF = B00010000; // P58


    /**** SECOND ROW ****/
    PORTE = B00100000; // P3
    PORTB = B00100100; // P11 && 51
    PORTD = B00000100; // P19
    PORTA = B00100000; // P27
    PORTC = B00000100; // P35
    PORTL = B01000000; // P43
    PORTF = B00100000; // P59

    /**** THIRD ROW ****/
    PORTG = B00100000; // P4
    PORTB = B01000010; // P12 && 52
    PORTD = B00000010; // P20
    PORTA = B01000000; // P28
    PORTC = B00000010; // P36
    PORTL = B00100000; // P44
    PORTF = B01000000; // P60

    break;


    /********* TOO HIGH *********/
    case 4:
    
    /**** EIGHTH ROW ****/
    PORTH = B01000001; // P9 && P17
    PORTA = B00001000; // P25
    PORTC = B00010000; // P33
    PORTG = B00000001; // P41
    PORTL = B00000001; // P49
    PORTF = B00001000; // P57
    PORTK = B00001000; // P65
    break;

    case 5:
    /**** EIGHTH ROW ****/
    PORTH = B01000001; // P9 && P17
    PORTA = B00001000; // P25
    PORTC = B00010000; // P33
    PORTG = B00000001; // P41
    PORTL = B00000001; // P49
    PORTF = B00001000; // P57
    PORTK = B00001000; // P65

    /**** SEVENTH  ROW ****/
    PORTH = B00100010; // P8 && P16
    PORTA = B00000100; // P24
    PORTC = B00100000; // P32
    PORTG = B00000010; // P40
    PORTL = B00000010; // P48
    PORTF = B00000100; // P56
    PORTK = B00000100; // P64

    case 6:
    /**** SIXTH  ROW ****/
    PORTH = B00010000; // P7
    PORTJ = B00000010; // P15
    PORTA = B00000010; // P23
    PORTC = B01000000; // P31
    PORTK = B00010010; // P66 && P63
    PORTL = B00000100; // P47
    PORTF = B00000010; // P55
    break;

    default:
    for(int i=0; i<65; i++){
        digitalWrite(LED[i], LOW);
    }
  }
}





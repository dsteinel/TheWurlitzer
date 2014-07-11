/****** if equal = youHitIt = true ********/

void displaySingingNotes() {
  int hitTollerance = FREQUENCY_TO_HIT[noteToHit]*7/100;
  int frequency = readFrequency(timeToMeasure);

  // Serial.println(frequency);

  if(frequency == 0){
  // levelOneSinging = 0;
  // levelTwoSinging = 0;
    resetSingingLed(currentLevel);
  }
  /********* TOO LOW *********/

  if (frequency > (FREQUENCY_TO_HIT[noteToHit] - 150) && frequency < (FREQUENCY_TO_HIT[noteToHit] - 100))
  {
    levelOneSinging = 1;
    levelTwoSinging = 1;
    littleCounter = maxCounterValue;
    resetFader = resetFaderMaxValue;
  } 

  if (frequency > (FREQUENCY_TO_HIT[noteToHit]) - 100 && frequency < (FREQUENCY_TO_HIT[noteToHit] - 50))
  {
    levelOneSinging = 2;
    levelTwoSinging = 2;
    littleCounter = maxCounterValue;
    resetFader = resetFaderMaxValue;
  }

  if (frequency > (FREQUENCY_TO_HIT[noteToHit] - 50) && frequency < (FREQUENCY_TO_HIT[noteToHit] - hitTollerance))
  {
    levelOneSinging = 3;
    levelTwoSinging = 3;
    littleCounter = maxCounterValue;
    resetFader = resetFaderMaxValue;
  }

  /********* TOO HIGH *********/

  if(frequency < (FREQUENCY_TO_HIT[noteToHit] + 150) && frequency > (FREQUENCY_TO_HIT[noteToHit] + 100))
  {
    levelOneSinging = 4;
    levelTwoSinging = 1;
    littleCounter = maxCounterValue;
    resetFader = resetFaderMaxValue;
  }

  if(frequency < (FREQUENCY_TO_HIT[noteToHit] + 100) && frequency > (FREQUENCY_TO_HIT[noteToHit] + 50))
  {
    levelOneSinging = 5;
    levelTwoSinging = 2;
    littleCounter = maxCounterValue;
    resetFader = resetFaderMaxValue;
  }

  if(frequency < (FREQUENCY_TO_HIT[noteToHit] + 50) && frequency > (FREQUENCY_TO_HIT[noteToHit] + hitTollerance))
  {
    levelOneSinging = 6;
    levelTwoSinging = 3;
    littleCounter = maxCounterValue;
    resetFader = resetFaderMaxValue;
  }

  if(frequency < (FREQUENCY_TO_HIT[noteToHit] - 150) || frequency > (FREQUENCY_TO_HIT[noteToHit] + 150))
  {
    resetSingingLed(currentLevel);
    littleCounter = maxCounterValue;
  }

  /********* IF HIT *********/
  if(frequency >= (FREQUENCY_TO_HIT[noteToHit] - hitTollerance) && 
    frequency < (FREQUENCY_TO_HIT[noteToHit] + hitTollerance))
  {
    littleCounter--;
    if(littleCounter == 0){
      allLedOn();
      levelOneSinging = 7; 
      levelTwoSinging = 4;   
    }    
  }
  singingLEDLevel(levelOneSinging);
}

void singingLEDLevel(int tooHighTooLow){
  /********* TOO LOW *********/
  if(!disableFirstLevel){
    switch (tooHighTooLow) {
      case 0:
      resetSingingLed(currentLevel);
      break;

      case 1:
      /**** FIRST ROW ****/
      PORTK = B11000000; // P69
      PORTB = B00011000; // P10 && P50
      PORTD = B00001000; // P18
      PORTA = B00010000; // P26
      PORTC = B00001000; // P34
      PORTL = B10000000; // P42
      PORTF = B00010000; // P58
      break;

      case 2:
      /**** FIRST ROW ****/ /**** SECOND ****/ /**** THIRD ****/
      PORTK = B11000000; // P69             
      PORTB = B00111100; // P10 && P50      || P11 && 51        ||
      PORTD = B00001100; // P18             || P19
      PORTA = B00110000; // P26             || P27
      PORTC = B00001100; // P34             || P34
      PORTL = B11000000; // P42             || P43
      PORTF = B00110000; // P58             || P59
      PORTE = B00100000; // P3 
      break;

      case 3:

      /**** FIRST ROW ****/ /**** SECOND ****/ /**** THIRD ****/
      PORTK = B11000000; // P69             || P66
      PORTB = B01111110; // P10 && P50      || P11 && 51        || P12 && 52
      PORTD = B00001110; // P18             || P19              || P20
      PORTA = B01110000; // P26             || P27              || P28
      PORTC = B00001110; // P34             || P35              || P36
      PORTL = B11100000; // P42             || P43              || P44
      PORTF = B01110000; // P58             || P59              || P60
      PORTE = B00100000; // P3 
      PORTG = B00100000; //                 ||                  || P4
      break;


      /********* TOO HIGH *********/
      case 4:
      
      /**** EIGHT ROW ****/ /**** SEVENTH ****/ /**** SIXTH ****/
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
      PORTH = B01100011; // P9 && P17
      PORTA = B00001100; // P25
      PORTC = B00110000; // P33
      PORTG = B00000011; // P41
      PORTL = B00000011; // P49
      PORTF = B00001100; // P57
      PORTK = B00001100; // P65
      break;

      case 6:
      /**** SIXTH  ROW ****/
      PORTH = B01110011; // P9 && P17
      PORTJ = B00000001; // P9 && P17
      PORTA = B00001110; // P25
      PORTC = B01110000; // P33
      PORTG = B00000111; // P41
      PORTL = B00000111; // P49
      PORTF = B00001110; // P57
      PORTK = B00001110; // P65
      break;

      case 7:
      animation();
      break;  
    }
  }
  else if(disableFirstLevel){
    tooHighTooLow = 3;
    switch (levelTwoSinging) {
      case 0:
      resetSingingLed(currentLevel);
      break;

      case 1:
      /**** FIRST ROW ****/
      PORTH = B01111001;
      PORTE = B00101000;
      PORTG = B00100001;
      PORTK = B11001111;
      PORTA = B00011000;
      PORTC = B00011000;
      PORTL = B10000001;
      PORTF = B11111000;
      PORTB = B00011000;
      PORTD = B00001000;
      break;

      case 2:
      /**** FIRST ROW ****/ /**** SECOND ****/ /**** THIRD ****/
      PORTH = B00000010;
      PORTJ = B00000011;
      PORTE = B00000000;
      PORTG = B00000010;
      PORTK = B00000000;
      PORTA = B00100100;
      PORTC = B00100100;
      PORTL = B01000010;
      PORTF = B00000111;
      PORTB = B11100111;
      PORTD = B00000100;      
      break;

      case 3:
      allLedOn();
      PORTH = B00000000;
      PORTJ = B00000000;
      PORTE = B00000000;
      PORTG = B00000100;
      PORTK = B00000000;
      PORTA = B01000011;
      PORTC = B01000010;
      PORTL = B00111100;
      PORTF = B00000000;
      PORTB = B00000000;
      PORTD = B00000011;
      break;

      case 4:
      animation();
      break; 
  }
  }
}

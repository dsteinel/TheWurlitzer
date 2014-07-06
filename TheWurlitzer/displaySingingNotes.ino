/****** if equal = youHitIt = true ********/

int displaySingingNotes(int frequency) {
  int singingLevel = 0;
  int hitTollerance = FREQUENCY_TO_HIT[noteToHit]*10/100;
  int holdFreqCounter = 0;
  
  Serial.print("FREQUENCY_TO_HIT");
  Serial.println(FREQUENCY_TO_HIT[noteToHit]);
  Serial.println(frequency);
  
  if (frequency < FREQUENCY_TO_HIT[noteToHit] - hitTollerance && frequency > FREQUENCY_TO_HIT[noteToHit] - 150)
  {
    Serial.println("THIS IS FIRST");
    singingLevel = 1;

    if (frequency < FREQUENCY_TO_HIT[noteToHit] - hitTollerance && frequency > FREQUENCY_TO_HIT[noteToHit] - 100)
    {
      Serial.println("THIS IS SECOND");
      singingLevel = 2;

      if (frequency < FREQUENCY_TO_HIT[noteToHit] - hitTollerance && frequency > FREQUENCY_TO_HIT[noteToHit] - 50)
      {
        Serial.println("THIS IS THIRD");
        singingLevel = 3;
      }
    }
    hitTimer = 0;
    youHitIt = false;
  }

  if(frequency > FREQUENCY_TO_HIT[noteToHit] + hitTollerance && frequency < FREQUENCY_TO_HIT[noteToHit] + 150)
  {
    singingLevel = 4;

    if(frequency > FREQUENCY_TO_HIT[noteToHit] + hitTollerance && frequency < FREQUENCY_TO_HIT[noteToHit] + 100)
    {
      singingLevel = 5;

      if(frequency > FREQUENCY_TO_HIT[noteToHit] + hitTollerance && frequency < FREQUENCY_TO_HIT[noteToHit] + 50)
      {
        singingLevel = 6;
      }
    }
    hitTimer = 0;
    youHitIt = false;
  }
//
//  else 
//    resetSingingLed(currentLevel);

  singingLEDLevel(singingLevel);


  if(frequency == FREQUENCY_TO_HIT[noteToHit] || frequency >= FREQUENCY_TO_HIT[noteToHit] - hitTollerance &&
    frequency <= FREQUENCY_TO_HIT[noteToHit] + hitTollerance)
  {
    Serial.println("YEAH");
    hitTimer++;
    Serial.print("holdFreqCounter");
    Serial.println(hitTimer);

    for (int i = 0; i < 65; ++i) {
      digitalWrite(LED[i], HIGH);
    }
    
  }
  else
    hitTimer = 0;

  if(hitTimer == 5)
  {
    Serial.println("HIT!");
    hitTimer = 0;
   animation();

    resetSingingLed(currentLevel);

    noteToHit = (int)random(0,13);
    Serial.println("NEXT NOTE TO HIT: " + noteToHit);
    currentLevel++;
    delay(2000);

    displayNotesToFind(currentLevel);

    if(currentLevel > 4){
      /* BLA BLA */
      finishAnimation();
    }
  }
  return currentSingingNote;
}

void singingLEDLevel(int tooHighTooLow){
  resetSingingLed(currentLevel);

  switch (tooHighTooLow) {
  case 1:
    for (int index = 0; index < 63; index = index + 8) {
      digitalWrite(LED[index], HIGH);
    }  
    break;

  case 2:
    for (int index = 0; index < 63; index = index + 8) {
      digitalWrite(LED[index], HIGH);
    } 
    for (int index = 1; index < 62; index = index + 8) {
      digitalWrite(LED[index], HIGH);
    }
    break;

  case 3:
    for (int index = 2; index < 61; index = index + 8) {
      digitalWrite(LED[index], HIGH);
    } 
    for (int index = 1; index < 62; index = index + 8) {
      digitalWrite(LED[index], HIGH);
    }
    for (int index = 0; index < 63; index = index + 8) {
      digitalWrite(LED[index], HIGH);
    }
    break;

  case 4:
    for (int index = 7; index < 66; index = index + 8) {
      digitalWrite(LED[index], HIGH);
    }          
    break;

  case 5:
    for (int index = 7; index < 66; index = index + 8) {
      digitalWrite(LED[index], HIGH);
    }  
    for (int index = 6; index < 65; index = index + 8) {
      digitalWrite(LED[index], HIGH);
    }
    break;

  case 6:
    for (int index = 7; index < 66; index = index + 8) {
      digitalWrite(LED[index], HIGH);
    }  
    for (int index = 6; index < 65; index = index + 8) {
      digitalWrite(LED[index], HIGH);
    }
    for (int index = 5; index < 64; index = index + 8) {
      digitalWrite(LED[index], HIGH);
    }
    break;
  }
}




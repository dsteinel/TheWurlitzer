/****** if equal = youHitIt = true ********/

void displaySingingNotes() {
  int singingLevel = 0;
  int hitTollerance = FREQUENCY_TO_HIT[noteToHit]*7/100;
  
  int frequency = readFrequency(timeToMeasure);

  Serial.print("FREQUENCY_TO_HIT");
  Serial.println(FREQUENCY_TO_HIT[noteToHit]);
  Serial.println(frequency);
  
  if (frequency > (FREQUENCY_TO_HIT[noteToHit] - 150 || frequency < FREQUENCY_TO_HIT[noteToHit] + 150))
  {
    hitTimer = 0;
    youHitIt = false;
  }

  /********* TOO LOW *********/

  if (frequency > (FREQUENCY_TO_HIT[noteToHit] - 150))
  {
    singingLevel = 1;
  } 
  if (frequency > (FREQUENCY_TO_HIT[noteToHit] - 100))
  {
    singingLevel = 2;
  }

  if (frequency > (FREQUENCY_TO_HIT[noteToHit] - 50))
  {
    singingLevel = 3;
  }

  /********* TOO HIGH *********/

  if(frequency < (FREQUENCY_TO_HIT[noteToHit] + 150))
  {
    singingLevel = 4;
  }

  if(frequency < (FREQUENCY_TO_HIT[noteToHit] + 100))
  {
    singingLevel = 5;
  }

  if(frequency < (FREQUENCY_TO_HIT[noteToHit] + 50))
  {
    singingLevel = 6;
  }
  singingLEDLevel(singingLevel);

  else 
  resetSingingLed(currentLevel);


  /********* IF HIT *********/

  if(frequency >= (FREQUENCY_TO_HIT[noteToHit] - hitTollerance) || 
    frequency < (FREQUENCY_TO_HIT[noteToHit] + hitTollerance))
  {
    hitTimer++;

    Serial.print("hitTimer");
    Serial.println(hitTimer);

    /********** DO SOME FANCY STUFF **********/
    for (int i = 0; i < 65; ++i) {
      digitalWrite(LED[i], HIGH);
    }
    /* ================================= */

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
        finishAnimation();
      }
    }

    /********* IF NO HIT *********/
    else
    hitTimer = 0;
  }
  //return currentSingingNote;
}

void singingLEDLevel(int tooHighTooLow){
  resetSingingLed(currentLevel);

  /********* TOO LOW *********/
  switch (tooHighTooLow) {
    // case 0:
    // break;
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
    /********* TOO HIGH *********/
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




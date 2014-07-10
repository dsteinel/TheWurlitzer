/****** if equal = youHitIt = true ********/

void displaySingingNotes() {
  int singingLevel = 0;
  int hitTollerance = FREQUENCY_TO_HIT[noteToHit]*7/100;
  int frequency = readFrequency(timeToMeasure);
  Serial.println(frequency);

  if (frequency > (FREQUENCY_TO_HIT[noteToHit] - 150) || frequency < (FREQUENCY_TO_HIT[noteToHit] + 150))
  {
    youHitIt = false;
  }

  /********* TOO LOW *********/

  if (frequency > (FREQUENCY_TO_HIT[noteToHit] - 150) && frequency < (FREQUENCY_TO_HIT[noteToHit] - 100))
  {
    //singingLevel = 1;
    for (int index = 0; index < 63; index = index + 8) {
      digitalWrite(LED[index], HIGH);
    }  
  } 
  
  if (frequency > (FREQUENCY_TO_HIT[noteToHit]) - 100 && frequency < (FREQUENCY_TO_HIT[noteToHit] - 50))
  {
    //singingLevel = 2;
    for (int index = 0; index < 63; index = index + 8) {
      digitalWrite(LED[index], HIGH);
    } 
    for (int index = 1; index < 62; index = index + 8) {
      digitalWrite(LED[index], HIGH);
    }
  }

  if (frequency > (FREQUENCY_TO_HIT[noteToHit] - 50) && frequency < (FREQUENCY_TO_HIT[noteToHit] - hitTollerance))
  {
    //singingLevel = 3;
    for (int index = 2; index < 61; index = index + 8) {
      digitalWrite(LED[index], HIGH);
    } 
    for (int index = 1; index < 62; index = index + 8) {
      digitalWrite(LED[index], HIGH);
    }
    for (int index = 0; index < 63; index = index + 8) {
      digitalWrite(LED[index], HIGH);
    }
  }

  /********* TOO HIGH *********/

  if(frequency < (FREQUENCY_TO_HIT[noteToHit] + 150) && frequency > (FREQUENCY_TO_HIT[noteToHit] + 100))
  {
    //singingLevel = 4;
    for (int index = 7; index < 66; index = index + 8) {
      digitalWrite(LED[index], HIGH);
    }          
  }

  if(frequency < (FREQUENCY_TO_HIT[noteToHit] + 100) && frequency > (FREQUENCY_TO_HIT[noteToHit] + 50))
  {
    //singingLevel = 5;

    for (int index = 7; index < 66; index = index + 8) {
      digitalWrite(LED[index], HIGH);
    }  
    for (int index = 6; index < 65; index = index + 8) {
      digitalWrite(LED[index], HIGH);
    }
  }

  if(frequency < (FREQUENCY_TO_HIT[noteToHit] + 50) && frequency > (FREQUENCY_TO_HIT[noteToHit] + hitTollerance))
  {
    //singingLevel = 6;
    
    for (int index = 7; index < 66; index = index + 8) {
      digitalWrite(LED[index], HIGH);
    }  
    for (int index = 6; index < 65; index = index + 8) {
      digitalWrite(LED[index], HIGH);
    }
    for (int index = 5; index < 64; index = index + 8) {
      digitalWrite(LED[index], HIGH);
    }
  }

  if(frequency < (FREQUENCY_TO_HIT[noteToHit] - 150) || frequency > (FREQUENCY_TO_HIT[noteToHit] + 150))
  {
    resetSingingLed(currentLevel);
  }

  //singingLEDLevel(singingLevel);

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

// void singingLEDLevel(int tooHighTooLow){
//   resetSingingLed(currentLevel);

//   /********* TOO LOW *********/
//   switch (tooHighTooLow) {
//     // case 0:
//     // break;
//   case 1:
//     for (int index = 0; index < 63; index = index + 8) {
//       digitalWrite(LED[index], HIGH);
//     }  
//     break;

//   case 2:
//     for (int index = 0; index < 63; index = index + 8) {
//       digitalWrite(LED[index], HIGH);
//     } 
//     for (int index = 1; index < 62; index = index + 8) {
//       digitalWrite(LED[index], HIGH);
//     }
//     break;

//   case 3:
//     for (int index = 2; index < 61; index = index + 8) {
//       digitalWrite(LED[index], HIGH);
//     } 
//     for (int index = 1; index < 62; index = index + 8) {
//       digitalWrite(LED[index], HIGH);
//     }
//     for (int index = 0; index < 63; index = index + 8) {
//       digitalWrite(LED[index], HIGH);
//     }
//     break;
//     /********* TOO HIGH *********/
//   case 4:
//     for (int index = 7; index < 66; index = index + 8) {
//       digitalWrite(LED[index], HIGH);
//     }          
//     break;

//   case 5:
//     for (int index = 7; index < 66; index = index + 8) {
//       digitalWrite(LED[index], HIGH);
//     }  
//     for (int index = 6; index < 65; index = index + 8) {
//       digitalWrite(LED[index], HIGH);
//     }
//     break;

//   case 6:
//     for (int index = 7; index < 66; index = index + 8) {
//       digitalWrite(LED[index], HIGH);
//     }  
//     for (int index = 6; index < 65; index = index + 8) {
//       digitalWrite(LED[index], HIGH);
//     }
//     for (int index = 5; index < 64; index = index + 8) {
//       digitalWrite(LED[index], HIGH);
//     }
//     break;
//   }
// }





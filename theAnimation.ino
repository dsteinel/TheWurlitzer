void animation(){
/*** RESET STUFF ***/
  littleCounter = maxCounterValue;
  levelOneSinging = 0;
  levelTwoSinging = 0;
  noOneSings = false;
/*** =========== ***/

  for (int thisNote = 0; thisNote < 20; thisNote++) {
    int noteDuration = 1000/noteDurations[thisNote];
    if(thisNote == 16){
      noteDuration = 300;
    }
    else if(thisNote == 17){
      noteDuration = 350;
    }
    else if(thisNote == 18){
      noteDuration = 400;
    }
    else if(thisNote == 19){
      noteDuration = 450;
    }
    int randomNote = random(0, 8);
    tone(68, melody[randomNote],noteDuration);
    int pauseBetweenNotes = noteDuration * 1.30;
    int pickPin = random(0, 64);
    
    PORTA = ledAnimation[pickPin];
    PORTB = ledAnimation[pickPin];
    PORTC = ledAnimation[pickPin];
    PORTD = ledAnimation[pickPin];
    PORTE = ledAnimation[pickPin];
    PORTF = ledAnimation[pickPin];
    PORTG = ledAnimation[pickPin];
    PORTH = ledAnimation[pickPin];
    PORTJ = ledAnimation[pickPin];
    PORTK = ledAnimation[pickPin];
    PORTL = ledAnimation[pickPin];

    delay(pauseBetweenNotes);
    
    noTone(68);
  }
 
  resetSingingLed(currentLevel);
  delay(1500);
  
  noteToHit = (int)random(0,13);
  currentLevel++;

  if(currentLevel > 4){
    disableFirstLevel = true;
  }
  if(currentLevel > 8){
    currentLevel = 1;
    disableFirstLevel = false;
  }

  tone(68, FREQUENCY_TO_HIT[noteToHit], 1000);
  displayNotesToFind(currentLevel);

  delay(1000);
  noTone(68);
}

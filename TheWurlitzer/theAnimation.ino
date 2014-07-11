void animation(){
/*** RESET STUFF ***/
  littleCounter = maxCounterValue;
  singingLevel = 0;
/*** =========== ***/

  for (int thisNote = 0; thisNote < 8; thisNote++) {
    int noteDuration = 1000/noteDurations[thisNote];
    tone(68, melody[thisNote],noteDuration);
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
 
  
  delay(1500);
  
  noteToHit = (int)random(0,13);
  currentLevel++;

  tone(68, FREQUENCY_TO_HIT[noteToHit], 1000);
  displayNotesToFind(currentLevel);

  delay(1000);
  noTone(68);
}

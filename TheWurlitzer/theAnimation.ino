void animation(){
  Serial.println("HELL YEAH");
  for (int thisNote = 0; thisNote < 8; thisNote++) {
    int noteDuration = 1000/noteDurations[thisNote];
    tone(68, melody[thisNote],noteDuration);
    int pauseBetweenNotes = noteDuration * 1.30;
    delay(pauseBetweenNotes);
    noTone(68);
  }

  delay(500);
  resetAllLed();

  youHitIt = false;
}

void finishAnimation(){
  tone(68, melodyNotes[5], 400);
  delay(400);
  tone(68, melodyNotes[50], 400);
  delay(400);
  tone(68, melodyNotes[40], 400);
  delay(400);
  tone(68, melodyNotes[20], 400);
}




void animation(){
  Serial.println("HELL YEAH");
  
 for (int i = 0; i < 20; i++) {
   int randomFreqToPlay = (int)random(0, 63);
   int randomDelay = (int)random(100, 300);
   int randomLED = (int)random(0, 63);
   
   digitalWrite(LED[randomLED], HIGH);
   
    tone(68, melodyNotes[randomFreqToPlay], 400);

    delay(500);
    noTone(68);
    resetAllLed();
   
   youHitIt = false;
 }
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


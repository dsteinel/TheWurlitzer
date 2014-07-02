
public int displaySingingNotes(float frequency) {
  ///////// FOURTH ROW

  println("frequency: " + frequency);
  hitTollerance = FREQUENCY_TO_HIT[noteToHit]*5/100;
  println("hitTollerance: "+hitTollerance);


  if (frequency > FREQUENCY_TO_HIT[noteToHit] - (FREQUENCY_TO_HIT[noteToHit]*20)/100 && frequency < FREQUENCY_TO_HIT[noteToHit] || 
    frequency > FREQUENCY_TO_HIT[noteToHit] && frequency < FREQUENCY_TO_HIT[noteToHit]+(FREQUENCY_TO_HIT[noteToHit]*20)/100)
  {
    outerRing();
    delay(300);

    if (frequency > FREQUENCY_TO_HIT[noteToHit] - (FREQUENCY_TO_HIT[noteToHit]*15)/100 && frequency < FREQUENCY_TO_HIT[noteToHit] || 
    frequency > FREQUENCY_TO_HIT[noteToHit] && frequency < FREQUENCY_TO_HIT[noteToHit] + (FREQUENCY_TO_HIT[noteToHit]*15)/100)
    {
      middleRing();
      delay(300);

      if (frequency > FREQUENCY_TO_HIT[noteToHit] - (FREQUENCY_TO_HIT[noteToHit]*7.5)/100 && frequency < FREQUENCY_TO_HIT[noteToHit] || 
      frequency > FREQUENCY_TO_HIT[noteToHit] && frequency < FREQUENCY_TO_HIT[noteToHit] + (FREQUENCY_TO_HIT[noteToHit]*7.5)/100)
      {
        innerRing();
        delay(300);
        if (frequency > FREQUENCY_TO_HIT[noteToHit]-hitTollerance && frequency < FREQUENCY_TO_HIT[noteToHit]+hitTollerance)
        {
          youHitIt = true;   
        }
      }
    }
  }
 
  else if (frequency < FREQUENCY_TO_HIT[noteToHit] - (FREQUENCY_TO_HIT[noteToHit]*20)/100 || 
    frequency > FREQUENCY_TO_HIT[noteToHit] + (FREQUENCY_TO_HIT[noteToHit]*20)/100)
  {
    resetSingingLed();
    youHitIt = false;
  }
  return currentSingingNote;
}


void outerRing(){
  for (int left = 2; left < 10; left++) {
    arduino.digitalWrite(left, Arduino.HIGH);
  }
  for (int down = 10; down < 59; down = down + 8) {
    arduino.digitalWrite(down, Arduino.HIGH);
  }
  for (int right = 59; right < 66; right++) {
    arduino.digitalWrite(right, Arduino.HIGH);
  }
  for (int up = 17; up < 65; up = up + 8) {
    arduino.digitalWrite(up, Arduino.HIGH);
  }
}
void middleRing(){
  for (int left = 11; left < 18; left++) {
    arduino.digitalWrite(left, Arduino.HIGH);
  }
  for (int down = 19; down < 52; down = down + 8) {
    arduino.digitalWrite(down, Arduino.HIGH);
  }
  for (int right = 52; right < 57; right++) {
    arduino.digitalWrite(right, Arduino.HIGH);
  }
  for (int up = 16; up < 59; up = up + 8) {
    arduino.digitalWrite(up, Arduino.HIGH);
  }
}

void innerRing(){
  for (int left = 20; left < 24; left++) {
    arduino.digitalWrite(left, Arduino.HIGH);
  }
  for (int down = 20; down < 45; down = down + 8) {
    arduino.digitalWrite(down, Arduino.HIGH);
  }
  for (int right = 45; right < 48; right++) {
    arduino.digitalWrite(right, Arduino.HIGH);
  }
  for (int up = 24; up < 49; up = up + 8) {
    arduino.digitalWrite(up, Arduino.HIGH);
  }
}
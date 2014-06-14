
void resetSingingLed() {
  for (int i = 0; i < 65; i++) {
    arduino.digitalWrite(i, Arduino.LOW);
  }
  displayNotesToFind(noteToHit);
}

public int displaySingingNotes(float frequency) {
  ///////// FOURTH ROW

  println("frequency: " + frequency);

  if (frequency > COMPAREFREQUENCY[noteToHit-3] && frequency < COMPAREFREQUENCY[noteToHit] || 
    frequency > COMPAREFREQUENCY[noteToHit] && frequency < COMPAREFREQUENCY[noteToHit+3])
  {
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
  if (frequency > COMPAREFREQUENCY[noteToHit-2] && frequency < COMPAREFREQUENCY[noteToHit] || 
    frequency > COMPAREFREQUENCY[noteToHit] && frequency < COMPAREFREQUENCY[noteToHit+2])
  {
    for (int left = 10; left < 18; left++) {
        arduino.digitalWrite(left, Arduino.HIGH);
    }
    for (int down = 11; down < 52; down = down + 8) {
        arduino.digitalWrite(down, Arduino.HIGH);
    }
    for (int right = 60; right < 65; right++) {
        arduino.digitalWrite(right, Arduino.HIGH);
    }
    for (int up = 16; up < 59; up = up + 8) {
        arduino.digitalWrite(up, Arduino.HIGH);
    }
  }
  if (frequency > COMPAREFREQUENCY[noteToHit-1] && frequency < COMPAREFREQUENCY[noteToHit] || 
    frequency > COMPAREFREQUENCY[noteToHit] && frequency < COMPAREFREQUENCY[noteToHit+1])
  {
    println("COMPAREFREQUENCY[noteToHit-2]: "+COMPAREFREQUENCY[noteToHit-1]);
    for (int left = 20; left < 24; left++) {
        arduino.digitalWrite(left, Arduino.HIGH);
    }
    for (int down = 14; down < 17; down = down + 8) {
        arduino.digitalWrite(down, Arduino.HIGH);
    }
    for (int right = 44; right < 48; right++) {
        arduino.digitalWrite(right, Arduino.HIGH);
    }
    for (int up = 23; up < 27; up = up + 8) {
        arduino.digitalWrite(up, Arduino.HIGH);
    }
  }

  if (frequency == COMPAREFREQUENCY[noteToHit])
  {
    roadToAnimation(frequency);
  }
 
  return currentSingingNote;
}


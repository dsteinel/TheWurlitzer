
void resetSingingLed() {
  arduino.digitalWrite(LED[lastSingLedArr[0]], Arduino.LOW);
  arduino.digitalWrite(LED[lastSingLedArr[1]], Arduino.LOW);
  arduino.digitalWrite(LED[lastSingLedArr[2]], Arduino.LOW);
  arduino.digitalWrite(LED[lastSingLedArr[3]], Arduino.LOW);
  wave.setFrequency( 0 );
}

public int displaySingingNotes(float frequency) {
  ///////// FIRST ROW
  resetSingingLed();

  if (frequency > COMPAREFREQUENCY[1] && frequency <= COMPAREFREQUENCY[0] || frequency > COMPAREFREQUENCY[0])
  {
    currentSingingNote = 0;
    c = color (255, 0, 0);
    fill(c);
    float drawX = 0;
    rect(drawX, drawX, 40, 40);
    drawX=drawX+60;
    rect(0, drawX, 40, 40);
    rect(drawX, 0, 40, 40);
    rect(drawX, drawX, 40, 40);
    lastSingLedArr[0] = 64;
    lastSingLedArr[1] = 63;
    lastSingLedArr[2] = 56;
    lastSingLedArr[3] = 55;
  } 
  if (frequency > COMPAREFREQUENCY[2] && frequency <= COMPAREFREQUENCY[1])
  {
    currentSingingNote = 1;
    c = color (255, 0, 0);
    fill(c);
    float drawX = 120;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    drawX=drawX+60;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    lastSingLedArr[0] = 62;
    lastSingLedArr[1] = 61;
    lastSingLedArr[2] = 54;
    lastSingLedArr[3] = 53;
  } 
  if (frequency > COMPAREFREQUENCY[3] && frequency <= COMPAREFREQUENCY[2])
  {
    currentSingingNote = 2;
    c = color (255, 0, 0);
    fill(c);
    float drawX = 240;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    drawX=drawX+60;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    lastSingLedArr[0] = 60;
    lastSingLedArr[1] = 59;
    lastSingLedArr[2] = 52;
    lastSingLedArr[3] = 51;
  } 

  if (frequency > COMPAREFREQUENCY[4] && frequency <= COMPAREFREQUENCY[3])
  {
    currentSingingNote = 3;
    c = color (255, 0, 0);
    fill(c);
    float drawX = 360;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    drawX=drawX+60;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    lastSingLedArr[0] = 58;
    lastSingLedArr[1] = 57;
    lastSingLedArr[2] = 48;
    lastSingLedArr[3] = 49;
  }

  ///////// THIRD ROW
  if (frequency > COMPAREFREQUENCY[5] && frequency <= COMPAREFREQUENCY[4])
  {
    currentSingingNote = 4;
    c = color (255, 0, 80);
    fill(c);
    float drawX = 0;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    drawX=drawX+60;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    lastSingLedArr[0] = 56;
    lastSingLedArr[1] = 55;
    lastSingLedArr[2] = 47;
    lastSingLedArr[3] = 46;
  }
  if (frequency > COMPAREFREQUENCY[6] && frequency <= COMPAREFREQUENCY[5])
  {
    currentSingingNote = 5;
    c = color (255, 0, 150);
    fill(c);
    float drawX = 120;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    drawX=drawX+60;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    lastSingLedArr[0] = 54;
    lastSingLedArr[1] = 53;
    lastSingLedArr[2] = 45;
    lastSingLedArr[3] = 44;
  }
  if (frequency > COMPAREFREQUENCY[7] && frequency <= COMPAREFREQUENCY[6])
  {
    currentSingingNote = 6;
    c = color (200, 0, 255);
    fill(c);
    float drawX = 240;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    drawX=drawX+60;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    lastSingLedArr[0] = 52;
    lastSingLedArr[1] = 51;
    lastSingLedArr[2] = 43;
    lastSingLedArr[3] = 42;
  }
  if (frequency > COMPAREFREQUENCY[8] && frequency <= COMPAREFREQUENCY[7])
  {
    currentSingingNote = 7;
    c = color (100, 0, 255);
    fill(c);
    float drawX = 360;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    drawX=drawX+60;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    lastSingLedArr[0] = 50;
    lastSingLedArr[1] = 49;
    lastSingLedArr[2] = 41;
    lastSingLedArr[3] = 40;
  }

  ///////// SECOND ROW
  if (frequency > COMPAREFREQUENCY[9] && frequency <= COMPAREFREQUENCY[8])
  {
    currentSingingNote = 8;
    c = color (0, 0, 255);
    fill(c);
    float drawX = 0;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    drawX=drawX+60;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    lastSingLedArr[0] = 48;
    lastSingLedArr[1] = 47;
    lastSingLedArr[2] = 39;
    lastSingLedArr[3] = 38;
  }
  if (frequency > COMPAREFREQUENCY[10] && frequency <= COMPAREFREQUENCY[9])
  {
    currentSingingNote = 9;
    c = color (0, 50, 255);
    fill(c);
    float drawX = 120;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    drawX=drawX+60;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    lastSingLedArr[0] = 46;
    lastSingLedArr[1] = 45;
    lastSingLedArr[2] = 37;
    lastSingLedArr[3] = 36;
  }
  if (frequency > COMPAREFREQUENCY[11] && frequency <= COMPAREFREQUENCY[10])
  {
    currentSingingNote = 10;
    c = color (0, 150, 255);
    fill(c);
    float drawX = 240;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    drawX=drawX+60;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    lastSingLedArr[0] = 44;
    lastSingLedArr[1] = 43;
    lastSingLedArr[2] = 35;
    lastSingLedArr[3] = 34;
  }
  if (frequency > COMPAREFREQUENCY[12] && frequency <= COMPAREFREQUENCY[11])
  {
    currentSingingNote = 11;
    c = color (0, 255, 255);
    fill(c);
    float drawX = 360;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    drawX=drawX+60;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    lastSingLedArr[0] = 42;
    lastSingLedArr[1] = 41;
    lastSingLedArr[2] = 33;
    lastSingLedArr[3] = 32;
  }

  ///////// FIRST ROW
  if (frequency > COMPAREFREQUENCY[13] && frequency <= COMPAREFREQUENCY[12])
  {
    currentSingingNote = 12;
    c = color (0, 255, 0);
    fill(c);
    float drawX = 0;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    drawX=drawX+60;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    lastSingLedArr[0] = 40;
    lastSingLedArr[1] = 39;
    lastSingLedArr[2] = 31;
    lastSingLedArr[3] = 30;
  }
  if (frequency > COMPAREFREQUENCY[14] && frequency <= COMPAREFREQUENCY[13])
  {
    currentSingingNote = 13;
    c = color (255, 255, 0);
    fill(c);
    float drawX = 120;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    drawX=drawX+60;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    lastSingLedArr[0] = 38;
    lastSingLedArr[1] = 37;
    lastSingLedArr[2] = 29;
    lastSingLedArr[3] = 28;
  }
  if (frequency > COMPAREFREQUENCY[15] && frequency <= COMPAREFREQUENCY[14])
  {
    currentSingingNote = 14;
    c = color (255, 255, 0);
    fill(c);
    float drawX = 240;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    drawX=drawX+60;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    lastSingLedArr[0] = 36;
    lastSingLedArr[1] = 35;
    lastSingLedArr[2] = 27;
    lastSingLedArr[3] = 26;
  }
  if (frequency > COMPAREFREQUENCY[16] && frequency <= COMPAREFREQUENCY[15] || frequency < COMPAREFREQUENCY[16])
  {
    currentSingingNote = 15;
    c = color (255, 255, 0);
    fill(c);
    float drawX = 360;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    drawX=drawX+60;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    lastSingLedArr[0] = 34;
    lastSingLedArr[1] = 33;
    lastSingLedArr[2] = 25;
    lastSingLedArr[3] = 24;
  } 

  arduino.digitalWrite(LED[lastSingLedArr[0]], Arduino.HIGH); // COL
  arduino.digitalWrite(LED[lastSingLedArr[1]], Arduino.HIGH); // COL
  arduino.digitalWrite(LED[lastSingLedArr[2]], Arduino.HIGH);  // ROW
  arduino.digitalWrite(LED[lastSingLedArr[3]], Arduino.HIGH);  // ROW
  
  return currentSingingNote;
}


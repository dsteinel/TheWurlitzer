
void resetLed() {
  arduino.digitalWrite(lastLedArr[0], Arduino.HIGH);
  arduino.digitalWrite(lastLedArr[1], Arduino.LOW);
  arduino.digitalWrite(lastLedArr[2], Arduino.HIGH);
  arduino.digitalWrite(lastLedArr[3], Arduino.LOW);
}

public int displaySingingNotes() {
  resetLed();
  ///////// FIRST ROW
  if (frequency > COMPAREFREQUENCY[1] && frequency <= COMPAREFREQUENCY[0])
  {
    noteHit = 0;
    c = color (255, 0, 0);
    fill(c);
    float drawX = 0;
    rect(drawX, drawX, 40, 40);
    drawX=drawX+60;
    rect(0, drawX, 40, 40);
    rect(drawX, 0, 40, 40);
    rect(drawX, drawX, 40, 40);
    lastLedArr[0] = 6;
    lastLedArr[1] = 7;
    lastLedArr[2] = 6;
    lastLedArr[3] = 7;
  } 
  if (frequency > COMPAREFREQUENCY[2] && frequency <= COMPAREFREQUENCY[1])
  {
    noteHit = 1;
    c = color (255, 0, 0);
    fill(c);
    float drawX = 120;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    drawX=drawX+60;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    lastLedArr[0] = 6;
    lastLedArr[1] = 7;
    lastLedArr[2] = 4;
    lastLedArr[3] = 5;
  } 
  if (frequency > COMPAREFREQUENCY[3] && frequency <= COMPAREFREQUENCY[2])
  {
    noteHit = 2;
    c = color (255, 0, 0);
    fill(c);
    float drawX = 240;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    drawX=drawX+60;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    lastLedArr[0] = 6;
    lastLedArr[1] = 7;
    lastLedArr[2] = 2;
    lastLedArr[3] = 3;
  } 

  if (frequency > COMPAREFREQUENCY[4] && frequency <= COMPAREFREQUENCY[3])
  {
    noteHit = 3;
    c = color (255, 0, 0);
    fill(c);
    float drawX = 360;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    drawX=drawX+60;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    lastLedArr[0] = 6;
    lastLedArr[1] = 7;
    lastLedArr[2] = 0;
    lastLedArr[3] = 1;
  }

  ///////// THIRD ROW
  if (frequency > COMPAREFREQUENCY[5] && frequency <= COMPAREFREQUENCY[4])
  {
    noteHit = 4;
    c = color (255, 0, 80);
    fill(c);
    float drawX = 0;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    drawX=drawX+60;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    lastLedArr[0] = 4;
    lastLedArr[1] = 5;
    lastLedArr[2] = 6;
    lastLedArr[3] = 7;
  }
  if (frequency > COMPAREFREQUENCY[6] && frequency <= COMPAREFREQUENCY[5])
  {
    noteHit = 5;
    c = color (255, 0, 150);
    fill(c);
    float drawX = 120;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    drawX=drawX+60;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    lastLedArr[0] = 4;
    lastLedArr[1] = 5;
    lastLedArr[2] = 4;
    lastLedArr[3] = 5;
  }
  if (frequency > COMPAREFREQUENCY[7] && frequency <= COMPAREFREQUENCY[6])
  {
    noteHit = 6;
    c = color (200, 0, 255);
    fill(c);
    float drawX = 240;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    drawX=drawX+60;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    lastLedArr[0] = 4;
    lastLedArr[1] = 5;
    lastLedArr[2] = 2;
    lastLedArr[3] = 3;
  }
    if (frequency > COMPAREFREQUENCY[8] && frequency <= COMPAREFREQUENCY[7])
  {
    noteHit = 7;
    c = color (100, 0, 255);
    fill(c);
    float drawX = 360;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    drawX=drawX+60;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    lastLedArr[0] = 4;
    lastLedArr[1] = 5;
    lastLedArr[2] = 0;
    lastLedArr[3] = 1;
  }

  ///////// SECOND ROW
  if (frequency > COMPAREFREQUENCY[9] && frequency <= COMPAREFREQUENCY[8])
  {
    noteHit = 8;
    c = color (0, 0, 255);
    fill(c);
    float drawX = 0;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    drawX=drawX+60;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    lastLedArr[0] = 2;
    lastLedArr[1] = 3;
    lastLedArr[2] = 6;
    lastLedArr[3] = 7;
  }
  if (frequency > COMPAREFREQUENCY[10] && frequency <= COMPAREFREQUENCY[9])
  {
    noteHit = 9;
    c = color (0, 50, 255);
    fill(c);
    float drawX = 120;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    drawX=drawX+60;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    lastLedArr[0] = 2;
    lastLedArr[1] = 3;
    lastLedArr[2] = 4;
    lastLedArr[3] = 5;
  }
  if (frequency > COMPAREFREQUENCY[11] && frequency <= COMPAREFREQUENCY[10])
  {
    noteHit = 10;
    c = color (0, 150, 255);
    fill(c);
    float drawX = 240;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    drawX=drawX+60;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    lastLedArr[0] = 2;
    lastLedArr[1] = 3;
    lastLedArr[2] = 2;
    lastLedArr[3] = 3;
  }
  if (frequency > COMPAREFREQUENCY[12] && frequency <= COMPAREFREQUENCY[11])
  {
    noteHit = 11;
    c = color (0, 255, 255);
    fill(c);
    float drawX = 360;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    drawX=drawX+60;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    lastLedArr[0] = 2;
    lastLedArr[1] = 3;
    lastLedArr[2] = 0;
    lastLedArr[3] = 1;
  }

  ///////// FIRST ROW
  if (frequency > COMPAREFREQUENCY[13] && frequency <= COMPAREFREQUENCY[12])
  {
    noteHit = 12;
    c = color (0, 255, 0);
    fill(c);
    float drawX = 0;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    drawX=drawX+60;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    lastLedArr[0] = 0;
    lastLedArr[1] = 1;
    lastLedArr[2] = 6;
    lastLedArr[3] = 7;
  }
  if (frequency > COMPAREFREQUENCY[14] && frequency <= COMPAREFREQUENCY[13])
  {
    noteHit = 13;
    c = color (255, 255, 0);
    fill(c);
    float drawX = 120;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    drawX=drawX+60;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    lastLedArr[0] = 0;
    lastLedArr[1] = 1;
    lastLedArr[2] = 4;
    lastLedArr[3] = 5;
  }
  if (frequency > COMPAREFREQUENCY[15] && frequency <= COMPAREFREQUENCY[14])
  {
    noteHit = 14;
    c = color (255, 255, 0);
    fill(c);
    float drawX = 240;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    drawX=drawX+60;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    lastLedArr[0] = 0;
    lastLedArr[1] = 1;
    lastLedArr[2] = 2;
    lastLedArr[3] = 3;
  }
  if (frequency > COMPAREFREQUENCY[16] && frequency <= COMPAREFREQUENCY[15])
  {
    noteHit = 15;
    c = color (255, 255, 0);
    fill(c);
    float drawX = 360;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    drawX=drawX+60;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    lastLedArr[0] = 0;
    lastLedArr[1] = 1;
    lastLedArr[2] = 0;
    lastLedArr[3] = 1;
  } 

  arduino.digitalWrite(lastLedArr[0], Arduino.HIGH); // COL
  arduino.digitalWrite(lastLedArr[1], Arduino.HIGH); // COL
  arduino.digitalWrite(lastLedArr[2], Arduino.LOW);  // ROW
  arduino.digitalWrite(lastLedArr[3], Arduino.LOW);  // ROW
  return noteHit;
}


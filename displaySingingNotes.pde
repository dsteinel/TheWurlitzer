
void resetLed() {
  arduino.digitalWrite(col[lastSingLedArr[0]], Arduino.LOW); // COL
  arduino.digitalWrite(col[lastSingLedArr[1]], Arduino.LOW); // COL
  arduino.digitalWrite(row[lastSingLedArr[2]], Arduino.HIGH);  // ROW
  arduino.digitalWrite(row[lastSingLedArr[3]], Arduino.HIGH);  // ROW
  println(lastSingLedArr[0] + " " + lastSingLedArr[1]+ " " + lastSingLedArr[2] + " " + lastSingLedArr[3]);
}

public int displaySingingNotes() {
  ///////// FIRST ROW
  println("CALL");
  arduino.digitalWrite(col[lastSingLedArr[0]], Arduino.LOW); // COL
  arduino.digitalWrite(col[lastSingLedArr[1]], Arduino.LOW); // COL
  arduino.digitalWrite(row[lastSingLedArr[2]], Arduino.HIGH);  // ROW
  arduino.digitalWrite(row[lastSingLedArr[3]], Arduino.HIGH);  // ROW
  if (frequency > COMPAREFREQUENCY[1] && frequency <= COMPAREFREQUENCY[0])
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
    lastSingLedArr[0] = 6;
    lastSingLedArr[1] = 7;
    lastSingLedArr[2] = 6;
    lastSingLedArr[3] = 7;
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
    lastSingLedArr[0] = 6;
    lastSingLedArr[1] = 7;
    lastSingLedArr[2] = 4;
    lastSingLedArr[3] = 5;
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
    lastSingLedArr[0] = 6;
    lastSingLedArr[1] = 7;
    lastSingLedArr[2] = 2;
    lastSingLedArr[3] = 3;
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
    lastSingLedArr[0] = 6;
    lastSingLedArr[1] = 7;
    lastSingLedArr[2] = 0;
    lastSingLedArr[3] = 1;
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
    lastSingLedArr[0] = 4;
    lastSingLedArr[1] = 5;
    lastSingLedArr[2] = 6;
    lastSingLedArr[3] = 7;
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
    lastSingLedArr[0] = 4;
    lastSingLedArr[1] = 5;
    lastSingLedArr[2] = 4;
    lastSingLedArr[3] = 5;
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
    lastSingLedArr[0] = 4;
    lastSingLedArr[1] = 5;
    lastSingLedArr[2] = 2;
    lastSingLedArr[3] = 3;
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
    lastSingLedArr[0] = 4;
    lastSingLedArr[1] = 5;
    lastSingLedArr[2] = 0;
    lastSingLedArr[3] = 1;
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
    lastSingLedArr[0] = 2;
    lastSingLedArr[1] = 3;
    lastSingLedArr[2] = 6;
    lastSingLedArr[3] = 7;
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
    lastSingLedArr[0] = 2;
    lastSingLedArr[1] = 3;
    lastSingLedArr[2] = 4;
    lastSingLedArr[3] = 5;
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
    lastSingLedArr[0] = 2;
    lastSingLedArr[1] = 3;
    lastSingLedArr[2] = 2;
    lastSingLedArr[3] = 3;
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
    lastSingLedArr[0] = 2;
    lastSingLedArr[1] = 3;
    lastSingLedArr[2] = 0;
    lastSingLedArr[3] = 1;
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
    lastSingLedArr[0] = 0;
    lastSingLedArr[1] = 1;
    lastSingLedArr[2] = 6;
    lastSingLedArr[3] = 7;
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
    lastSingLedArr[0] = 0;
    lastSingLedArr[1] = 1;
    lastSingLedArr[2] = 4;
    lastSingLedArr[3] = 5;
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
    lastSingLedArr[0] = 0;
    lastSingLedArr[1] = 1;
    lastSingLedArr[2] = 2;
    lastSingLedArr[3] = 3;
  }
  if (frequency > COMPAREFREQUENCY[16] && frequency <= COMPAREFREQUENCY[15])
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
    lastSingLedArr[0] = 0;
    lastSingLedArr[1] = 1;
    lastSingLedArr[2] = 0;
    lastSingLedArr[3] = 1;
  } 

  arduino.digitalWrite(col[lastSingLedArr[0]], Arduino.HIGH); // COL
  arduino.digitalWrite(col[lastSingLedArr[1]], Arduino.HIGH); // COL
  arduino.digitalWrite(row[lastSingLedArr[2]], Arduino.LOW);  // ROW
  arduino.digitalWrite(row[lastSingLedArr[3]], Arduino.LOW);  // ROW

  return currentSingingNote;
}


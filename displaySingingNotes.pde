
void resetSingingLed() {
  arduino.digitalWrite(lastSingLedArr[0], Arduino.LOW);
  arduino.digitalWrite(lastSingLedArr[1], Arduino.LOW);
  arduino.digitalWrite(lastSingLedArr[2], Arduino.LOW);
  arduino.digitalWrite(lastSingLedArr[3], Arduino.LOW);
  displayNotesToFind(noteToHit);
}

public int displaySingingNotes(float frequency) {
  ///////// FOURTH ROW

  println("frequency: " + frequency);

  if (frequency >= COMPAREFREQUENCY[0] && frequency < COMPAREFREQUENCY[1] || frequency < COMPAREFREQUENCY[0])
  {
    currentSingingNote = 1;
    //links unten
    c = color (0, 255, 0);
    fill(c);
    float drawX = 0;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    drawX=drawX+60;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);

    lastSingLedArr[0] = 2;
    lastSingLedArr[1] = 3;
    lastSingLedArr[2] = 10;
    lastSingLedArr[3] = 11;
  } 
  if ( frequency >= COMPAREFREQUENCY[1] && frequency < COMPAREFREQUENCY[2])
  {
    currentSingingNote = 2;
    //2te Zeile, letzte Reihe
    c = color (255, 255, 0);
    fill(c);
    float drawX = 120;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    drawX=drawX+60;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);

    lastSingLedArr[0] = 18;
    lastSingLedArr[1] = 19;
    lastSingLedArr[2] = 26;
    lastSingLedArr[3] = 27;
  } 
  if (frequency >= COMPAREFREQUENCY[2] && frequency < COMPAREFREQUENCY[3])
  {
    currentSingingNote = 3;
    //1te Zeile 4te Reihe
    c = color (255, 255, 0);
    fill(c);
    float drawX = 240;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    drawX=drawX+60;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);

    lastSingLedArr[0] = 34;
    lastSingLedArr[1] = 35;
    lastSingLedArr[2] = 42;
    lastSingLedArr[3] = 43;
  } 

  if (frequency >= COMPAREFREQUENCY[3] && frequency < COMPAREFREQUENCY[4])
  {
    currentSingingNote = 4;
    //rechts unten
    c = color (255, 255, 0);
    fill(c);
    float drawX = 360;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    drawX=drawX+60;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);

    lastSingLedArr[0] = 50;
    lastSingLedArr[1] = 51;
    lastSingLedArr[2] = 58;
    lastSingLedArr[3] = 59;
  }

  ///////// THIRD ROW
  if (frequency >= COMPAREFREQUENCY[4] && frequency < COMPAREFREQUENCY[5])
  {
    currentSingingNote = 5;
    //3te Reihe links
    c = color (0, 0, 255);
    fill(c);
    float drawX = 0;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    drawX=drawX+60;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);

    lastSingLedArr[0] = 4;
    lastSingLedArr[1] = 5;
    lastSingLedArr[2] = 12;
    lastSingLedArr[3] = 13;
  }
  if (frequency >= COMPAREFREQUENCY[5] && frequency < COMPAREFREQUENCY[6])
  {
    currentSingingNote = 6;
    //3te Zeile, 2 Reihe
    c = color (0, 50, 255);
    fill(c);
    float drawX = 120;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    drawX=drawX+60;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);

    lastSingLedArr[0] = 20;
    lastSingLedArr[1] = 21;
    lastSingLedArr[2] = 28;
    lastSingLedArr[3] = 29;
  }
  if (frequency >= COMPAREFREQUENCY[6] && frequency < COMPAREFREQUENCY[7])
  {
    currentSingingNote = 7;
    //3te Zeile, 2te Reihe
    c = color (0, 150, 255);
    fill(c);
    float drawX = 240;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    drawX=drawX+60;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);

    lastSingLedArr[0] = 36;
    lastSingLedArr[1] = 37;
    lastSingLedArr[2] = 44;
    lastSingLedArr[3] = 45;
  }
  if (frequency >= COMPAREFREQUENCY[7] && frequency < COMPAREFREQUENCY[8])
  {
    currentSingingNote = 8;
    //3te Zeile, 3te Reihe
    c = color (0, 255, 255);
    fill(c);
    float drawX = 360;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    drawX=drawX+60;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);

    lastSingLedArr[0] = 52;
    lastSingLedArr[1] = 53;
    lastSingLedArr[2] = 60;
    lastSingLedArr[3] = 61;
  }

  ///////// SECOND ROW
  if (frequency >= COMPAREFREQUENCY[8] && frequency < COMPAREFREQUENCY[9])
  {
    currentSingingNote = 9;
    //4te Reihe 6,7
    c = color (255, 0, 80);
    fill(c);
    float drawX = 0;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    drawX=drawX+60;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    lastSingLedArr[0] = 6;
    lastSingLedArr[1] = 7;
    lastSingLedArr[2] = 14;
    lastSingLedArr[3] = 15;
  }
  if (frequency >= COMPAREFREQUENCY[9] && frequency < COMPAREFREQUENCY[10])
  {
    currentSingingNote = 10;
    //2te Zeile, 3te reihe
    c = color (255, 0, 150);
    fill(c);
    float drawX = 120;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    drawX=drawX+60;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    lastSingLedArr[0] = 22;
    lastSingLedArr[1] = 23;
    lastSingLedArr[2] = 30;
    lastSingLedArr[3] = 31;
  }
  if (frequency >= COMPAREFREQUENCY[10] && frequency < COMPAREFREQUENCY[11])
  {
    currentSingingNote = 11;
    //3te Zeile, 3te Reihe
    c = color (200, 0, 255);
    fill(c);
    float drawX = 240;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    drawX=drawX+60;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);

    lastSingLedArr[0] = 38;
    lastSingLedArr[1] = 39;
    lastSingLedArr[2] = 46;
    lastSingLedArr[3] = 47;
  }
  if (frequency >= COMPAREFREQUENCY[11] && frequency < COMPAREFREQUENCY[12])
  {
    currentSingingNote = 12;
    //3te Zeile letzte Reihe
    c = color (100, 0, 255);
    fill(c);
    float drawX = 360;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    drawX=drawX+60;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);

    lastSingLedArr[0] = 54;
    lastSingLedArr[1] = 55;
    lastSingLedArr[2] = 62;
    lastSingLedArr[3] = 63;
  }

  ///////// FIRST ROW
  if (frequency >= COMPAREFREQUENCY[12] && frequency < COMPAREFREQUENCY[13])
  {
    currentSingingNote = 13;
    //links oben
    c = color (255, 0, 0);
    fill(c);
    float drawX = 0;
    rect(drawX, drawX, 40, 40);
    drawX=drawX+60;
    rect(0, drawX, 40, 40);
    rect(drawX, 0, 40, 40);
    rect(drawX, drawX, 40, 40);

    lastSingLedArr[0] = 8;
    lastSingLedArr[1] = 9;
    lastSingLedArr[2] = 16;
    lastSingLedArr[3] = 17;
  }
  if (frequency >= COMPAREFREQUENCY[13] && frequency < COMPAREFREQUENCY[14])
  {
    currentSingingNote = 14;
    //2te Zeile, erste Reihe
    c = color (255, 0, 0);
    fill(c);
    float drawX = 120;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    drawX=drawX+60;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);

    lastSingLedArr[0] = 24;
    lastSingLedArr[1] = 25;
    lastSingLedArr[2] = 32;
    lastSingLedArr[3] = 33;
  }
  if (frequency >= COMPAREFREQUENCY[14] && frequency < COMPAREFREQUENCY[15])
  {
    currentSingingNote = 15;
    //oben rechts 2 letzte
    c = color (255, 0, 0);
    fill(c);
    float drawX = 240;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    drawX=drawX+60;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    lastSingLedArr[0] = 40;
    lastSingLedArr[1] = 41;
    lastSingLedArr[2] = 48;
    lastSingLedArr[3] = 49;
  }
  if (frequency >= COMPAREFREQUENCY[15] && frequency < COMPAREFREQUENCY[16] || frequency > COMPAREFREQUENCY[16])
  {
    currentSingingNote = 16;
    //rechts oben
    c = color (255, 0, 0);
    fill(c);
    float drawX = 360;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    drawX=drawX+60;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    
    lastSingLedArr[0] = 56;
    lastSingLedArr[1] = 57;
    lastSingLedArr[2] = 64;
    lastSingLedArr[3] = 65;
  } 

  arduino.digitalWrite(lastSingLedArr[0], Arduino.HIGH); // COL
  arduino.digitalWrite(lastSingLedArr[1], Arduino.HIGH); // COL
  arduino.digitalWrite(lastSingLedArr[2], Arduino.HIGH);  // ROW
  arduino.digitalWrite(lastSingLedArr[3], Arduino.HIGH);  // ROW
  
  return currentSingingNote;
}


void resetFindLed(){
  arduino.digitalWrite(LED[lastFindLedArr[0]], Arduino.LOW);
  arduino.digitalWrite(LED[lastFindLedArr[1]], Arduino.LOW);
  arduino.digitalWrite(LED[lastFindLedArr[2]], Arduino.LOW);
  arduino.digitalWrite(LED[lastFindLedArr[3]], Arduino.LOW);
  println("RESET");
}

void displayNotesToFind(int whichNote) {
///////// FOURTH ROW
  resetFindLed();
  resetAllLed();
  //println(whichNote);
  println("CALL");

  if (whichNote == 0) {
    c = color (100, 0, 255);
    fill(c);
    float drawX = 0;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    drawX=drawX+60;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    lastFindLedArr[0] = 0;
    lastFindLedArr[1] = 1;
    lastFindLedArr[2] = 2;
    lastFindLedArr[3] = 3;
}
if (whichNote == 1) {
    c = color (100, 100, 255);
    fill(c);
    float drawX = 120;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    drawX=drawX+60;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    lastFindLedArr[0] = 4;
    lastFindLedArr[1] = 5;
    lastFindLedArr[2] = 6;
    lastFindLedArr[3] = 7;
}
if (whichNote == 2) {
    c = color (100, 150, 255);
    fill(c);
    float drawX = 240;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    drawX=drawX+60;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    lastFindLedArr[0] = 8;
    lastFindLedArr[1] = 9;
    lastFindLedArr[2] = 10;
    lastFindLedArr[3] = 11;
}
if (whichNote == 3) {
    c = color (100, 200, 255);
    fill(c);
    float drawX = 360;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    drawX=drawX+60;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    lastFindLedArr[0] = 12;
    lastFindLedArr[1] = 13;
    lastFindLedArr[2] = 14;
    lastFindLedArr[3] = 15;
}

///////// THIRD ROW
if (whichNote == 4) {
    c = color (255, 255, 0);
    fill(c);
    float drawX = 0;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    drawX=drawX+60;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    lastFindLedArr[0] = 16;
    lastFindLedArr[1] = 17;
    lastFindLedArr[2] = 18;
    lastFindLedArr[3] = 19;
}
if (whichNote == 5) {
    c = color (255, 200, 0);
    fill(c);
    float drawX = 120;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    drawX=drawX+60;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    lastFindLedArr[0] = 20;
    lastFindLedArr[1] = 21;
    lastFindLedArr[2] = 22;
    lastFindLedArr[3] = 23;
}
if (whichNote == 6) {
    c = color (255, 130, 0);
    fill(c);
    float drawX = 240;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    drawX=drawX+60;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    lastFindLedArr[0] = 24;
    lastFindLedArr[1] = 25;
    lastFindLedArr[2] = 26;
    lastFindLedArr[3] = 27;
}
if (whichNote == 7) {
    c = color (255, 90, 0);
    fill(c);
    float drawX = 360;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    drawX=drawX+60;
    rect(drawX, 120, 40, 40);
    rect(drawX, 180, 40, 40);
    lastFindLedArr[0] = 28;
    lastFindLedArr[1] = 29;
    lastFindLedArr[2] = 30;
    lastFindLedArr[3] = 31;
}

   ///////// SECOND ROW
   
   if (whichNote == 8) {
    c = color (255, 0, 255);
    fill(c);
    float drawX = 0;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    drawX=drawX+60;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    lastFindLedArr[0] = 32;
    lastFindLedArr[1] = 33;
    lastFindLedArr[2] = 34;
    lastFindLedArr[3] = 35;
}
if (whichNote == 9) {
    c = color (255, 0, 190);
    fill(c);
    float drawX = 120;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    drawX=drawX+60;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    lastFindLedArr[0] = 36;
    lastFindLedArr[1] = 37;
    lastFindLedArr[2] = 38;
    lastFindLedArr[3] = 39;
}
if (whichNote == 10) {
    c = color (255, 0, 140);
    fill(c);
    float drawX = 240;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    drawX=drawX+60;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    lastFindLedArr[0] = 40;
    lastFindLedArr[1] = 41;
    lastFindLedArr[2] = 42;
    lastFindLedArr[3] = 43;
}
if (whichNote == 11) {
    c = color (255, 0, 90);
    fill(c);
    float drawX = 360;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    drawX=drawX+60;
    rect(drawX, 240, 40, 40);
    rect(drawX, 300, 40, 40);
    lastFindLedArr[0] = 44;
    lastFindLedArr[1] = 45;
    lastFindLedArr[2] = 46;
    lastFindLedArr[3] = 47;
}

   ///////// FIRST ROW
   
   if (whichNote == 12) {
    c = color (255, 200, 0);
    fill(c);
    float drawX = 0;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    drawX=drawX+60;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    lastFindLedArr[0] = 48;
    lastFindLedArr[1] = 49;
    lastFindLedArr[2] = 50;
    lastFindLedArr[3] = 51;
}
if (whichNote == 13) {
    c = color (255, 150, 0);
    fill(c);
    float drawX = 120;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    drawX=drawX+60;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    lastFindLedArr[0] = 52;
    lastFindLedArr[1] = 53;
    lastFindLedArr[2] = 54;
    lastFindLedArr[3] = 55;
}
if (whichNote == 14) {
    c = color (255, 20, 0);
    fill(c);
    float drawX = 240;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    drawX=drawX+60;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    lastFindLedArr[0] = 56;
    lastFindLedArr[1] = 57;
    lastFindLedArr[2] = 58;
    lastFindLedArr[3] = 59;
}
if (whichNote == 15) {
    c = color (255, 100, 0);
    fill(c);
    float drawX = 360;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    drawX=drawX+60;
    rect(drawX, 360, 40, 40);
    rect(drawX, 420, 40, 40);
    lastFindLedArr[0] = 60;
    lastFindLedArr[1] = 61;
    lastFindLedArr[2] = 62;
    lastFindLedArr[3] = 63;
}
    
  arduino.digitalWrite(LED[lastFindLedArr[0]], Arduino.HIGH); // COL
  arduino.digitalWrite(LED[lastFindLedArr[1]], Arduino.HIGH); // COL
  arduino.digitalWrite(LED[lastFindLedArr[2]], Arduino.HIGH);  // ROW
  arduino.digitalWrite(LED[lastFindLedArr[3]], Arduino.HIGH);  // ROW

  displayTheHitNotes = 0;
}


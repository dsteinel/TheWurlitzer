
void displayNotesToFind(int whichNote) {
///////// FOURTH ROW
  //println(whichNote);
  if (whichNote == 0) {
    c = color (100, 0, 255);
    fill(c);
    float drawX = 0;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    drawX=drawX+60;
    rect(drawX, 0, 40, 40);
    rect(drawX, 60, 40, 40);
    lastLedArr[0] = 6;
    lastLedArr[1] = 7;
    lastLedArr[2] = 7;
    lastLedArr[3] = 6;
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
    lastLedArr[0] = 6;
    lastLedArr[1] = 7;
    lastLedArr[2] = 4;
    lastLedArr[3] = 5;
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
    lastLedArr[0] = 6;
    lastLedArr[1] = 7;
    lastLedArr[2] = 3;
    lastLedArr[3] = 2;
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
    lastLedArr[0] = 6;
    lastLedArr[1] = 7;
    lastLedArr[2] = 1;
    lastLedArr[3] = 0;
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
    lastLedArr[0] = 4;
    lastLedArr[1] = 5;
    lastLedArr[2] = 7;
    lastLedArr[3] = 6;
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
    lastLedArr[0] = 4;
    lastLedArr[1] = 5;
    lastLedArr[2] = 4;
    lastLedArr[3] = 5;
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
    lastLedArr[0] = 4;
    lastLedArr[1] = 5;
    lastLedArr[2] = 2;
    lastLedArr[3] = 3;
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
    lastLedArr[0] = 4;
    lastLedArr[1] = 5;
    lastLedArr[2] = 0;
    lastLedArr[3] = 1;
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
    lastLedArr[0] = 2;
    lastLedArr[1] = 3;
    lastLedArr[2] = 6;
    lastLedArr[3] = 7;
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
    lastLedArr[0] = 2;
    lastLedArr[1] = 3;
    lastLedArr[2] = 4;
    lastLedArr[3] = 5;
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
    lastLedArr[0] = 2;
    lastLedArr[1] = 3;
    lastLedArr[2] = 2;
    lastLedArr[3] = 3;
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
    lastLedArr[0] = 2;
    lastLedArr[1] = 3;
    lastLedArr[2] = 0;
    lastLedArr[3] = 1;
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
    lastLedArr[0] = 0;
    lastLedArr[1] = 1;
    lastLedArr[2] = 6;
    lastLedArr[3] = 7;
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
    lastLedArr[0] = 0;
    lastLedArr[1] = 1;
    lastLedArr[2] = 4;
    lastLedArr[3] = 5;
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
    lastLedArr[0] = 0;
    lastLedArr[1] = 1;
    lastLedArr[2] = 3;
    lastLedArr[3] = 2;
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
    lastLedArr[0] = 0;
    lastLedArr[1] = 1;
    lastLedArr[2] = 0;
    lastLedArr[3] = 1;
   }
   
  arduino.digitalWrite(lastLedArr[0], Arduino.HIGH); // COL
  arduino.digitalWrite(lastLedArr[1], Arduino.HIGH); // COL
  arduino.digitalWrite(lastLedArr[2], Arduino.LOW);  // ROW
  arduino.digitalWrite(lastLedArr[3], Arduino.LOW);  // ROW
}


void resetFindLed(){
    arduino.digitalWrite(lastFindLedArr[0], Arduino.LOW);
    arduino.digitalWrite(lastFindLedArr[1], Arduino.LOW);
    arduino.digitalWrite(lastFindLedArr[2], Arduino.LOW);
    arduino.digitalWrite(lastFindLedArr[3], Arduino.LOW);
    println("RESET");
}

void displayNotesToFind(int whichNote) {
    resetFindLed();
    println("displayNotesToFind");

    ///////// FOURTH ROW

    if (whichNote == 1) {
        c = color (100, 0, 255);
        fill(c);
        float drawX = 0;
        rect(drawX, 0, 40, 40);
        rect(drawX, 60, 40, 40);
        drawX=drawX+60;
        rect(drawX, 0, 40, 40);
        rect(drawX, 60, 40, 40);
        lastFindLedArr[0] = 2;
        lastFindLedArr[1] = 3;
        lastFindLedArr[2] = 10;
        lastFindLedArr[3] = 11;
    }
    if (whichNote == 2) {
        c = color (100, 100, 255);
        fill(c);
        float drawX = 120;
        rect(drawX, 0, 40, 40);
        rect(drawX, 60, 40, 40);
        drawX=drawX+60;
        rect(drawX, 0, 40, 40);
        rect(drawX, 60, 40, 40);
        lastFindLedArr[0] = 18;
        lastFindLedArr[1] = 19;
        lastFindLedArr[2] = 26;
        lastFindLedArr[3] = 27;
    }
    if (whichNote == 3) {
        c = color (100, 150, 255);
        fill(c);
        float drawX = 240;
        rect(drawX, 0, 40, 40);
        rect(drawX, 60, 40, 40);
        drawX=drawX+60;
        rect(drawX, 0, 40, 40);
        rect(drawX, 60, 40, 40);
        lastFindLedArr[0] = 34;
        lastFindLedArr[1] = 35;
        lastFindLedArr[2] = 42;
        lastFindLedArr[3] = 43;
    }
    if (whichNote == 4) {
        c = color (100, 200, 255);
        fill(c);
        float drawX = 360;
        rect(drawX, 0, 40, 40);
        rect(drawX, 60, 40, 40);
        drawX=drawX+60;
        rect(drawX, 0, 40, 40);
        rect(drawX, 60, 40, 40);
        lastFindLedArr[0] = 50;
        lastFindLedArr[1] = 51;
        lastFindLedArr[2] = 58;
        lastFindLedArr[3] = 59;
    }

    ///////// THIRD ROW

    if (whichNote == 5) {
        c = color (255, 255, 0);
        fill(c);
        float drawX = 0;
        rect(drawX, 120, 40, 40);
        rect(drawX, 180, 40, 40);
        drawX=drawX+60;
        rect(drawX, 120, 40, 40);
        rect(drawX, 180, 40, 40);
        lastFindLedArr[0] = 4;
        lastFindLedArr[1] = 5;
        lastFindLedArr[2] = 12;
        lastFindLedArr[3] = 13;
    }
    if (whichNote == 6) {
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
        lastFindLedArr[2] = 28;
        lastFindLedArr[3] = 29;
    }
    if (whichNote == 7) {
        c = color (255, 130, 0);
        fill(c);
        float drawX = 240;
        rect(drawX, 120, 40, 40);
        rect(drawX, 180, 40, 40);
        drawX=drawX+60;
        rect(drawX, 120, 40, 40);
        rect(drawX, 180, 40, 40);
        lastFindLedArr[0] = 36;
        lastFindLedArr[1] = 37;
        lastFindLedArr[2] = 44;
        lastFindLedArr[3] = 45;
    }
    if (whichNote == 8) {
        c = color (255, 90, 0);
        fill(c);
        float drawX = 360;
        rect(drawX, 120, 40, 40);
        rect(drawX, 180, 40, 40);
        drawX=drawX+60;
        rect(drawX, 120, 40, 40);
        rect(drawX, 180, 40, 40);
        lastFindLedArr[0] = 52;
        lastFindLedArr[1] = 53;
        lastFindLedArr[2] = 60;
        lastFindLedArr[3] = 61;
    }

    ///////// SECOND ROW

    if (whichNote == 9) {
        c = color (255, 0, 255);
        fill(c);
        float drawX = 0;
        rect(drawX, 240, 40, 40);
        rect(drawX, 300, 40, 40);
        drawX=drawX+60;
        rect(drawX, 240, 40, 40);
        rect(drawX, 300, 40, 40);
        lastFindLedArr[0] = 6;
        lastFindLedArr[1] = 7;
        lastFindLedArr[2] = 14;
        lastFindLedArr[3] = 15;
    }
    if (whichNote == 10) {
        c = color (255, 0, 190);
        fill(c);
        float drawX = 120;
        rect(drawX, 240, 40, 40);
        rect(drawX, 300, 40, 40);
        drawX=drawX+60;
        rect(drawX, 240, 40, 40);
        rect(drawX, 300, 40, 40);
        lastFindLedArr[0] = 22;
        lastFindLedArr[1] = 23;
        lastFindLedArr[2] = 30;
        lastFindLedArr[3] = 31;
    }
    if (whichNote == 11) {
        c = color (255, 0, 140);
        fill(c);
        float drawX = 240;
        rect(drawX, 240, 40, 40);
        rect(drawX, 300, 40, 40);
        drawX=drawX+60;
        rect(drawX, 240, 40, 40);
        rect(drawX, 300, 40, 40);
        lastFindLedArr[0] = 38;
        lastFindLedArr[1] = 39;
        lastFindLedArr[2] = 46;
        lastFindLedArr[3] = 47;
    }
    if (whichNote == 12) {
        c = color (255, 0, 90);
        fill(c);
        float drawX = 360;
        rect(drawX, 240, 40, 40);
        rect(drawX, 300, 40, 40);
        drawX=drawX+60;
        rect(drawX, 240, 40, 40);
        rect(drawX, 300, 40, 40);
        lastFindLedArr[0] = 54;
        lastFindLedArr[1] = 55;
        lastFindLedArr[2] = 62;
        lastFindLedArr[3] = 63;
    }

    ///////// FIRST ROW

    if (whichNote == 13) {
        c = color (255, 200, 0);
        fill(c);
        float drawX = 0;
        rect(drawX, 360, 40, 40);
        rect(drawX, 420, 40, 40);
        drawX=drawX+60;
        rect(drawX, 360, 40, 40);
        rect(drawX, 420, 40, 40);
        lastFindLedArr[0] = 8;
        lastFindLedArr[1] = 9;
        lastFindLedArr[2] = 16;
        lastFindLedArr[3] = 17;
    }
    if (whichNote == 14) {
        c = color (255, 150, 0);
        fill(c);
        float drawX = 120;
        rect(drawX, 360, 40, 40);
        rect(drawX, 420, 40, 40);
        drawX=drawX+60;
        rect(drawX, 360, 40, 40);
        rect(drawX, 420, 40, 40);
        lastFindLedArr[0] = 24;
        lastFindLedArr[1] = 25;
        lastFindLedArr[2] = 32;
        lastFindLedArr[3] = 33;
    }
    if (whichNote == 15) {
        c = color (255, 20, 0);
        fill(c);
        float drawX = 240;
        rect(drawX, 360, 40, 40);
        rect(drawX, 420, 40, 40);
        drawX=drawX+60;
        rect(drawX, 360, 40, 40);
        rect(drawX, 420, 40, 40);
        lastFindLedArr[0] = 40;
        lastFindLedArr[1] = 41;
        lastFindLedArr[2] = 48;
        lastFindLedArr[3] = 49;
    }
    if (whichNote == 16) {
        c = color (255, 100, 0);
        fill(c);
        float drawX = 360;
        rect(drawX, 360, 40, 40);
        rect(drawX, 420, 40, 40);
        drawX=drawX+60;
        rect(drawX, 360, 40, 40);
        rect(drawX, 420, 40, 40);
        lastFindLedArr[0] = 56;
        lastFindLedArr[1] = 57;
        lastFindLedArr[2] = 64;
        lastFindLedArr[3] = 65;
    }


  arduino.digitalWrite(lastFindLedArr[0], Arduino.HIGH); // COL
  arduino.digitalWrite(lastFindLedArr[1], Arduino.HIGH); // COL
  arduino.digitalWrite(lastFindLedArr[2], Arduino.HIGH);  // ROW
  arduino.digitalWrite(lastFindLedArr[3], Arduino.HIGH);  // ROW

}


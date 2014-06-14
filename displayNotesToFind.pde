void resetFindLed(){
    arduino.digitalWrite(lastFindLedArr[0], Arduino.LOW);
    arduino.digitalWrite(lastFindLedArr[1], Arduino.LOW);
    arduino.digitalWrite(lastFindLedArr[2], Arduino.LOW);
    arduino.digitalWrite(lastFindLedArr[3], Arduino.LOW);
    println("RESET FIND LED");
}

void displayNotesToFind(int whichNote) {
    
    //resetFindLed();
    lastFindLedArr[0] = 30;
    lastFindLedArr[1] = 29;
    lastFindLedArr[2] = 37;
    lastFindLedArr[3] = 38;
    arduino.digitalWrite(lastFindLedArr[0], Arduino.HIGH);
    arduino.digitalWrite(lastFindLedArr[1], Arduino.HIGH);
    arduino.digitalWrite(lastFindLedArr[2], Arduino.HIGH);
    arduino.digitalWrite(lastFindLedArr[3], Arduino.HIGH);

    if (displayingNotesToFind) {
        println("displayingNotesToFind: "+displayingNotesToFind);
        wave.setAmplitude( 2 );
        //PLAY THE FREQUENCY TO HIT ONE TIME
        wave.setFrequency( COMPAREFREQUENCY[whichNote] );
        delay(4000);
        wave.setFrequency( 0 );
    }
    
    displayingNotesToFind = false;
}


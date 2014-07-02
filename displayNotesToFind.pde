void resetFindLed(){
    arduino.digitalWrite(lastFindLedArr[0], Arduino.LOW);
    arduino.digitalWrite(lastFindLedArr[1], Arduino.LOW);
    arduino.digitalWrite(lastFindLedArr[2], Arduino.LOW);
    arduino.digitalWrite(lastFindLedArr[3], Arduino.LOW);
    println("RESET FIND LED");
}

void displayNotesToFind() {
    
    arduino.digitalWrite(29, Arduino.HIGH);
    arduino.digitalWrite(30, Arduino.HIGH);
    arduino.digitalWrite(37, Arduino.HIGH);
    arduino.digitalWrite(38, Arduino.HIGH);

    if (playHitTone) {
        wave.setAmplitude( 3 );
        println("ALLFREQS[noteToHit]: "+FREQUENCY_TO_HIT[noteToHit]);
        wave.setFrequency( FREQUENCY_TO_HIT[noteToHit] );
        delay(2000);
        wave.setAmplitude( 0 );   
        playHitTone = false;      
    }
}


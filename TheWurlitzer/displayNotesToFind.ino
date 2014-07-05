void resetFindLed(){
//    digitalWrite(lastFindLedArr[0], LOW);
//    digitalWrite(lastFindLedArr[1], LOW);
//    digitalWrite(lastFindLedArr[2], LOW);
//    digitalWrite(lastFindLedArr[3], LOW);
    Serial.println("RESET FIND LED");
}

void displayNotesToFind() {
    
    digitalWrite(29, HIGH);
    digitalWrite(30, HIGH);
    digitalWrite(37, HIGH);
    digitalWrite(38, HIGH);

    if (playHitTone) {
        playHitTone = false;      
    }
}


void resetFindLed(){
//    digitalWrite(lastFindLedArr[0], LOW);
//    digitalWrite(lastFindLedArr[1], LOW);
//    digitalWrite(lastFindLedArr[2], LOW);
//    digitalWrite(lastFindLedArr[3], LOW);
    Serial.println("RESET FIND LED");
}

void displayNotesToFind() {
    
    digitalWrite(LED[27], HIGH);
    digitalWrite(LED[28], HIGH);
    digitalWrite(LED[36], HIGH);
    digitalWrite(LED[35], HIGH);

    if (playHitTone) {
        playHitTone = false;      
    }
}


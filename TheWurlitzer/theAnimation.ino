void animation(){
  Serial.println("HELL YEAH");

  for (int i = 0; i < 20; i++) {
    int randomFreqToPlay = (int)random(0, 63);
    int randomDelay = (int)random(100, 300);
    int randomLED = (int)random(0, 63);
//    wave.setAmplitude( 3 );
//    wave.setFrequency( ALLFREQS[randomFreqToPlay] );
//    println(randomFreqToPlay);
    digitalWrite(LED[randomLED], HIGH);
    delay(randomDelay);
    resetAllLed();
    delay(100);
    playHitTone = true;
    youHitIt = false;
  }
}

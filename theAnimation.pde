void animation(){
  println("HELL YEAH");

  for (int i = 0; i < 20; i++) {
    int randomFreqToPlay = (int)random(0, 63);
    int randomDelay = (int)random(100, 300);
    int randomLED = (int)random(0, 63);
    wave.setAmplitude( 1 );
    wave.setFrequency( ALLFREQS[randomFreqToPlay] );
    println(randomFreqToPlay);
    arduino.digitalWrite(LED[randomLED], Arduino.HIGH);
    delay(randomDelay);
    resetAllLed();
    delay(100);
  }
}

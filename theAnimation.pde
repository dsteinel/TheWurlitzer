void animation(){
  println("HELL YEAH");
  noteToHit = (int)random(0,15);
  
  println("NEW NOTE:" + " " + noteToHit);
  for (int i = 0; i < 64; i++) {
    arduino.digitalWrite(LED[i], Arduino.HIGH);
  }

  for (int i = 0; i < 20; i++) {
    int randomFreqToPlay = (int)random(0, 63);
    int randomLED = (int)random(0, 63);
    wave.setAmplitude( 1 );
    wave.setFrequency( ALLFREQS[randomFreqToPlay] );
    println(randomFreqToPlay);
    arduino.digitalWrite(LED[randomLED], Arduino.HIGH);
    delay(300);
    resetAllLed();
    delay(100);
  }

  //displayNotesToFind(noteToHit);
//  for(int y = 0; y<height; y += 60){
//    for(int x = 0; x<width; x += 60){
//      background(0);
//      rect(x, y, 40, 40);
//      rect(x, y, 40, 40);
//      delay(100);
//    }
//  }
}

void animation(){
  println("HELL YEAH");
  noteToHit = (int)random(0,15);
  
  println("NEW NOTE:" + " " + noteToHit);
  for (int i = 0; i < 8; i++) {
    arduino.digitalWrite(row[i], Arduino.HIGH);
    arduino.digitalWrite(col[i], Arduino.LOW);
  }

  for (int i = 0; i < 20; i++) {
    int randomFreqToPlay = (int)random(0, 63);
    int randomRow = (int)random(0,7);
    int randomCol = (int)random(0,7);
    wave.setAmplitude( 1 );
    wave.setFrequency( ALLFREQS[randomFreqToPlay] );
    println(randomFreqToPlay);
    arduino.digitalWrite(row[randomRow], Arduino.LOW);
    arduino.digitalWrite(col[randomCol], Arduino.HIGH);
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

void animation(){
  println("HELL YEAH");
  theHitNote = (int)random(0,15);
  println("NEW NOTE:" + " " + theHitNote);
  for(int i = 0; i<8; i++){
    arduino.digitalWrite(col[i], Arduino.HIGH);
    arduino.digitalWrite(row[i], Arduino.LOW);
  }
//  for(int y = 0; y<height; y += 60){
//    for(int x = 0; x<width; x += 60){
//      background(0);
//      rect(x, y, 40, 40);
//      rect(x, y, 40, 40);
//      delay(100);
//    }
//  }
}

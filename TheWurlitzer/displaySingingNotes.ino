
int displaySingingNotes(int frequency) {
  
  Serial.println(frequency);
  hitTollerance = FREQUENCY_TO_HIT[noteToHit]*5/100;
//  Serial.println(FREQUENCY_TO_HIT[noteToHit]);


  if (frequency > FREQUENCY_TO_HIT[noteToHit] - (FREQUENCY_TO_HIT[noteToHit]*20)/100 && frequency < FREQUENCY_TO_HIT[noteToHit] || 
    frequency > FREQUENCY_TO_HIT[noteToHit] && frequency < FREQUENCY_TO_HIT[noteToHit]+(FREQUENCY_TO_HIT[noteToHit]*20)/100)
  {
    outerRing();
    delay(300);
    
//    
//    if (referenceFreq > FREQUENCY_TO_HIT[noteToHit] - (FREQUENCY_TO_HIT[noteToHit]*15)/100 && referenceFreq < FREQUENCY_TO_HIT[noteToHit] || 
//    referenceFreq > FREQUENCY_TO_HIT[noteToHit] && referenceFreq < FREQUENCY_TO_HIT[noteToHit] + (FREQUENCY_TO_HIT[noteToHit]*15)/100)
//    {
//      
//      middleRing();
//      
//      delay(300);
//      
//      referenceFreq = readFrequency(timeToMeasure);
//
//      if (frequency > FREQUENCY_TO_HIT[noteToHit] - (FREQUENCY_TO_HIT[noteToHit]*7.5)/100 && frequency < FREQUENCY_TO_HIT[noteToHit] || 
//      frequency > FREQUENCY_TO_HIT[noteToHit] && frequency < FREQUENCY_TO_HIT[noteToHit] + (FREQUENCY_TO_HIT[noteToHit]*7.5)/100)
//      {
//        
//        innerRing();
//        
//        delay(300);
//        
//        referenceFreq = readFrequency(timeToMeasure);
//        
//        if (referenceFreq > FREQUENCY_TO_HIT[noteToHit]-hitTollerance && referenceFreq < FREQUENCY_TO_HIT[noteToHit]+hitTollerance)
//        {
//          youHitIt = true;   
//        }
//      }
//    }
  }
 
//  else if (frequency < FREQUENCY_TO_HIT[noteToHit] - (FREQUENCY_TO_HIT[noteToHit]*20)/100 || 
//    frequency > FREQUENCY_TO_HIT[noteToHit] + (FREQUENCY_TO_HIT[noteToHit]*20)/100)
//  {
//    resetSingingLed();
//    youHitIt = false;
//  }
  return currentSingingNote;
}


void outerRing(){
  for (int left = 2; left < 10; left++) {
    digitalWrite(left, HIGH);
    digitalWrite(LED[0], HIGH);
  }
  for (int down = 10; down < 59; down = down + 8) {
    digitalWrite(down, HIGH);
  }
  for (int right = 59; right < 66; right++) {
    digitalWrite(right, HIGH);
  }
  for (int up = 17; up < 65; up = up + 8) {
    digitalWrite(up, HIGH);
  }
  
  delay(300);
  int referenceFreq = readFrequency(timeToMeasure);
  
  if (referenceFreq > FREQUENCY_TO_HIT[noteToHit] - (FREQUENCY_TO_HIT[noteToHit]*15)/100 && referenceFreq < FREQUENCY_TO_HIT[noteToHit] || 
  referenceFreq > FREQUENCY_TO_HIT[noteToHit] && referenceFreq < FREQUENCY_TO_HIT[noteToHit] + (FREQUENCY_TO_HIT[noteToHit]*15)/100)
  {
    middleRing();
  }
  
  else if (referenceFreq < FREQUENCY_TO_HIT[noteToHit] - (FREQUENCY_TO_HIT[noteToHit]*20)/100 || 
    referenceFreq > FREQUENCY_TO_HIT[noteToHit] + (FREQUENCY_TO_HIT[noteToHit]*20)/100)
  {
    resetSingingLed();
  }
}

void middleRing(){
  for (int left = 11; left < 17; left++) {
    digitalWrite(left, HIGH);
  }
  for (int down = 19; down < 52; down = down + 8) {
    digitalWrite(down, HIGH);
  }
  for (int right = 52; right < 57; right++) {
    digitalWrite(right, HIGH);
  }
  for (int up = 16; up < 59; up = up + 8) {
    digitalWrite(up, HIGH);
  }
  
  int referenceFreq = readFrequency(timeToMeasure);
  
  if (referenceFreq > FREQUENCY_TO_HIT[noteToHit] - (FREQUENCY_TO_HIT[noteToHit]*7.5)/100 && referenceFreq < FREQUENCY_TO_HIT[noteToHit] || 
    referenceFreq > FREQUENCY_TO_HIT[noteToHit] && referenceFreq < FREQUENCY_TO_HIT[noteToHit] + (FREQUENCY_TO_HIT[noteToHit]*7.5)/100)
    {
      innerRing();
      
      delay(1000);
      
      referenceFreq = readFrequency(timeToMeasure);
     
    }
   else if (referenceFreq < FREQUENCY_TO_HIT[noteToHit] - (FREQUENCY_TO_HIT[noteToHit]*20)/100 || 
    referenceFreq > FREQUENCY_TO_HIT[noteToHit] + (FREQUENCY_TO_HIT[noteToHit]*20)/100)
  {
    resetSingingLed();
    outerRing();
  }
}

void innerRing(){
  for (int left = 20; left < 24; left++) {
    digitalWrite(left, HIGH);
  }
  for (int down = 20; down < 45; down = down + 8) {
    digitalWrite(down, HIGH);
  }
  for (int right = 45; right < 48; right++) {
    digitalWrite(right, HIGH);
  }
  for (int up = 24; up < 49; up = up + 8) {
    digitalWrite(up, HIGH);
  }
  
  int referenceFreq = readFrequency(timeToMeasure);
  
 if (referenceFreq > FREQUENCY_TO_HIT[noteToHit]-hitTollerance && referenceFreq < FREQUENCY_TO_HIT[noteToHit]+hitTollerance)
    {
      youHitIt = true;   
    }
   else if (referenceFreq < FREQUENCY_TO_HIT[noteToHit] - (FREQUENCY_TO_HIT[noteToHit]*20)/100 || 
    referenceFreq > FREQUENCY_TO_HIT[noteToHit] + (FREQUENCY_TO_HIT[noteToHit]*20)/100)
  {
    resetSingingLed();
    middleRing();
  }
}

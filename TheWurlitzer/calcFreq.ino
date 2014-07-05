
/*** CONNECT FREQ SOURCE TO PIN 2 ***/

//http://forum.arduino.cc//index.php?topic=64219.30

/*** INTERRUPT SERVICE ROUTINE ***/
void isr(){
  unsigned long now = micros();
  if (numPulses == 1){
    firstPulseTime = now;
  }
  else{
    lastPulseTime = now;
  }
  ++numPulses;
}

/*** READ FREQ ***/
float readFrequency(unsigned int sampleTime)
{
  numPulses = 0;                      // prime the system to start a new reading
  attachInterrupt(0, isr, RISING);    // enable the interrupt
  delay(sampleTime);
  detachInterrupt(0);
  return (numPulses < 3) ? 0 : (1000000.0 * (float)(numPulses - 2))/(float)(lastPulseTime - firstPulseTime);
}

/*** THIS IS CALLED BY LOOP ***/
//int calcFreq(){
//  int currentFreq = readFrequency(timeToMeasure);
//  return currentFreq;
//}








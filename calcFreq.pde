float calcFreq() {
  float frequency = 0;

  background(0);
  drawGrid();
  fill(c);


  fft.forward(in.left);
  for (int f=0;f<sampleRate/2;f++) { //analyses the amplitude of each frequency analysed, between 0 and 22050 hertz
    max[f]=fft.getFreq(float(f)); //each index is correspondent to a frequency and contains the amplitude value
  }
  maximum=max(max);//get the maximum value of the max array in order to find the peak of volume

  for (int i=0; i<max.length; i++) {// read each frequency in order to compare with the peak of volume
    if (max[i] == maximum) {//if the value is equal to the amplitude of the peak, get the index of the array, which corresponds to the frequency
      frequency = i;
    }
  }

  total= total - readings[index];         
  readings[index] = frequency; 
  total= total + readings[index];       
  index = index + 1;                    

  if (index >= numReadings) {  
    average = total / numReadings; 
    index = 0;
  }      

  midi= 69+14*(log((frequency-6)/440));// formula that transform frequency to midi numbers
  midiNote = int (midi);//cast to int
  if(readings[0] != readings[1]){
    resetSingingLed();
    displaySingingNotes(frequency);
  }

  textSize(20);
  fill(0, 255, 255);
  text (frequency-6+" hz", 10, 20);//display the frequency in hertz
  
  return frequency;
}

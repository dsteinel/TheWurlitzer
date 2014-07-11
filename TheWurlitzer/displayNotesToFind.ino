int displayNotesToFind(int thisLevel){
  switch (thisLevel) {
  case 1:
    digitalWrite(LED[51], HIGH);
    digitalWrite(LED[52], HIGH);
    digitalWrite(LED[59], HIGH);
    digitalWrite(LED[60], HIGH);
    break;

  case 2:
    digitalWrite(LED[51], HIGH);
    digitalWrite(LED[52], HIGH);
    digitalWrite(LED[59], HIGH);
    digitalWrite(LED[60], HIGH);
    
    digitalWrite(LED[35], HIGH);
    digitalWrite(LED[36], HIGH);
    digitalWrite(LED[43], HIGH);
    digitalWrite(LED[44], HIGH);
    break;

  case 3:
    digitalWrite(LED[51], HIGH);
    digitalWrite(LED[52], HIGH);
    digitalWrite(LED[59], HIGH);
    digitalWrite(LED[60], HIGH);
    
    digitalWrite(LED[35], HIGH);
    digitalWrite(LED[36], HIGH);
    digitalWrite(LED[43], HIGH);
    digitalWrite(LED[44], HIGH);
    
    digitalWrite(LED[19], HIGH);
    digitalWrite(LED[20], HIGH);
    digitalWrite(LED[27], HIGH);
    digitalWrite(LED[28], HIGH);
    break;
    
  case 4:
    digitalWrite(LED[3], HIGH);
    digitalWrite(LED[4], HIGH);
    digitalWrite(LED[11], HIGH);
    digitalWrite(LED[12], HIGH);
    
    digitalWrite(LED[19], HIGH);
    digitalWrite(LED[20], HIGH);
    digitalWrite(LED[27], HIGH);
    digitalWrite(LED[28], HIGH);
    
    digitalWrite(LED[35], HIGH);
    digitalWrite(LED[36], HIGH);
    digitalWrite(LED[43], HIGH);
    digitalWrite(LED[44], HIGH);
    
    digitalWrite(LED[51], HIGH);
    digitalWrite(LED[52], HIGH);
    digitalWrite(LED[59], HIGH);
    digitalWrite(LED[60], HIGH);
    break;
  }
}




void resetAllLed(){
  for (int i = 0; i < 64; i++) {
    digitalWrite(LED[i], LOW);
  }
}

void resetSingingLed(int resetLevel){
  for (int i = 0; i < 64; i++) {
    digitalWrite(LED[i], LOW);
  }
  switch (resetLevel) {
  case 1:
    PORTB = B00000001;
    PORTF = B10000001;
    PORTK = B00000001;
    break;

  case 2:
    PORTB = B00000001;
    PORTF = B10000001;
    PORTK = B00010001;
    PORTC = B00000001;
    PORTD = B10000000;
    PORTL = B00011000;
    break;

  case 3:
    PORTB = B00000001;
    PORTF = B10000001;
    PORTK = B00010001;
    PORTC = B10000001;
    PORTD = B10000001;
    PORTL = B00011000;
    PORTA = B10000001;
    break;

  case 4:
    PORTB = B10000001;
    PORTF = B10000001;
    PORTK = B00010001;
    PORTC = B10000001;
    PORTD = B10000001;
    PORTL = B00011000;
    PORTA = B10000001;
    PORTE = B00001000;
    PORTH = B00001000;
    PORTJ = B00000010;
    break;
  }
}
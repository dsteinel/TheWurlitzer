
void allLedOff(){
  PORTA = B00000000;
  PORTB = B00000000;
  PORTC = B00000000;
  PORTD = B00000000;
  PORTE = B00000000;
  PORTF = B00000000;
  PORTG = B00000000;
  PORTH = B00000000;
  PORTJ = B00000000;
  PORTL = B00000000;
  //analog pins
  PORTF = B00000000;
  PORTK = B00000000;
}

void resetSingingLed(int resetLevel){
  allLedOff();
  
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
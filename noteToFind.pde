void noteToFind(int whichNote){
  if(whichNote == 0){
    c = color (100, 0, 255);
    fill(c);
    float drawX = 120;
    rect(0, drawX, 40, 40);
    rect(60, drawX, 40, 40);
    drawX=drawX+60;
    rect(0, drawX, 40, 40);
    rect(60, drawX, 40, 40);
  }
  if(whichNote == 1){
    c = color (255, 255, 0);
    fill(c);
    float drawX = 240;
    rect(240, drawX, 40, 40);
    rect(300, drawX, 40, 40);
    drawX=drawX+60;
    rect(240, drawX, 40, 40);
    rect(300, drawX, 40, 40);
  }
}

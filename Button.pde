class Button {
  PVector position;
  String text;
  int w; // width
  int h; // height
  color clr;

  Button(PVector pos, int bWidth, int bHeight, String text, color clr) {
    this.position = pos;
    this.text = text;
    this.w = bWidth;
    this.h = bHeight;
    this.clr = clr;
  }

  boolean isOver() {
    return mouseX >= position.x - w/2 
      && mouseX <= position.x + w/2
      && mouseY >= position.y - h/2
      && mouseY <= position.y + h/2;
  }

  void show() {
    stroke(0);
    if (this.isOver()) {
      fill(clr, 50);
    } else {
      fill(clr);
    }
    strokeWeight(3);
    rectMode(CENTER);
    rect(position.x, position.y, w, h);

    fill(0);
    textAlign(CENTER, CENTER);
    text(this.text, position.x, position.y);
  }
}

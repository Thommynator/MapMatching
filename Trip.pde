class Trip {

  ArrayList<PVector> points;

  Trip() {
    this.points = new ArrayList();
  }
  
  void addPoint(PVector point){ 
    this.points.add(point);
  }
  
  void show() {
    for(PVector point : this.points){
     fill(0,200,0);
     strokeWeight(1);
     stroke(55);
     ellipseMode(CENTER);
     ellipse(point.x, point.y, 10, 10);
    }
  }
}

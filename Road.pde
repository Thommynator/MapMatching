class Road {

  ArrayList<PVector> nodes;
  int radius;

  Road() {
    this.nodes = new ArrayList();
    this.radius = 4;
  }

  void addNode(PVector newNode) {
    this.nodes.add(newNode);
  }

  void show() {
    if (nodes.size() == 0) return;
    stroke(0);
    strokeWeight(3);
    for (int i=0; i < this.nodes.size() -1; i++) {
      ellipse(nodes.get(i).x, nodes.get(i).y, radius, radius);
      line(nodes.get(i).x, nodes.get(i).y, nodes.get(i+1).x, nodes.get(i+1).y);
    }
    int last = nodes.size()-1;
    ellipse(nodes.get(last).x, nodes.get(last).y, radius, radius);
  }
}

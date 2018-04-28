ArrayList<Road> roads;
Button addRoadBtn;
boolean addNewRoadFlag;
int pointerSize = 15;

void setup() {
  size(800, 600);
  roads = new ArrayList();
  addRoadBtn = new Button(new PVector(50, 30), 80, 40, "New Road", color(0, 200, 0));
  addNewRoadFlag = false;
  roads.add(new Road());
  background(200);
}

void draw() {
  background(200);

  addRoadBtn.show();

  noStroke();
  fill(0, 50);
  ellipse(mouseX, mouseY, pointerSize, pointerSize);



  for (Road road : roads) {
    road.show();
  }
}


void mousePressed() {

  if (addRoadBtn.isOver()) {
    addNewRoadFlag = true;
    return;
  } 

  if (addNewRoadFlag) {
    roads.add(new Road());
    addNewRoadFlag = false;
  }
  int last = roads.size() - 1;
  roads.get(last).addNode(findNearestNode());
}

PVector findNearestNode() {
  int threshold = pointerSize;
  float closestDist = 100000;
  PVector mousePos = new PVector(mouseX, mouseY);
  PVector closestPos = mousePos;

  for (Road road : roads) {
    for (PVector node : road.nodes) {
      float distance = mousePos.dist(node);
      if (distance <= threshold && distance < closestDist) {
        closestPos = node;
      }
    }
  }
  return closestPos;
}

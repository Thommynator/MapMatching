ArrayList<Road> roads;
Button addRoadBtn;
Button importRoadsBtn;
Button exportRoadsBtn;
boolean addNewRoadFlag;
int pointerSize = 15;

void setup() {
  size(800, 600);
  roads = new ArrayList();
  addRoadBtn = new Button(new PVector(50, 30), 80, 40, "New Road", color(0, 200, 0));
  importRoadsBtn = new Button(new PVector(150, 30), 80, 40, "Import", color(0, 200, 0));
  exportRoadsBtn = new Button(new PVector(250, 30), 80, 40, "Export", color(0, 200, 0));

  addNewRoadFlag = false;
  roads.add(new Road());
  background(200);
}

void draw() {
  background(200);

  addRoadBtn.show();
  importRoadsBtn.show();
  exportRoadsBtn.show();

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
  if (importRoadsBtn.isOver()) {
    return;
  }
  if (exportRoadsBtn.isOver()) {
    selectOutput("Select a file to write to:", "exportRoads");
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

void exportRoads(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("Saved file to: " + selection.toString());
    saveJSONObject(roadsToJSON(), selection.getAbsolutePath());
  }
}

JSONObject roadsToJSON() {
  JSONObject roadsJSON = new JSONObject();
  JSONArray tmpRoadsJSON = new JSONArray();

  for (int i=0; i<roads.size(); i++) {
    tmpRoadsJSON.setJSONObject(i, roads.get(i).toJSON());
  }
  roadsJSON.setJSONArray("roads", tmpRoadsJSON);
  return roadsJSON;
}

RoadNetwork roadNetwork;
Button addRoadBtn;
Button importRoadsBtn;
Button exportRoadsBtn;
boolean addNewRoadFlag;
int pointerSize = 15;

void setup() {
  size(800, 600);
  roadNetwork = new RoadNetwork();
  addRoadBtn = new Button(new PVector(50, 15), 80, 20, "New Road", color(0, 200, 0));
  importRoadsBtn = new Button(new PVector(150, 15), 80, 20, "Import", color(0, 200, 0));
  exportRoadsBtn = new Button(new PVector(250, 15), 80, 20, "Export", color(0, 200, 0));

  addNewRoadFlag = false;
  roadNetwork.addRoad(new Road());
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

  roadNetwork.show();
}


void mousePressed() {

  if (addRoadBtn.isOver()) {
    addNewRoadFlag = true;
    return;
  } 
  if (importRoadsBtn.isOver()) {
    selectInput("Select a JSON file to load from:", "importRoads");
    return;
  }
  if (exportRoadsBtn.isOver()) {
    selectOutput("Select a file to write to:", "exportRoads");
    return;
  }

  if (addNewRoadFlag) {
    roadNetwork.addRoad(new Road());
    addNewRoadFlag = false;
  }
  roadNetwork.addNodeToLastRoad(roadNetwork.findNearestNode(mouseX, mouseY));
}

void exportRoads(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("Saved file to: " + selection.toString());
    saveJSONObject(roadNetwork.toJSON(), selection.getAbsolutePath());
  }
}

void importRoads(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("Loaded file from: " + selection.toString());
    JSONObject json = loadJSONObject(selection.getAbsolutePath());
    roadNetwork = new RoadNetwork(json);
  }
}

RoadNetwork roadNetwork;
Trip trip;

Button addRoadBtn;
Button generateTripBtn;
Button importRoadsBtn;
Button exportRoadsBtn;
Button deleteTripBtn;

boolean generateTripFlag;
boolean addNewRoadFlag;
int pointerSize = 25;

void setup() {
  size(800, 600);
  roadNetwork = new RoadNetwork();
  trip = new Trip();
  addRoadBtn = new Button(new PVector(50, 15), 90, 20, "New Road", color(0, 200, 0, 128));
  generateTripBtn = new Button(new PVector(150, 15), 90, 20, "Generate Trip", color(0, 200, 0, 128));
  importRoadsBtn = new Button(new PVector(250, 15), 90, 20, "Import", color(0, 200, 0, 128));
  exportRoadsBtn = new Button(new PVector(350, 15), 90, 20, "Export", color(0, 200, 0, 128));
  deleteTripBtn = new Button(new PVector(450, 15), 90, 20, "Delete Trip", color(0, 200, 0, 128));

  addNewRoadFlag = false;
  generateTripFlag = false;
  roadNetwork.addRoad(new Road());
  background(200);
}

void draw() {
  background(200);
  noStroke();
  fill(0, 50);
  ellipse(mouseX, mouseY, pointerSize, pointerSize);

  roadNetwork.show();
  trip.show();
  showButtons();
}

void showButtons() {
  addRoadBtn.show();
  generateTripBtn.show();
  importRoadsBtn.show();
  exportRoadsBtn.show();
  deleteTripBtn.show();
}


void mousePressed() {
  if (addRoadBtn.isOver()) {
    addNewRoadFlag = true;
    generateTripFlag = false;
    return;
  } 
  if (generateTripBtn.isOver()) {
    addNewRoadFlag = false;
    generateTripFlag = true;
    return;
  } 
  if (deleteTripBtn.isOver()) {
    addNewRoadFlag = false;
    generateTripFlag = false;
    trip = new Trip();
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

  if (generateTripFlag) {
    trip.addPoint(new PVector(mouseX, mouseY));
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

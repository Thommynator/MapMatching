class RoadNetwork {

  ArrayList<Road> roads;
  RoadNetwork() {
    this.roads = new ArrayList();
  }

  RoadNetwork(JSONObject importJSON) {
    this.roads = new ArrayList();
    JSONArray roadsJSON = importJSON.getJSONArray("roads");
    for (int i = 0; i < roadsJSON.size(); i++) {
      this.addRoad(new Road(roadsJSON.getJSONObject(i)));
    }
  }

  void addRoad(Road road) {
    roads.add(road);
  }

  void addNodeToLastRoad(PVector node) {
    int last = roads.size() - 1;
    roads.get(last).addNode(node);
  }

  void show() {
    for (Road road : roads) {
      road.show();
    }
  }

  /**
   * Finds the nearest node to a specific coordinate.
   * If no node is close enough, the original coordinate 
   * is returned.
   */
  PVector findNearestNode(int x, int y) {
    int threshold = pointerSize;
    float closestDist = 100000;
    PVector mousePos = new PVector(x, y);
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

  JSONObject toJSON() {
    JSONObject roadsJSON = new JSONObject();
    JSONArray tmpRoadsJSON = new JSONArray();

    for (int i=0; i<roads.size(); i++) {
      tmpRoadsJSON.setJSONObject(i, roads.get(i).toJSON());
    }
    roadsJSON.setJSONArray("roads", tmpRoadsJSON);
    return roadsJSON;
  }
}

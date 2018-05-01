class Road {

  ArrayList<PVector> nodes;
  int radius;

  Road() {
    this.radius = 4;
    this.nodes = new ArrayList();
  }

  Road(JSONObject importJSON) {
    this.radius = 4;
    this.nodes = new ArrayList();

    JSONArray nodesJSON = importJSON.getJSONArray("nodes");
    for (int i = 0; i < nodesJSON.size(); i++) {
      JSONObject node = nodesJSON.getJSONObject(i); 
      this.addNode(new PVector(node.getFloat("x"), node.getFloat("y")));
    }
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

  JSONObject toJSON() {
    JSONObject roadJSON = new JSONObject();
    JSONArray nodesJSON = new JSONArray();

    for (int i=0; i<nodes.size(); i++) {
      JSONObject nodeJSON = new JSONObject();
      nodeJSON.setFloat("x", nodes.get(i).x);
      nodeJSON.setFloat("y", nodes.get(i).y);
      nodesJSON.setJSONObject(i, nodeJSON);
    }
    roadJSON.setJSONArray("nodes", nodesJSON);
    return roadJSON;
  }
}

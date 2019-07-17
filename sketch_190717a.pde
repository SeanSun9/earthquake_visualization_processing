float angle = 0.0;
Table table;
float zoomLevel = 1.0;
PImage img;
float clon = 0.0;
float clat = 0.0;

void setup(){
  size(1024,512);
  table = loadTable("query.csv","header" );
  img = loadImage("map.png");
  translate(width*0.5,height*0.5);
  imageMode(CENTER);
  image(img,0,0);
  
  for(TableRow row : table.rows()){
    float lat = row.getFloat("latitude");
    float lon = row.getFloat("longitude");
    float mag = row.getFloat("mag");
    println(lat,lon,mag);
    
    mag = pow(10,mag);
    mag = sqrt(mag);
    
    float maxmag = sqrt(pow(10,10));
    float diameter = map(mag,0,maxmag,0,30);
    float color1 = map(mag,0,maxmag,0,255);
    
    float cx = webMercatorX(clon);
    float cy = webMercatorY(clat);
    float x = webMercatorX(lon) - cx;
    float y = webMercatorY(lat) - cy;
    fill(255,color1,0);
    noStroke();
    ellipse(x,y,diameter,diameter);
    
    
  }


}

void draw(){
}

public float webMercatorX(float lon){
    lon = radians(lon);
    float a = (256/PI)*pow(2,zoomLevel);
    float b = lon + PI;
    return a*b;

}

public float webMercatorY(float lat){
    lat = radians(lat);
    float a = (256/PI)*pow(2,zoomLevel);
    float b = tan(PI/4 + lat/2);
    float c = PI - log(b);
    return a*c;

}

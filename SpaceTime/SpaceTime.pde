//Car Colors
XML SpeedData;

float sec = 0;
float min = 0;
float hr = 0;
int startnumber=0; //61?

String timeFlow = "SPACE|TIME";
String by = "by Machiel Kapiteijn";

float xmultiplier = 1;
float xtime = 10; //time multiplier
float xdistance = 10;
float xscale = 10;// distance muliplier

int resetlapse =1;
int scalelimit = 5000;
int minspeed = -1;
int speeduplimit = 600;
int numOfRacers = 40;  //number of things
int [] position = new int [numOfRacers]; // an array for the position of each country's data

float [] howFar = new float [numOfRacers]; // an array for the position of each country's data
float [] speed = new float [numOfRacers]; // an array for the position of each country's data
int [] lapse = new int [numOfRacers]; // an array for the position of each country's data
float [] distance = new float [numOfRacers]; // an array for the position of each country's data
float [] distanceMeter = new float [numOfRacers]; // an array for the position of each country's data
String [] racerNames = new String [numOfRacers]; //an array for the country names 


void setup() {

  size(1920, 1080);
  //Create background
  background(0);
  textSize(30);

  //PFont font;
  //font = createFont("MAG.ttf", 4);
  //textFont(font, 4);


  //Loads the xml file
  SpeedData = loadXML("speedDataset.xml");
  //Each piece of information is recognized with the .getChildren function
  XML [] racers = SpeedData.getChildren("racer");



  for (int i = 0; i < numOfRacers; i++) {

    speed[i] = racers[i].getInt("MoveSpeed");


    racerNames[i] = racers[i].getContent();
    //The spacing between each piece of data

    position [i] += 20 + (i * (height/numOfRacers));
  }
}

void draw() {




  if (xscale<1) {
    xscale=1;
  };
  background (0);

  if (xscale >= scalelimit) {
    xscale=scalelimit;
  }
  if (xtime >= speeduplimit) {
    xtime=speeduplimit;
  }
  if (xtime <= minspeed) {
    xtime=minspeed;
  }
  if (xmultiplier<= minspeed) {
    xmultiplier=minspeed;
  }
  if (xmultiplier>= speeduplimit) {
    xmultiplier=speeduplimit;
  }



  stroke(20);
  //for (int i = 1; i <numOfRacers; i++) { line(0,1*i,height/xscale*i,width);}
  if (xscale<=100) {
    for (int i = 1; i <xscale; i++) { 
      line(width/xscale*i, 0, width/xscale*i, height);
    }
  }

  //if (xscale>100 && xscale <1000) {
  //  for (int i = 1; i <xscale*100; i++) { 
  //    line(width/xscale*100*i, 0, width/xscale*100*i, height);
  //  }
  //}

  //if (xscale>=1000 && xscale <10000) {
  //  for (int i = 1; i <xscale; i++) { 
  //    line(width/xscale*100*i, 0, width/xscale*100*i, height);
  //  }
  //}



  //for (int i = 1; i <numOfRacers; i++) { line(width/i,height/1,height/1,width/i);}
  //for (int i = 1; i <xscale; i++) { line(width/xscale*i,0,width/xscale*i,height);}
  //for (int i = 1; i <numOfRacers; i++) { line(height/numOfRacers*i,5,height/numOfRacers*i,height/numOfRacers*i);}
  stroke(15);
  for (int i = 1; i <numOfRacers; i++) { 
    line(0, height/numOfRacers*i, 1920, height/numOfRacers*i);
    
   

    if (lapse[i]<500) {
      fill(lapse[i]*20, lapse[i]*7, 60+lapse[i]*2);
    }
    if (lapse[i]>500) {
      fill(lapse[i]*0.92, lapse[i]*0.85, 70+lapse[i]*0.72);
    }
    text(lapse[i], 1890, position[i]);
    fill(255, 255, 255);
  }




  text(String.format("%.0f", xscale)+" km lap", 1840, 1040);
  text(String.format("%.1f", xtime/10)+"x speed", 1840, 1020);
  fill(225, 39, 100);
  fill(70);
  text("Use the ARROW keys to warp SPACE and TIME", 1360, 1020);
  textSize(9);
  text("LEFT and RIGHT = SPACE | UP and DOWN = TIME", 1412, 1040);
  fill(255);
  textSize(12);
  //if(xtime==1){text("Realtime", 1840, 1020);}


  noStroke();
  for (int i = 0; i <numOfRacers; i++) { 
    stroke(mouseX/70);
    //if (mouseX > howFar[i]/xscale){line(howFar[i]/xscale, position[i], mouseX, mouseY);}
    //if (howFar[i]-howFar[9] < 50){line(howFar[i]/xscale, position[i]/xscale, position[9]/xscale, howFar[9]/xscale);}
    //stroke(0,255,0);
    stroke(30);
    fill(255);
    line(howFar[i]/xscale, position[i], 0, position[i]);
    noStroke();
  }


  //clock
  sec = sec + 1*xtime/10;
  if (sec > 3600) {
    sec = 0; 
    min = min+1;
    
    fill(20);
    rect(0,0,1920,1080);
    
  }

  if (sec < 0 && min < 1) {
    sec = 0+1;
  }

  if (sec < 0 && min >= 1) {
    sec = 59*60; 
    min = min-1;
  }

  if (min > 60) {
    min = 0; 
    hr = hr+1;
    
    fill(80);
    rect(0,0,1920,1080);
    
 
  }

  if (min < 0 && hr >= 1) {
    min = 59; 
    hr = hr-1;
  }

  text(String.format("%.0f", sec/60)+" seconds ", 1850, 22);
  text(String.format("%.0f", min)+" minutes ", 1850, 37);
  text(String.format("%.0f", hr)+" hours ", 1850, 52);



  fill(255, 255, 255);
  //String.format("%.2f", xtime);
  //for (int i = 1; i <11; i++) { text(0.1 / xtime * i,width/10*i+10,20);}

  if (xscale<50) {  
    textSize(9);
    for (int i = 1; i <xscale; i++) { 
      text(i+"km", width/xscale*i, 10);
    }
  }

  if (xscale>=50 && xscale <= 100) {  
    textSize(9);
    for (int i = 1; i <xscale; i++) { 
      text(i, width/xscale*i, 10);
    }
  }


  if (xscale>100 && xscale <= 1000) {  
    textSize(9);
    for (int i = 1; i <xscale; i++) { 
      text(i*100+"km", width/xscale*i*100, 10);
    }
  }


  if (xscale>=1000 && xscale <= 10000) {  
    textSize(9);
    for (int i = 1; i <xscale; i++) { 
      text(i*1000+"km", width/xscale*i*1000, 10);
    }
  }

  if (xscale>=10000 && xscale <= 100000) {  
    textSize(9);
    for (int i = 1; i <xscale; i++) { 
      text(i*10000+"km", width/xscale*i*10000, 10);
    }
  }

  if (xscale>=100000 && xscale <= 1000000) {  
    textSize(9);
    for (int i = 1; i <xscale; i++) { 
      text(i*100000+"km", width/xscale*i*100000, 10);
    }
  }




  textSize(12);


  //for (int i = 1; i <11; i++) { text("m",width/10*i+45+8*metermove,20);}
  fill(0);





  for (int i = 0; i < numOfRacers; i++) {
    //////////////////////////////////////////////


    fill(0.1* speed[i], 30, 120, 255);

    //howFar[i] = howFar[i] + speed[i] / 1125; // * 0.00889? 1920/60=32
    //distance[i] = distance[i] + speed[i]/ 1125;
    //howFar[i] = howFar[i] + speed[i] * 0.000889;  //10x slower
    //distance[i] = distance[i] + speed[i]* 0.000889; //10x slower
    distanceMeter[i] = distanceMeter[i] + speed[i]* 0.000889 * xtime; // how far has the racer traveled * how fast time is going
    distance[i] = distance[i] + speed[i]* 0.000889 * xtime; // how far has the racer traveled * how fast time is going
    howFar[i] = howFar[i] + speed[i] * 0.000889 *xtime + startnumber ;  //where is racer + it's speed every frame (60fps) / how big the distance scale is
    //distance gives how far it has traveled
    ellipse(howFar[i]/xscale, position[i], height/numOfRacers-20, height/numOfRacers-20);

    howFar[i] = lerp(howFar[i], howFar[i], 0.01);
    fill(0.1* speed[i], 30, 120, 50);
    //ellipse(howFar[i]/xscale, position[i],  speed[i]*0.001+10/xscale,  speed[i]*0.001+10/xscale);
    ellipse(howFar[i]/xscale, position[i], height/numOfRacers-10 + speed[i]*0.001, height/numOfRacers-10 + speed[i]*0.001);
    //lapse[i] = howFar[i] / 1920;



    lapse[i]=lapse[i]*resetlapse;

    if (howFar[i] > 1920*xscale) {
      startnumber=0;
      howFar[i] = 0; 
      lapse[i]=lapse[i]*resetlapse+1;
      fill(0.2* speed[i], 30, 90, 255);
      rect(0, position[i]-8, 1920, 15);
    }

    if (howFar[i] < -10*xscale) {
      howFar[i] = 1920*xscale; 
      lapse[i]=lapse[i]-1;
      fill(50);
      rect(0, position[i]-8, 1920, 15);
    }
    //fill(255);
    //if (speed[i]*xtime/xscale > 150000) {rect(0, position[i]-8, 1920, 15);}
  }







  fill(255, 255, 255);



  for (int i = 0; i < numOfRacers; i++) {


    /////////////////////////////////////////////////////////////
    //fill(25, 255, 25);
    fill(255, 255, 255);
    textSize(9);
    text(racerNames[i], howFar[i]/xscale, position[i]);
    textSize(8);
    text((String.format("%.0f", speed[i])+" kmp/h"), howFar[i]/xscale, position[i]+7);
    textSize(12);
    fill(255, 255, 255);
    //text("round",100, position[i]);

    //fill(lapse[i]*10,lapse[i]*2,lapse[i]*4);
    //text(lapse[i], 1890, position[i]);
    //fill(50, 255, 0);



    //text((String.format("%.0f", speed[i])+" kmp/h"),300, position[i]);  // shows speed km/h from database 




    //text(distance[i]/1920, howFar[i], position[i]);
  }


  fill(0, 0, 0, 200);
  rect(0, 0, width/10, 1080);

  for (int i = 0; i < numOfRacers; i++) {

    fill(0.1* speed[i], 30, 120);
    rect(0, position[i]-20, 3, height/numOfRacers-3);

    fill(255, 255, 255);
    textSize(10);

    text(racerNames[i], 10, position[i]); // shows names of racers
    textSize(9);
    text(String.format("%.2f", distanceMeter[i]/1920)+" km", 145, position[i]); // shows distance traveled
    textSize(12);

    if (howFar[i] < -10*xscale) {
      howFar[i] = 1920*xscale; 
      lapse[i]=lapse[i]-1;
      fill(50);
      rect(0, position[i]-8, 1920, 15);
    }
  }
  textSize(30);
  text(timeFlow, 1650, 1030);
  textSize(12);
  text(by, 1705, 1045);

  //float mousescale = mouseX;   
  //float mousescale = mouseX;   
  //mousescale = map(mousescale, 0, 1920, 1, 10);
  //xscale=mousescale;

  //float mousemap = mouseY;   
  //float mousemap = mouseY;
  //mousemap = map(mousemap, 1080, 0, 1, 10);
  //xtime=mousemap;
}






void keyPressed() {


  if (keyCode == DOWN ) {

    //xtime=xtime-xtime/xmultiplier;
    //xmultiplier=xmultiplier-1;

    //if(xtime == 0){xtime=xtime/2;}

    xtime=xtime/1.1;
    xmultiplier=xmultiplier/1.1;
  }
  if (keyCode == UP) {


    xtime=xtime+xtime/xmultiplier;
    xmultiplier=xmultiplier+1;
  }

  if (key == 'x') {
    xtime=xtime*10;
  }

  if (key == 'z') {
    xscale=xscale*10;
  }

  //if (key == '1'){xtime=0.1;
  //   textSize(50);
  //  text("TIME X1",950,500);
  // timeFlow = "TIME X1";}

  //if (key == '2'){xtime=1;
  //  textSize(50);
  //  text("TIME X10",950,500);
  // timeFlow = "TIME X10";}

  // if (key == '3'){xtime=10;
  //  textSize(50);
  //  text("TIME X100",950,500);
  // timeFlow = "TIME X100";}

  // if (key == '4'){xtime=100;}

  if (key == 'q') {
    for (int i = 1; i <11; i++) { 
      xdistance =xdistance+0.1;
    }
  }

  if (keyCode == RIGHT) {

    //for (int i = 1; i <11; i++) { 
    //  xscale = lerp(xscale, xscale+1, 0.01);
    // }

    xscale =xscale+xscale/100;
    resetlapse=0;
  }
  if (keyCode == LEFT) {
    // xscale =xscale-1;


    //if (key == 'm'){xscale =xscale*1.1;}
    //if (key == 'n'){xscale =xscale*0.1;}

    xscale =xscale-xscale/100;
    resetlapse=0;
  }



  if (key == 'w') {
    xscale=1;
  }


  if (key == ' ') {
    resetlapse=1;
  }


  if (key == 'e') {
    xscale=10;
  }
  if (key == 'r') {
    xscale=100;
  }



  //if (key == 'a'){scale=scale*0.1;}
  //if (key == 'd'){scale=scale*10;}
}

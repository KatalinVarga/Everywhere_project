//ref.https://forum.arduino.cc/t/read-serial-value-in-processing-solved/263131

import processing.serial.*; // import library for reading Arduino data
import processing.sound.*; // library for sound

//sound file:( ref.:https://freesound.org/people/ximian/sounds/259598/#comments)
SoundFile calling; 

Serial myPort;  // Create object from Serial class
static String val;    // Data received from the serial port

boolean overBox = false;    
boolean hasClicked = false;
boolean call= false;
boolean callSound = false;

// sensor value variable
int sensorVal = 0;


// variables for Back button
float x = 100;
float y = 30;
float w = 80;
float h = 30;

//variables for Next button
float x1 = 1590;
float y1 = 30;
float w1 = 80;
float h1 = 30;

// patient images are generated randomly at initialisation 
int randomNumberForPatients = int(random(1,12));
// creatinine value generated randomly within the normal range.cHI - normal range reference.:https://labs.selfdecode.com/blog/creatinine-urine-test/ 
int randomNumberCreatinine = int (random(20,275)); // normal range
int randomNumberCreatinine2 = int (random(321,390)); // abnormal value -ref.:https://labs.selfdecode.com/blog/creatinine-urine-test/

// variables for patient data (personal and dietary, and measurement values)
String name;
int age;
int cms;
int kgs;
String BMI;
float cmsConversion;
float square;
float calc;
float proteins;
float fats;
float carbs;
String water;
int vitamins;
int minerals;
float consumedProtein;
float consumedCarbs;
float consumedFats;


// Images' variables:
// frame
PImage img0; 

// faces:
PImage img1;

// check mark:    //<a href="https://www.flaticon.com/free-icons/tick" title="tick icons">Tick icons created by Octopocto - Flaticon</a> reference for check mark sign
PImage img2;

// icon for video call -ref. <a href="https://www.flaticon.com/free-icons/videocall" title="videocall icons">Videocall icons created by lakonicon - Flaticon</a>
PImage img3;

// call window
PImage img4;

// warning sign from https://www.vecteezy.com/png/12042301-warning-sign-icon-transparent-background
PImage img5;
 
 
void setup()
{

 size(1920,1080, P3D);  // my screen size
// loading files
   calling = new SoundFile(this, "calling.wav");
  
   img0 = loadImage("frame.png");
   img2= loadImage("check-mark.png");
   img3= loadImage("videocall.png");
   img4= loadImage("callwindow.png");
   img5= loadImage("exclamation.png");
  
// port for Arduino:    
  String portName = "COM3";// Change the number (in this case ) to match the corresponding port number connected to your Arduino. 

  myPort = new Serial(this, portName, 9600);
}

void draw(){
    // the patient face image is loading within the draw function as it is randomised
    img1 = loadImage(randomNumberForPatients+".jpg");
    scale(1);
    image(img0,0,0 ); // frame
    
    
 // Back button   
    fill(255);
    stroke(35, 35, 35);
    // hover over Back button - colour change:
   if(mouseX>x && mouseX <x+w && mouseY>y && mouseY <y+h){
      overBox = true;
       
      fill(240);
    }
    rect(x,y,w,h);  // Back button: reference:https://forum.processing.org/one/topic/simple-button-tutorial.html
 
    
// Next button    
      // hover over Next button - colour change:
        fill(255);
    stroke(35, 35, 35);
    // hover over back button - colour change:
   if(mouseX>x1 && mouseX <x1+w1 && mouseY>y1 && mouseY <y1+h1){
      overBox = true;
       
      fill(240);
    }
    rect(x1,y1,w1,h1);

     
 // X at the corner to exit:    
   if(mousePressed){
    if( mouseX>width-80 && mouseX <width-35 && mouseY>20 && mouseY <50 ){
         exit();
    }
   }

 
  scale(0.1); // scaling images of faces 

  image(img1,1000,1100);  // patient's face
  
   
 scale(10); // reverting to normal scaling 1/1
 
 fill(0);

 image(img3,100,225 ); // videocall icon
 // Patient data for corresponding images
   if (randomNumberForPatients == 1){
       name = "Anne-Marie Smith";
       age = 59;
       cms = 170;
       kgs = 70;
       minerals = 7;
       vitamins = 7;
       water = "14";
 
    
  }
  if (randomNumberForPatients == 2){
       name = "Kimaya Sita";
       age = 30;
       cms = 180;
       kgs = 68;
       minerals = 6;
       vitamins = 7;
       water = "10";
   }
   
  if (randomNumberForPatients == 3){
       name = "Andrew Tanner";
       age = 28;
       cms = 165;
       kgs = 55;
       minerals = 7;
       vitamins = 5;
       water = "16";
      
  }
  if (randomNumberForPatients == 4){
      name = "Ismail Ibrahim";
       age = 32;
       cms = 180;
       kgs = 80;
       minerals = 7;
       vitamins = 7;
       water = "20";
 
  }
  if (randomNumberForPatients == 5){
      name = "Chao Ying";
       age = 20;
       cms = 165;
       kgs = 50;
       minerals = 7;
       vitamins = 7;
       water = "  9";
    
  }
  if (randomNumberForPatients == 6){
       name = "Kendra Wallis";
       age = 37;
       cms = 175;
       kgs = 65;
       minerals = 4;
       vitamins = 7;
       water = "13";
     
  }
  if (randomNumberForPatients == 7){
       name = "Sandra Amoy";
       age = 19;
       cms = 163;
       kgs = 65;
       minerals = 7;
       vitamins = 7;
       water = "15";
   
  }
  if (randomNumberForPatients == 8){
       name = "Peter Shapland";
       age = 29;
       cms = 180;
       kgs = 72;
       minerals = 0;
       vitamins = 7;
       water = "18";
     
  }
  if (randomNumberForPatients == 9){
       name = "Sienna Pearson";
       age = 22;
       cms = 165;
       kgs = 75;
       minerals = 7;
       vitamins = 7;
       water = "14";
      
  }
  if (randomNumberForPatients == 10){
       name = "Mary Leonard";
       age = 65;
       cms = 168;
       kgs = 60;
       minerals = 7;
       vitamins = 7;
       water = "12";
 
  }
   if (randomNumberForPatients == 11){
       name = "Faye Townsend";
       age = 36;
       cms = 180;
       kgs = 120;
       minerals = 7;
       vitamins = 2;
       water = "21";
 
  }
   if (randomNumberForPatients == 12){
       name = "Lewis Peterson";
       age = 34;
       cms = 185;
       kgs = 130;
       minerals = 7;
       vitamins = 7;
       water = "14";
 
  }

      
 
 // Patient name, age, weight, height, BMI for images
    textSize(18);
    
       text("Name", 300, 140);
       text("Age", 300, 170);
       text("Height", 300, 200);
       text("Weight", 300, 230);
       // BMI is colour-coded for healthy and not-healthy values - ref.:https://therapies.heartofengland.nhs.uk/nutrition-dietetics/bmi-chart/#:~:text=BMI%20between%2018.5-24.9%20This%20is%20a%20healthy%20range.,that%20you%E2%80%99re%20a%20healthy%20weight%20for%20your%20height.
      
      
       text("BMI", 300, 260);
      
       square = cms*cms;
       calc = kgs/square*10000;
       
       BMI=(nf(calc, 0, 2))+" %"; // BMI calculation from  ref.:https://therapies.heartofengland.nhs.uk/nutrition-dietetics/bmi-chart/#:~:text=BMI%20between%2018.5-24.9%20This%20is%20a%20healthy%20range.,that%20you%E2%80%99re%20a%20healthy%20weight%20for%20your%20height.
      
       text(name, 380, 140);
       text(age, 380, 170);
       text(cms+" cms", 380, 200);
       text(kgs+" kgs", 380, 230);
       
        if ( 18.5 < calc && calc < 24.9){
         fill(17, 166, 74); // green - healthy
       }
        if ( calc < 18.5){
         fill(201, 24, 74); // red - not healthy
       }
        if ( 24.9 < calc && calc < 30){
         fill(184, 132, 0); // yellow - not healthy - Obese class 1
       }
          if ( calc > 30){
         fill(201, 24, 74); //  red - not healthy - Obese class 2
       }
       text(BMI, 380, 260);
 
// Text for buttons and top of the frame
   textSize(18);
   fill(35, 35, 35);
   noStroke();
   text("Back", x+20, y+20);
   text("Next", x1+20, y1+20);
   fill(0);
   textSize(35);
   text("RPM (Remote Patient Monitor)", width/2-250,60);
   
// text for white box with known conditions   
   textSize(18);
   fill(0);
   text("Known stress factors", width/2-230,140);
   stroke(0);
   line(width/2-230,144, 913, 144);
   text("Pregnancy", width/2-230,170);
   text("Urinary tract infections", width/2-230,200);
   text("Pressure ulcer/wound", width/2-230,230);
   text("Kidney disease", width/2-230,260);
   //2nd column
   text("Liver disease", width/2+100,170);
   text("Diabetes", width/2+100,200);
   text("Mental illness", width/2+100,230);
   text("D&V", width/2+100,260);// https://www.medicalnewstoday.com/articles/324011#:~:text=Loss%20of%20appetite%20can%20be%20related%20to%20lowered%20immune%20system,condition%20known%20as%20Addison's%20disease ref:loss of appetite causes
  //  diarrhoea/vomiting
   // 3rd column
   text("Mobility issues", width/2+350,170);
   text("Drug-nutrient interactions", width/2+350,200);
   text("Digestive conditions", width/2+350,230);
   text("Other", width/2+350,260);
 

   // tick boxes for stress factors:
   fill(255);
 
   rect(width/2-10, 155, 20, 20);
   rect(width/2-10, 185, 20, 20);
   rect(width/2-10, 215, 20, 20);
   rect(width/2-10, 245, 20, 20);
   
   rect(width/2+240, 155, 20, 20);
   rect(width/2+240, 185, 20, 20);
   rect(width/2+240, 215, 20, 20);
   rect(width/2+240, 245, 20, 20);
   
   rect(width/2+600, 155, 20, 20);
   rect(width/2+600, 185, 20, 20);
   rect(width/2+600, 215, 20, 20);
   rect(width/2+600, 245, 20, 20);
 
       
// Reading the sensor data received from the Arduino

  if ( myPort.available() > 0) {  // If data is available,
  val = myPort.readStringUntil('\n'); 

  try {
   sensorVal = Integer.valueOf(val.trim());
    
  }
  catch(Exception e) {
  ;
  }
  println(sensorVal); // read it and store it in vals!

  }  
  
// left white column - list of measurements  
     fill(0);  // patient data text colour
    noStroke();   
    

       text("Blood glucose level", 100, 320);
       text("Red blood cells", 100, 350);
       text("White blood cells", 100, 380);
       text("Bilirubin count", 100, 410);
       text("Protein", 100, 440);
       text("Crystals", 100, 470);
       text("Ketones", 100, 500);
       text("Nitrites", 100, 530);
       text("Bacteria", 100, 560);
       text("Gravity", 100, 590);
       text("pH", 100, 620);
       text("hCG", 100, 650);
       text("cHI",100,680);
       
// text for last white box at the bottom on the left for notes - demonstration only, no data to display here
        fill(255);
        rect(100,725,465,200);
        fill(0);
        text("Notes:",105,749);
        fill(140);
 // additional patient related information could include the following:       
        text ("Alerts (allergies, disability, etc.)",170,780);
        text ("Recent events",170,830);
        text ("Patient messages",170,880);
       
// lines between data in left white column
       fill(193,199,217);
       noStroke();
     
       rect(280,327,285,5);
       rect(280,357,285,5);
       rect(280,387,285,5);
       rect(280,417,285,5);
       rect(280,447,285,5);
       rect(280,477,285,5);
       rect(280,507,285,5);
       rect(280,537,285,5);
       rect(280,567,285,5);
       rect(280,597,285,5);
       rect(280,627,285,5);
      
       rect(280,657,285,5);
       rect(280,687,285,5);
       strokeWeight(1);
 
 // warning sign in black box- all of these patients are flagged up for some reason, hence the sign is constantly on the screen     
       image(img5,1150,350 ); // warning sign - credit:https://www.vecteezy.com/png/12042301-warning-sign-icon-transparent-background
 
 // Different conditions for sensor values - I have defined ranges where the data changes.Measurements appear on the left in the fields for the list of values and warnings appear in the black box,too, for abnormal values
 
  if (sensorVal > 780){ // the following lines indicate the text and values for the left side column with measurements and  outstanding values also appear on the right with text
           image(img2,width/2+240, 185); 
             fill (201, 24, 74); //red - within this range we get high values for glucose

             text(sensorVal/100+" mmol/L", 300, 320);// blood glucose value  (high glucose level) 
             //Reference for normal range:https://www.diabetes.co.uk/diabetes_care/blood-sugar-level-ranges.html
             //"Normal and diabetic blood sugar ranges
              //For the majority of healthy individuals, normal blood sugar levels are as follows:
              //Up to 7.8 mmol/L (140 mg/dL) 2 hours after eating."- the urine sample can be taken anytime, hence only levels above 7.8 are flagged up
                                        
                  textSize(30);// patient data  in black box on the right
                  text("Blood glucose!",750,400); // highlighted warning
                  textSize(18);
 
// red blood cell count:
             fill (201, 24, 74);//red - most values will be high within range
             if (sensorVal/200 == 4  ||sensorVal/200 <4 ){
                fill (17, 166, 74); // green, as this is within the normal range 
             // red blood cell count - normal range from : https://www.ucsfhealth.org/medical-tests/rbc-urine-test#:~:text=Normal%20Results,vary%20slightly%20among%20different%20laboratories.
             //"Normal Results :A normal result is 4 red blood cells per high power field (RBC/HPF) or less when the sample is examined under a microscope."
             }
             text(sensorVal/200+" RBC/HPF", 300, 350);
                  fill (201, 24, 74); //red
                  
                    if (sensorVal/200 == 4  ||sensorVal/200 <4 ){
                    fill (40); //this would be within the normal range, making it black means it won't be visible in the black box field
                     }
                     
                  textSize(30);// patient data  in black box
                  text("Red blood cell count! ",750,480); // warning
                  textSize(18); // switch back to fontsize 18
                  
// white blood cells:             
              fill (17, 166, 74); // green
              text(sensorVal*10+ " leukocytes/ml ", 300, 380);   // white blood cell count
// bilirubin:
// https://www.mayoclinic.org/tests-procedures/bilirubin/about/pac-20393041#:~:text=Typical%20results%20for%20a%20total,different%20for%20women%20and%20children. Normal range:0.3-1.2  (mg/dL) for adults
              text(sensorVal/1000+" mg/dL", 300, 410);
              
              text("Not present", 300, 440);  // protein
              text("Not present", 300, 470); // crystals
              text("Not present", 300, 500); // ketones
              text("Not present", 300, 530); // nitrites
              text("Not present", 300, 560); // bacteria
              
              text("Normal", 300, 590); // gravity  
             
              text("4.6", 300, 620); // pH -"The normal values range from pH 4.6 to 8.0." Ref.:https://www.mountsinai.org/health-library/tests/urine-ph-test#:~:text=Normal%20Results,from%20pH%204.6%20to%208.0. 
              
              fill (0);// chose a neutral colour for pregnancy
              text("Not present", 300, 650); // pregnancy
              
              fill (17, 166, 74); // green
              text(randomNumberCreatinine+" mg/dL", 300, 680); // cHI - normal range ref.:https://labs.selfdecode.com/blog/creatinine-urine-test/    "The normal range is around 20 – 275 mg/dL in women and 20 – 320 mg/dL in men"
              
// Second sensor value range:
  }
   if (sensorVal > 700 && sensorVal < 780){
             fill (17, 166, 74); // green
             text(sensorVal/100+" mmol/L", 300, 320); // blood sugar
             text(sensorVal/200+" RBC/HPF", 300, 350);// red blood cells -all are under 4, within normal range (ref.above)
             text("10,000 leukocytes/ml ", 300, 380);// white blood cells
             text(sensorVal/1000+" mg/dL", 300, 410);// bilirubin - normal range (ref. above)
             fill (17, 166, 74); // green
              text("Not present", 300, 440);  // protein
              text("Not present", 300, 470); // crystals
              fill (0);
              text("Not present", 300, 650); //hCG
               fill (17, 166, 74); // green
              text("Not present", 300, 500); // ketones
              text("Not present", 300, 530); // nitrites
              text("Not present", 300, 560); // bacteria
              text("Normal", 300, 590); // gravity
              text("4.6", 300, 620); // pH - it is the same for all patients
            
              text(randomNumberCreatinine+" mg/dL", 300, 680); // cHI - normal range ref.:https://labs.selfdecode.com/blog/creatinine-urine-test/    "The normal range is around 20 – 275 mg/dL in women and 20 – 320 mg/dL in men"
   
 
  }
  
//3rd value range  
   if (sensorVal > 600 && sensorVal < 700){
   
              fill (17, 166, 74); // green
              text(sensorVal/100+" mmol/L", 300, 320);// blood sugar level
              text(sensorVal/200+"RBC/HPF", 300, 350);   // red blood cells
              text("10,000 leukocytes/ml ", 300, 380);   // white blood cells
              text("1.2 mg/dL", 300, 410);// bilirubin
              text("Not present", 300, 440);  // protein
              text("Not present", 300, 470); // crystals
              fill (0);
              text("Not present", 300, 650); //hCG
              fill (17, 166, 74); // green
              text("Not present", 300, 500); // ketones
              text("Not present", 300, 530); // nitrites
              text("Not present", 300, 560); // bacteria
              text("Normal", 300, 590); // gravity
              text("6.2", 300, 620); // pH
              text(randomNumberCreatinine+" mg/dL", 300, 680); // cHI - normal range ref.:https://labs.selfdecode.com/blog/creatinine-urine-test/    "The normal range is around 20 – 275 mg/dL in women and 20 – 320 mg/dL in men"
  }
  
//4th value range  
    if (sensorVal > 500 && sensorVal < 600){
             fill (17, 166, 74); // green
             text(sensorVal/100+" mmol/L", 300, 320);
             text("4 RBC/HPF", 300, 350); 
             
               fill (201, 24, 74);//red
               text(sensorVal*10+ " leukocytes/ml ", 300, 380); // white blood count
                          textSize(30);// patient data  in black box  
                          text("White blood count!",750,400);
                          textSize(18);
              fill (17, 166, 74); // green
              text(sensorVal/1000+" mg/dL", 300, 410);
              text("Not present", 300, 440);  // protein
              text("Not present", 300, 470); // crystals
              fill(0);
              text("Not present", 300, 650); //hCG
              fill (17, 166, 74); // green
              text("Not present", 300, 500); // ketones
              text("Not present", 300, 530); // nitrites
              text("Not present", 300, 560); // bacteria
              text("Normal", 300, 590); // gravity
              text("4.6", 300, 620); // pH
              text(randomNumberCreatinine+" mg/dL", 300, 680); // cHI - normal range ref.:https://labs.selfdecode.com/blog/creatinine-urine-test/    "The normal range is around 20 – 275 mg/dL in women and 20 – 320 mg/dL in men"
  }
  
//5th range  
    if (sensorVal > 250 && sensorVal < 500){
             fill (17, 166, 74); // green
          
             text("5.2 mmol/L", 300, 320);
             text("4 RBC/HPF", 300, 350);
             text("10,000 leukocytes/ml ", 300, 380);
             text("1.2 mg/dL", 300, 410);
             text("Not present", 300, 440);  // protein
              
              fill (201, 24, 74);//red
              text("Present", 300, 470); // crystals
                        textSize(30);// patient data  in black box 
                        text("Crystals!",750,395);
                        textSize(18);
              fill (0);
              text("Not present", 300, 650); //hCG
              
              fill (201, 24, 74);//red
              text("Present", 300, 500); // ketones
                        textSize(30);// patient data  in black box 
                        text("Ketones!",750,440);
                        textSize(18);
                        
              fill (17, 166, 74); // green
              text("Not present", 300, 530); // nitrites
              text("Not present", 300, 560); // bacteria
              text("Normal", 300, 590); // gravity
              
              fill (201, 24, 74);//red
              text("4", 300, 620); // pH
                         textSize(30);// patient data  in black box 
                         text("pH!",750,485);
                         textSize(18);
                         
              // picked  a high value for creatinine for this range          
              image(img2,width/2-10, 245); // Kidney disease marked at the top white box in the middle as high value may be indicative of kidney problems . ref.:https://labs.selfdecode.com/blog/creatinine-urine-test/
              text(randomNumberCreatinine2+" mg/dL", 300, 680); // cHI - normal range ref.:https://labs.selfdecode.com/blog/creatinine-urine-test/    "The normal range is around 20 – 275 mg/dL in women and 20 – 320 mg/dL in men"
              textSize(30);// patient data  in black box 
                        text("cHI!",750,530);
                        textSize(18);
  }
  
//6th value range  
      if (sensorVal > 0 && sensorVal < 250){
             fill (201, 24, 74);//red - hypoglycemia, too low blood sugar level (below 3.9mmol/L) //https://medlineplus.gov/ency/patientinstructions/000085.htm#:~:text=Low%20blood%20sugar%20is%20called,a%20cause%20for%20immediate%20action.
             text(sensorVal/100+" mmol/L", 300, 320);
             fill (17, 166, 74); // green
             text("4 RBC/HPF", 300, 350);
             text( "10,000 leukocytes/ml ", 300, 380);
             text("1.2 mg/dL", 300, 410);
             
             fill (201, 24, 74);//red
             text("Present", 300, 440);  // protein - example for protein being present in urine
                           textSize(30);// patient data  in black box 
                           text("Protein!",750,395);
                           textSize(18);
                           
              fill (17, 166, 74); // green
              text("Not present", 300, 470); // crystals
              
              fill (0);
              text("Not present", 300, 650); //hCG
              
              fill (17, 166, 74); // green
              text("Not present", 300, 500); // ketones
              
              fill (201, 24, 74);//red
              text("Present", 300, 530); // nitrites
                            textSize(30);// patient data  in black box 
                            text("Nitrites!",750,440);
                            textSize(18);
              text("Present", 300, 560); // bacteria
                            textSize(30);// patient data  in black box 
                            text("Bacteria!",750,495);
                            textSize(18);
            
              text("Abnormal", 300, 590); // gravity
                            textSize(40);// patient data  in black box 
                            fill(239,188,27); // yellow
                            text("Dehydration risk!",1300,350);
                            textSize(18);
              fill (201, 24, 74);//red  
              text("7.6", 300, 620); // pH - high value( ref. above for normal ranges)
              image(img2,width/2-10, 185); // UTI marked at the top white box for known conditions
              
              fill (17, 166, 74); // green
              text(randomNumberCreatinine+" mg/dL", 300, 680); // cHI - normal range ref.:https://labs.selfdecode.com/blog/creatinine-urine-test/    "The normal range is around 20 – 275 mg/dL in women and 20 – 320 mg/dL in men"
  }
  
   if (sensorVal == 0){ // if value is zero, display "no data"
   fill (0);
   
              text("No data", 300, 320);
              text("No data", 300, 350);
              text( "No data",300, 380);
              text("No data", 300, 410);
              text("No data", 300, 440);  // protein
              text("No data", 300, 470); // crystals
              text("No data", 300, 650); //hCG
              text("No data", 300, 500); // ketones
              text("No data", 300, 530); // nitrites
              text("No data", 300, 560); // bacteria
              text("No data", 300, 590); // gravity
              text("No data", 300, 620); // pH
              text("No data", 300, 680);// cHI
        
      }
      
// Black box field for reported values and warning signs

      if (sensorVal >0){
        // black box:
        fill(255);  // patient data text colour
        text("Average daily intake (waste removal report):",750,600);
        
        // colour coding:
        fill(89, 238, 146); // green
        text("Recommendation",1200,600);
        fill(255); // white
        text("/",1360,600);
        fill(255, 77, 109); // red
        text("Consumption",1375,600);
        
        fill(255);
        strokeWeight(2);
        stroke(255);
        line(750,605,1130,605);
        noStroke();
        rect(750,1150,16,16);
        text("Proteins:",750,640);
        text("Carbohydrates:",750,670);
        text("Fats:",750,700);
        text("Self-reported:",750,750);
        strokeWeight(2);
        stroke(255);
        line(750,755,870,755);
            // reference for source is in Design Journal for daily intake recommendations, page 36 (Reber et al.,2019)
            //proteins 1.5g
             //carbohydrates 5g
             //fats 1.5g/weight/day
        proteins = 1.5*kgs;
        carbs = 5*kgs;
        fats = 1.5*kgs;
        
// Visualisation for comparison of recommended and consumed amounts:        
        // bars for recommended amounts:
        fill(89, 238, 146); // green
        noStroke();
        rect(891,626,proteins,16);
        text(proteins+" gm",896+proteins,629); // displays recommended amount at the end of the bar
        
        rect(891,656,carbs,16);
        text(carbs+" gm",896+carbs,659); // displays recommended amount at the end of the bar
        
        rect(891,686,fats,16);
        text(fats+" gm",896+fats,689); // displays recommended amount at the end of the bar
        
       // bars for consumed amounts:
        fill(255, 77, 109); // red
        noStroke();
       //To get different examples displayed, I have given different intake values for each patient with examples of higher and lower consumption than recommendatio
       
        if ( randomNumberForPatients==6 || randomNumberForPatients==9 ||randomNumberForPatients==11){
              rect(891,632,proteins+50,10);
            
              consumedProtein = proteins+50;
              text ((nf(consumedProtein,0,2))+" gm",consumedProtein+920 ,647);
         
        }
          if (randomNumberForPatients== 4){
              rect(891,632,proteins+50,10);
            
              consumedProtein = proteins+50;
              text ((nf(consumedProtein,0,2))+" gm",consumedProtein+925 ,647);
         
        }
         if (randomNumberForPatients== 1 || randomNumberForPatients==2 || randomNumberForPatients==3 ||randomNumberForPatients==12||randomNumberForPatients==10){
              rect(891,632,proteins-50,10);
          
              consumedProtein = proteins-50;
              text ((nf(consumedProtein,0,2))+" gm",consumedProtein+950 ,647);
    
        }
        
          if (randomNumberForPatients== 5 || randomNumberForPatients==7 || randomNumberForPatients==8){
              rect(891,632,proteins*0.8,10);
              
              consumedProtein = proteins*0.8;
              text ((nf(consumedProtein,0,2))+" gm",consumedProtein+920 ,647);
    
        }
        
           if ( randomNumberForPatients==6 || randomNumberForPatients==9){
               rect(891,662,carbs*1.4,10);
         
               consumedCarbs = carbs*1.4;
               text ((nf(consumedCarbs,0,2))+" gm",consumedCarbs+920 ,677);
    
        }
           
           if (randomNumberForPatients== 4 ){
                rect(891,662,carbs*1.4,10);
                
                consumedCarbs = carbs*1.4;
                text ((nf(consumedCarbs,0,2))+" gm",consumedCarbs+925 ,677);
    
        }
         
            if ( randomNumberForPatients==12){
               rect(891,662,carbs*1.1,10);
               
               consumedCarbs = carbs*1.1;
               text ((nf(consumedCarbs,0,2))+" gm",consumedCarbs+830 ,692);
    
        }
      
           if (randomNumberForPatients==1||randomNumberForPatients==5){
               rect(891,662,carbs*0.8,10);
               
               consumedCarbs = carbs*0.8;
               text ((nf(consumedCarbs,0,2))+" gm",consumedCarbs+970 ,677);
    
        }
        
          if ( randomNumberForPatients==11){
                 rect(891,662,carbs*0.8,10);
                 
                 consumedCarbs = carbs*0.8;
                 text ((nf(consumedCarbs,0,2))+" gm",consumedCarbs+1020 ,677);
        }
        
       
            if ( randomNumberForPatients==2||randomNumberForPatients==7||randomNumberForPatients==8){
               rect(891,662,carbs*1.1,10);
               
                consumedCarbs = carbs*1.1;
                text ((nf(consumedCarbs,0,2))+" gm",consumedCarbs+920 ,677);
    
        }
            if ( randomNumberForPatients==3){
               rect(891,662,carbs*1.1,10);

                consumedCarbs = carbs*1.1;
                text ((nf(consumedCarbs,0,2))+" gm",consumedCarbs+910 ,677);
    
        }
            if ( randomNumberForPatients==10){
                 rect(891,662,carbs*1.1,10);
                 
                  consumedCarbs = carbs*1.1;
                  text ((nf(consumedCarbs,0,2))+" gm",consumedCarbs+915 ,677);
    
        }
         
             if ( randomNumberForPatients==9){
                 rect(891,692,fats*1.5,10);
                 
                 consumedFats = fats*1.5;
                 text ((nf(consumedFats,0,2))+" gm",consumedFats+920 ,707);
    
        }
              if ( randomNumberForPatients==11){
                 rect(891,692,fats*1.5,10);
                 
                 consumedFats = fats*1.5;
                 text ((nf(consumedFats,0,2))+" gm",consumedFats+910 ,707);
    
        }
              if ( randomNumberForPatients==12){
                   rect(891,692,fats*1.5,10);
                   
                   consumedFats = fats*1.5;
                   text ((nf(consumedFats,0,2))+" gm",consumedFats+910 ,702);
    
        }
        
              if ( randomNumberForPatients==5||randomNumberForPatients==8||randomNumberForPatients==10){
                   rect(891,692,fats*0.7,10);
                   
                   consumedFats = fats*0.7;
                   text ((nf(consumedFats,0,2))+" gm",consumedFats+930 ,707);
                 
        }
              if ( randomNumberForPatients==3){
                   rect(891,692,fats*0.7,10);
                   
                   consumedFats = fats*0.7;
                   text ((nf(consumedFats,0,2))+" gm",consumedFats+925 ,709);
                 
        }
              if ( randomNumberForPatients==1){
                   rect(891,692,fats*0.7,10);
         
                   consumedFats = fats*0.7;
                   text ((nf(consumedFats,0,2))+" gm",consumedFats+945 ,706);       
        }
        
          
              if (randomNumberForPatients==6||randomNumberForPatients==7){
                   rect(891,692,fats*1.3,10);
         
                   consumedFats = fats*1.3;
                   text ((nf(consumedFats,0,2))+" gm",consumedFats+920 ,707);
         
    
        }
             if (randomNumberForPatients==4){
                 rect(891,692,fats*1.3,10);
                 consumedFats = fats*1.3;
              
                 text ((nf(consumedFats,0,2))+" gm",consumedFats+925 ,707);

        }
             if (  randomNumberForPatients==2){
               rect(891,692,fats*1.3,10);
               consumedFats = fats*1.3;
              
               text ((nf(consumedFats,0,2))+" gm",consumedFats+910 ,707);

        }
        
 // Self-reported intake of mineral, vitmain tablets and water      
      fill (255);
      text("Mineral intake:  ",750,790);
      
          if (minerals <7){  // if intake is below recommendation, the number is red       
               fill (255, 77, 109);// light red
          }
          
      text(minerals,900,790);
      fill(255);
      text("tablets/week",922,790);
    
      text("Vitamin intake:  ",750,820);
              if (vitamins <7){
           fill (255, 77, 109);// light red
          }
          
      text(vitamins,900,820);
      fill(255);
      text("tablets/week",922,820);
      text("Water intake:    ",750,850);
         if (water=="10"  || water=="  9" ){           // less than 1.5l/daily recommendation - ref.:https://madeblue.org/en/how-much-water-should-you-drink-per-day/
                    fill (255, 77, 109);              // light red
          }
      text(water,890,850);
      fill (255);
      text("l/week",922,850);

       
      }
      
      
      
      // additional, patient specific conditions:
      // Patient 1 - known conditions check marks
          if  (randomNumberForPatients == 1 ){
           image(img2,width/2+240, 155);
           image(img2,width/2+600, 185);
       }
       // Patient 2 and 5 - high gravity as water intake was low during the week
       // gravity -ref.://https://www.medicalnewstoday.com/articles/322125#:~:text=High%20specific%20gravity%20suggests%20that,dehydration  High value suggests dehydration.Recommended daily water intake is min.1.5 l, 10.5l/week.
       //These two patients had less.
       if  (randomNumberForPatients == 2  || randomNumberForPatients == 5 ){
             fill(255);
             noStroke();
             rect(300,575,100,20); // rectangle to cover default text
             fill (201, 24, 74); //text is red, as it is high
             text("High", 300, 590); 
             textSize(40);// patient data  in black box
                            fill(239,188,27); // yellow
                             text("Dehydration risk!",1300,350);
                            textSize(18);
                       
       }
       if (randomNumberForPatients == 7 ){
       image(img2,width/2-10, 155); // pregnant patient
       fill(255);
       noStroke();
       rect(300,635,100,20); // box covers default text
       stroke(1);
       fill(0);
       text("160,000 IU/L", 300, 650); //hCG
       fill(239,180,27); //warning in black box (yellow)
       textSize(40);
       text("Pregnancy!", 1350, 440); //warning in black box
       textSize(18);
       
       }
       
       // various conditions marked at the top 
          if (randomNumberForPatients == 12 ){
            image(img2,width/2-10, 215); 
       }
         if  (randomNumberForPatients == 8 ){
         image(img2,width/2+240, 215);
       }
      
           if  (randomNumberForPatients == 11 ){
           image(img2,width/2+600, 155);
       }
            if  (randomNumberForPatients == 4 ){
           image(img2,width/2+600, 215);
       }
  
  // video call         
       if (callSound){  // video call sound plays when calling patient
         calling.playFor(0.9);
       } 
       
            if (call){   // videocall window
                   scale(0.125);
                   image(img1,225*8,428*8);
                   println(mouseX,mouseY);
                   scale(8);
                   image(img4,98,288 ); 
                   fill(255);
                   textSize(24);
                   text("Calling "+name,200,400);
                   callSound = true;
                   
             } else {
               callSound = false; 
             }
   
}
void mousePressed(){ 
   
  if (mouseX>x1 && mouseX <x1+w1 && mouseY>y1 && mouseY <y1+h1){  // this is a function to enabled viewing the next patient when pressing the button "Next"
    randomNumberForPatients+=1;
           if (randomNumberForPatients == 13){   // when we get to the last image, it starts over from the first one
            randomNumberForPatients= 1;
            }
            redraw();
            call=false;
  }
    if (mouseX>x && mouseX <x+w && mouseY>y && mouseY <y+h){  // this is a function to enabled viewing the next patient when pressing the button "Back"
    randomNumberForPatients-=1;
           if (randomNumberForPatients == 0){   // when we get to the first image, it starts over from the last one
            randomNumberForPatients= 12;
            }
            redraw();
            call=false;
    }
     if (mouseX>100 && mouseX <130 && mouseY>225 && mouseY< 255){  // start video call
       call = true;
  
       
     }
    if (mouseX>252 && mouseX <388 && mouseY>640 && mouseY< 681){   // end call
       call = false;
     }


   
  
}

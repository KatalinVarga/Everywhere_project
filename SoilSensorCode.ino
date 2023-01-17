 
int Sensor= 0; // Soil Sensor input at Analog PIN A0
int value= 0;

void setup() {
   Serial.begin(9600);

   delay(2000);
}

void loop() {
   Serial.print("");
   value= analogRead(Sensor);

   Serial.println(value);

    
delay(50);

}

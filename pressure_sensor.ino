/******************************************/
const int analogPin = A0;//the analog input pin attach to
 
int inputValue = 0;//variable to store the value coming from sensor
int outputValue = 0;//variable to store the output value

bool wasDown = false;
/******************************************/
void setup()
{
  Serial.begin(9600);
}
/******************************************/
void loop()
{
  inputValue = analogRead(analogPin);//read the value from the sensor
  // print it out in many formats:
  if (inputValue > 500 && !wasDown) {
    wasDown = true;
    Serial.println(analogPin);
  } else if (inputValue <= 500) {
    wasDown = false;
  }
  
//  Serial.println(inputValue);       // print as an ASCII-encoded decimal

  // delay 10 milliseconds before the next reading:
  delay(10);
 // outputValue = map(inputValue,0,1023,0,255);//Convert from 0-1023 proportional to the number of a number of from 0 to 255
  
}
/*******************************************/

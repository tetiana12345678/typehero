/******************************************/
const int analogPin = A0;//index finger
const int analogPin1 = A1; // middle finger

int inputValue = 0;//value coming from sensor A0, index finger
int inputValue1 = 0; //value from sensor A1, middle finger

bool wasDown = false;
bool wasDown1 = false;
/******************************************/
void setup()
{
  Serial.begin(9600);
}
/******************************************/
void loop()
{
  inputValue = analogRead(analogPin);//read the value from the sensor

  if (inputValue > 900 && !wasDown) {
    wasDown = true;
    Serial.println("Index finger");
  } else if (inputValue <= 900) {
    wasDown = false;
  }

   inputValue1 = analogRead(analogPin1);

   if (inputValue1 > 100 && !wasDown1) {
    wasDown1 = true;
    Serial.println("Fuck finger");
  } else if (inputValue1 <= 100) {
    wasDown1 = false;
  }

  //Serial.println(inputValue1);       // print as an ASCII-encoded decimal


}
/*******************************************/

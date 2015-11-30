/******************************************/
const int analogPin = A0;//index finger
const int analogPin1 = A1; // middle finger

int inputValue = 0;//variable to store the value coming from sensor A0
int inputValue1 = 0; //variable to store value from sensor A1

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

  if (inputValue > 100 && !wasDown) {
    wasDown = true;
    Serial.println("1"); //Index finger
  } else if (inputValue <= 100) {
    wasDown = false;
  }

  inputValue1 = analogRead(analogPin1);

  if (inputValue1 > 900 && !wasDown1) {
    wasDown1 = true;
    Serial.println("2"); //Middle finger
  } else if (inputValue1 <= 900) {
    wasDown1 = false;
  }

  //Serial.println(inputValue1);
  //Serial.println(inputValue);

  // delay(10);

}
/*******************************************/

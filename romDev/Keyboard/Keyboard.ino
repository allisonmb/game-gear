/* Arduino USB HID Keyboard Demo
 * Random Key/Random Delay
 */


#define D2 2
#define D3 3
#define D4 4
#define D5 5
#define D6 6
#define D7 7

bool press;

uint8_t buf[8] = { 
  0 }; 	/* Keyboard report buffer */

void setup() 
{
  pinMode(D2, INPUT);
  pinMode(D3, INPUT);
  pinMode(D4, INPUT);
  pinMode(D5, INPUT);
  pinMode(D6, INPUT);
  pinMode(D7, INPUT);
  Serial.begin(9600);
  randomSeed(analogRead(0));
  delay(200);
}

void loop() 
{
  press = false;
  if (digitalRead(D2) == HIGH) {
    buf[2] = 4; //A
    //Serial.write(buf, 8);
    press = true;
  }
  else {
    buf[2] = 0;
  }
  if (digitalRead(D3) == HIGH) {
    buf[3] = 82; //Up
    //Serial.write(buf, 8);
    press = true;
  }
  else {
    buf[3] = 0;
  }
  if (digitalRead(D4) == HIGH) {
    buf[4] = 80; //Left
    //Serial.write(buf, 8);
    press = true;
  }
  else {
    buf[4] = 0;
  }
  if (digitalRead(D5) == HIGH) {
    buf[5] = 81; //Down
    //Serial.write(buf, 8);
    press = true;
  }
  else {
    buf[5] = 0;
  }
  if (digitalRead(D6) == HIGH) {
    buf[6] = 79; //Right
    //Serial.write(buf, 8);
    press = true;
  }
  else {
    buf[6] = 0;
  }
  if (digitalRead(D7) == HIGH) {
    buf[7] = 22; //S
    //Serial.write(buf, 8);
    press = true;
  }
  else {
    buf[7] = 0;
  }

  Serial.write(buf, 8);
  
}

void releaseKey() 
{
  buf[0] = 0;
  buf[2] = 0;
  Serial.write(buf, 8);	// Release key  
}
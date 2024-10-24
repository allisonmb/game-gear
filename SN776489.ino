//pin numbers
#define D0 12
#define D1 11
#define D2 2
#define D3 3
#define D4 4
#define D5 5
#define D6 6
#define D7 7
#define CE 8
#define WE 9
#define READY 10
#define DEBUGBTN 13

//data bitmasks
#define LATCH 0b10000000
#define CHANNELSEL 0b01100000
#define TYPE 0b00010000
#define DATA 0b00001111
#define HIGHDATA 0b00111111
#define NOISEDATA 0b111
#define SHIFTSPEED 0b11
#define NOISETYPE 0b100

//define locations
#define HIGHBYTESHIFT 4
#define CHANNELTYPESHIFT 4
#define NOISETYPESHIFT 2
#define TAP0 0
#define TAP3 3

//channel/type bitmasks
#define TONE0FREQ 0b000
#define TONE0ATT 0b001
#define TONE1FREQ 0b010
#define TONE1ATT 0b011
#define TONE2FREQ 0b100
#define TONE2ATT 0b101
#define NOISECTRL 0b110
#define NOISEATT 0b111

//LFSR inputs
#define INPUT0 0b0111111111111111
#define INPUT1 0b1000000000000000

//setup volume table
const int volume_table[16] = {
  32767, 26028, 20675, 16422, 13045, 10362,  8231,  6568,
  5193,  4125,  3277,  2603,  2067,  1642,  1304,     0
 };

void readData();
void printRegs();

//temporary bool READY for internal use. This would not be needed if communicating with a real processor
bool readyState = true;

//setup variable to remember latched register. -1 will represent no latched register
int8_t latchedReg = -1;

//initialize tone frequency registers
uint16_t tone0Freq = 1;
uint16_t tone1Freq = 1;
uint16_t tone2Freq = 1;

//initialize tone Attenuation registers
uint8_t tone0Att = 0b1111;
uint8_t tone1Att = 0b1111;
uint8_t tone2Att = 0b1111;

//initialize noise registers
uint8_t noiseControl = 0;
uint8_t noiseAtt = 0b1111;

//initialize noise generator register
uint16_t LFSR = 1 << 15;

//setup channel counters
int16_t channel0Cnt = 1;
int16_t channel1Cnt = 1;
int16_t channel2Cnt = 1;
int16_t channel3Cnt = 1;

//setup channel output
bool channel0Out = 0;
bool channel1Out = 0;
bool channel2Out = 0;
bool channel3Clk = 0;
bool channel3Out = 0;
unsigned int audioOut = 0;

//setup service channel
void serviceToneChannels();
void serviceNoiseChannel();

//setup channel mixer
void mixOutput();

void loop() {

  if (digitalRead(CE) == HIGH && digitalRead(WE) == HIGH && readyState) {
    //Serial.println("readData Called");
    readData();
    readyState = false;
    digitalWrite(READY, LOW);
    
  }
  
  if (digitalRead(CE) == LOW) {
    readyState = true;
    digitalWrite(READY, HIGH);
  }

  if (digitalRead(DEBUGBTN) == HIGH) {
    printRegs();
    while(digitalRead(DEBUGBTN) == HIGH);
  }

  serviceToneChannels();
  serviceNoiseChannel();
  mixOutput();

  delay(1);
}

void readData() {
  //Serial.println("readData Called");
  //set data to bits from most significant to least significant
  uint8_t recvData = (digitalRead(D0) == LOW) << 7
                | (digitalRead(D1) == LOW) << 6
                | (digitalRead(D2) == LOW) << 5
                | (digitalRead(D3) == LOW) << 4
                | (digitalRead(D4) == LOW) << 3
                | (digitalRead(D5) == LOW) << 2
                | (digitalRead(D6) == LOW) << 1
                | (digitalRead(D7) == LOW);
  //Serial.println(recvData);

  if (recvData & LATCH) {
    latchedReg = (recvData & (CHANNELSEL | TYPE)) >> CHANNELTYPESHIFT;
    switch(latchedReg) {
      case TONE0ATT:
        tone0Att = recvData & DATA;
        break;
      case TONE1ATT:
        tone1Att = recvData & DATA;
        break;
      case TONE2ATT:
        tone2Att = recvData & DATA;
        break;
      case TONE0FREQ:
        tone0Freq = recvData & DATA;
        break;
      case TONE1FREQ:
        tone1Freq = recvData & DATA;
        break;
      case TONE2FREQ:
        tone2Freq = recvData & DATA;
        break;
      case NOISECTRL:
        noiseControl = recvData & NOISEDATA;
        break;
      case NOISEATT:
        noiseAtt = recvData & DATA;
    }
  }
  //put data in correct latch register
  else {
    switch(latchedReg) {
      case TONE0ATT:
        tone0Att = recvData & DATA;
        break;
      case TONE1ATT:
        tone1Att = recvData & DATA;
        break;
      case TONE2ATT:
        tone2Att = recvData & DATA;
        break;
      case TONE0FREQ:
        tone0Freq = ((recvData & HIGHDATA) << HIGHBYTESHIFT) | (tone0Freq & DATA);
        break;
      case TONE1FREQ:
        tone1Freq = ((recvData & HIGHDATA) << HIGHBYTESHIFT) | (tone1Freq & DATA);
        break;
      case TONE2FREQ:
        tone2Freq = ((recvData & HIGHDATA) << HIGHBYTESHIFT) | (tone2Freq & DATA);
        break;
      case NOISECTRL:
        noiseControl = recvData & NOISEDATA;
        break;
      case NOISEATT:
        noiseAtt = recvData & DATA;
    }
    //unlatch the register
    latchedReg = -1;
  }

}

void printRegs() {
  Serial.println();
  Serial.println("Registers");
  Serial.println("--------------------------------------------");

  Serial.print("latchedReg: ");
  Serial.println(latchedReg, BIN);

  Serial.print("tone0Freq: ");
  Serial.println(tone0Freq, BIN);
  Serial.print("tone1Freq: ");
  Serial.println(tone1Freq, BIN);
  Serial.print("tone2Freq: ");
  Serial.println(tone2Freq, BIN);
  Serial.print("tone0Att: ");
  Serial.println(tone0Att, BIN);
  Serial.print("tone1Att: ");
  Serial.println(tone1Att, BIN);
  Serial.print("tone2Att: ");
  Serial.println(tone2Att, BIN);

  Serial.print("noiseControl: ");
  Serial.println(noiseControl, BIN);
  Serial.print("noiseAtt: ");
  Serial.println(noiseAtt, BIN);

  
}

void serviceToneChannels() {
  // Serial.print("channel0Cnt: ");
  // Serial.println(channel0Cnt);
  // Serial.print("Channel0Out: ");
  // Serial.println(channel0Out);
  channel0Cnt--;
  channel1Cnt--;
  channel2Cnt--;
  if (channel0Cnt <= 0) {
    channel0Cnt = tone0Freq;
    channel0Out = !channel0Out;
  }
  if (channel1Cnt <= 0) {
    channel1Cnt = tone1Freq;
    channel1Out = !channel1Out;
  }
  if (channel2Cnt <= 0) {
    channel2Cnt = tone2Freq;
    channel2Out = !channel2Out;
  }
  
}

void serviceNoiseChannel() {
  //update counter according to shift speed
  channel3Cnt--;
  // Serial.print("LFSR: ");
  // Serial.println(LFSR, BIN);
  // Serial.print("channel3Cnt: ");
  // Serial.println(channel3Cnt);
  // Serial.print("channel3Clk: ");
  // Serial.println(channel3Clk);
  if (channel3Cnt <= 0) {
    channel3Clk = !channel3Clk;
    // Serial.print("channel3Clk: ");
    // Serial.println(channel3Clk);
    switch(noiseControl & SHIFTSPEED) {
      case 0:
        channel3Cnt = 0x10;
        break;
      case 1:
        channel3Cnt = 0x20;
        break;
      case 2:
        channel3Cnt = 0x40;
        break;
      case 3:
        channel3Cnt = tone2Freq;
        break;
    }
    //if going from a 0 to a 1
    if (channel3Clk) {
      bool temp = 0;
      //if white noise XOR bits 0 and 3, otherwise use bit 0
      if ((noiseControl >> NOISETYPESHIFT) & 1)
        temp = ((LFSR >> TAP0) & 1) ^ ((LFSR >> TAP3) & 1);
      else
        temp = LFSR & 1;
      //shift when out changes from 0 to 1
      LFSR = LFSR >> 1;
      //set input bit to temp
      if (temp)
        LFSR |= INPUT1;
      else
        LFSR &= INPUT0;
      channel3Out = temp;
    }
  }
}

void mixOutput() {
  audioOut = channel0Out * volume_table[tone0Att]
          + channel1Out * volume_table[tone1Att]
          + channel2Out * volume_table[tone2Att]
          + channel3Out * volume_table[noiseAtt];
  //Serial.print("audioOut: ");
  Serial.println(audioOut);
}

void setup() {

  //setup pins
  pinMode(D0, INPUT);
  pinMode(D1, INPUT);
  pinMode(D2, INPUT);
  pinMode(D3, INPUT);
  pinMode(D4, INPUT);
  pinMode(D5, INPUT);
  pinMode(D6, INPUT);
  pinMode(D7, INPUT);
  pinMode(CE, INPUT);
  pinMode(WE, INPUT);
  pinMode(READY, OUTPUT);
  pinMode(DEBUGBTN, INPUT);

  //start serial
  Serial.begin(9600);
  delay(1000);
}

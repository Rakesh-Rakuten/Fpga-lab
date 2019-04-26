void setup(){
  //set digital pins 0-7 as outputs
  for (int i=2;i<11;i++){
    pinMode(i,INPUT);
  }
  Serial.begin(9600);
}
int i=0;
void loop(){
  //int a[8]={320,272,352,120,200,240,272 ,128};
int F1 = 40;
int F2 = 140; // Sine wave frequency (hertz)
int data[8];
  for (int k=1;k<9;k++)
  {
    data[k-1] =300+16*(sin(2*3.1416*F1*k/300)+ sin(2*3.1416*F2*k/300));
  }
int no;
int z0 = digitalRead(2);
int z1 = digitalRead(3);
int z2 = digitalRead(4);
int z3 = digitalRead(5);
int z4 = digitalRead(6);
int z5 = digitalRead(7);
int z6 = digitalRead(8);
int z7 = digitalRead(9);
int z8 = digitalRead(10);
if (z8==1)
{no = (z8<<8)+(z7<<7)+(z6<<6)+(z5<<5)+(z4<<4)+(z3<<3)+(z2<<2)+(z1<<1)+z0;
  no=-(512-no);
  }
  else{
 no = (z8<<8)+(z7<<7)+(z6<<6)+(z5<<5)+(z4<<4)+(z3<<3)+(z2<<2)+(z1<<1)+z0;
  }
Serial.print(int(no));
Serial.print(" ");
Serial.println(data[i]);
i=i+1;
if(i==8)
{
 i=0;
 }
delay(1000);
}

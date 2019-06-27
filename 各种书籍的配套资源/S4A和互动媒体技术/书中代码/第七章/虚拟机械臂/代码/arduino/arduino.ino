//发送模拟传感器的信息
int INPUT_1=0;
int INPUT_2=1;
void setup()
{
  Serial.begin(9600);
}

void loop()
{
  int a=analogRead( INPUT_1)/8;
  Serial.write(a);
  int b=analogRead( INPUT_2)/8;
  Serial.write(b+127);
  delay( 100 );
}

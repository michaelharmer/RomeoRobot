#define NUM_COMMANDS 500

int E1 = 5;	//M1 Speed Control
int E2 = 6;	//M2 Speed Control
int M1 = 4;	//M1 Direction Control
int M2 = 7;	//M1 Direction Control

int x=1;
int y=0;

int ledPin = 13;
int key_s7 = 3;

char commands[NUM_COMMANDS];
int command_counter = 0;
int total_commands = 0;
int record_mode = 1;

void stop(void)	//Stop
{
digitalWrite(E1,LOW);
digitalWrite(E2,LOW);
}
void turn_right(char a,char b)	
{
analogWrite (E1,a);	//PWM Speed Control
digitalWrite(M1,HIGH);
analogWrite (E2,b);
digitalWrite(M2,HIGH);
}
void turn_left (char a,char b)	
{
analogWrite (E1,a);
digitalWrite(M1,LOW);
analogWrite (E2,b);
digitalWrite(M2,LOW);
}
void backward (char a,char b)	
{
analogWrite (E1,a);
digitalWrite(M1,LOW);
analogWrite (E2,b);
digitalWrite(M2,HIGH);
}
void forward (char a,char b)	
{
analogWrite (E1,a);
digitalWrite(M1,HIGH);
analogWrite (E2,b);
digitalWrite(M2,LOW);
}
void setup(void)
{
pinMode(ledPin, OUTPUT);
  pinMode(key_s7, INPUT);  
int i;
for(i=4;i<=7;i++)
  pinMode(i, OUTPUT);
}
void loop(void)
{
  int val;
  int button = 0;
  
  
  while(1)
  {
    if (digitalRead(key_s7) == LOW)
    {
      if (record_mode)
        total_commands = command_counter;
      record_mode = 0;
      for (int i = 0; i <= total_commands; i++)
      {
        switch(commands[i])
        {
          case 'f':
             forward(130,130);
             delay(60);
            break;
          case 'b':
            backward(130,130);
            delay(60);
            break;
          case 'l':
            turn_left(150,150);
            delay(40);
            break;
          case 'r':
            turn_right(150,150);
            delay(40);
            break;
        }
        
      }
      stop();
      
    }
    
    if (record_mode && command_counter < NUM_COMMANDS)
    {
    if (digitalRead(key_s7))
      val=analogRead(x); //Read Analog input
    if(val>1000)
      commands[command_counter++] = 'f';
    else if (val<20)
      commands[command_counter++] = 'b';
    else {
      val = analogRead(y);
      if (val > 1000)
        commands[command_counter++] = 'l';
      else if (val < 20)
        commands[command_counter++] = 'r';
    }  
      
    delay(40);
    }
  }
}

//Variables

int sample[24] = { 24, 32, 27, -15, 0, 10, 7, 24, 25, 25, 27, 32, 28, 37, 15, 24, 17, 12, 25, 21, 22, 24, 32, -3000000};
int hourlyTemperature[24];

int SelectMenu;

unsigned count;

int Current;

// Constants for calculating temperature and humidity
const unsigned int C1 = 400;             // -4
const unsigned int C2 = 405;             // 0.0405  (405 * 10^-4)
const unsigned short C3 = 28;            // -2.8 * 10^-6  (28 * 10^-7)
const unsigned int D1 = 4000;            // -40
const unsigned short D2 = 1;             // 0.01

unsigned short i2, j2;
long int temp, k, SOt, SOrh, Ta_res, Rh_res;
char Ta[16] = "Ta = 000.00    ";
char Rh[16] = "Rh = 000.00    ";

//

// Glcd module connections
char GLCD_DataPort at PORTD;

sbit GLCD_CS1 at RB0_bit;
sbit GLCD_CS2 at RB1_bit;
sbit GLCD_RS  at RB2_bit;
sbit GLCD_RW  at RB3_bit;
sbit GLCD_EN  at RB4_bit;
sbit GLCD_RST at RB5_bit;

sbit GLCD_CS1_Direction at TRISB0_bit;
sbit GLCD_CS2_Direction at TRISB1_bit;
sbit GLCD_RS_Direction  at TRISB2_bit;
sbit GLCD_RW_Direction  at TRISB3_bit;
sbit GLCD_EN_Direction  at TRISB4_bit;
sbit GLCD_RST_Direction at TRISB5_bit;
// End Glcd module connections

//SHT11 connections
sbit SDA at RC4_bit;                     // Serial data pin
sbit SCL at RC3_bit;                     // Serial clock pin

sbit SDA_Direction at TRISC4_bit;        // Serial data direction pin
sbit SCL_Direction at TRISC3_bit;        // Serial clock direction pin

#define KP_R0  PORTA.B0
#define KP_R1 PORTA.B1
#define KP_R2 PORTA.B2
#define KP_R3 PORTA.B3
#define KP_R4 PORTA.B4
#define KP_R5 PORTA.B5

//SHT1X

void SHT_Reset() {
  SCL = 0;                               // SCL low
  SDA_Direction = 1;                     // define SDA as input
  for (i2 = 1; i2 <= 18; i2++)              // repeat 18 times
    SCL = ~SCL;                          // invert SCL
}

void Transmission_Start() {
  SDA_Direction = 1;                     // define SDA as input
  SCL = 1;                               // SCL high
  Delay_1us();                           // 1us delay
  SDA_Direction = 0;                     // define SDA as output
  SDA = 0;                               // SDA low
  Delay_1us();                           // 1us delay
  SCL = 0;                               // SCL low
  Delay_1us();                           // 1us delay
  SCL = 1;                               // SCL high
  Delay_1us();                           // 1us delay
  SDA_Direction = 1;                     // define SDA as input
  Delay_1us();                           // 1us delay
  SCL = 0;                               // SCL low
}

// MCU ACK
void MCU_ACK() {
  SDA_Direction = 0;     // define SDA as output
  SDA = 0;               // SDA low
  SCL = 1;               // SCL high
  Delay_1us();           // 1us delay
  SCL = 0;               // SCL low
  Delay_1us();           // 1us delay
  SDA_Direction = 1;     // define SDA as input
}

// This function returns temperature or humidity, depends on command
long int Measure(short num) {
  int temperature;
  
  j2 = num;                           // j2 = command (0x03 or 0x05)
  SHT_Reset();                       // procedure for reseting SHT11
  Transmission_Start();              // procedure for starting transmission
  k = 0;                             // k = 0
  SDA_Direction = 0;                 // define SDA as output
  SCL = 0;                           // SCL low
  for(i2 = 1; i2 <= 8; i2++) {          // repeat 8 times
    if (j2.F7 == 1)                   // if bit 7 = 1
     SDA_Direction = 1;              // define SDA as input
    else {                           // else (if bit 7 = 0)
     SDA_Direction = 0;              // define SDA as output
     SDA = 0;                        // SDA low
   }
    Delay_1us();                     // 1us delay
    SCL = 1;                         // SCL high
    Delay_1us();                     // 1us delay
    SCL = 0;                         // SCL low
    j2 <<= 1;                         // move contents of j2 one place left
  }

  SDA_Direction = 1;                 // define SDA as input
  SCL = 1;                           // SCL high
  Delay_1us();                       // 1us delay
  SCL = 0;                           // SCL low
  Delay_1us();                       // 1us delay
  while (SDA == 1)                   // while SDA is high, do nothing
    Delay_1us();                     // 1us delay

  for (i2 = 1; i2 <=16; i2++) {         // repeat 16 times
    k <<= 1;                         // move contents of k one place left
    SCL = 1;                         // SCL high
    if (SDA == 1)                    // if SDA is high
    k = k | 0x0001;
    SCL = 0;
    if (i2 == 8)                      // if counter i2 = 8 then
      MCU_ACK();                     // MCU acknowledge
  }
  
  SOt = k;
  
   if(SOt > D1)                     // if temperature is positive
      Ta_res = SOt * D2 - D1;        // calculate temperature
    else                             // else (if temperature is negative)
      Ta_res = D1 - SOt * D2;        // calculate temperature
      
  temperature = (int) floor( Ta_res );
  
  return temperature/100;
  
}

void interrupt()
{
 
 count++;
 TMR0 = 0;
 INTCON = 0XA0;

}

//

void Render_C(int x, int y, int colour)
{
 int i = 0;

 for(i = 0; i<5; i++)
       Glcd_Dot( x, y+i, colour);

 Glcd_Dot( x+1, y, colour);
 Glcd_Dot( x+2, y, colour);

 Glcd_Dot( x+1, y+4, colour);
 Glcd_Dot( x+2, y+4, colour);

}

void Render_Minus(int x, int y, int colour)
{

 Glcd_Dot( x, y, colour);
 Glcd_Dot( x+1, y, colour);
 Glcd_Dot( x+2, y, colour);

}

void Number(int num, int x, int y, int colour)
{
 int i = 0;
 
 if( num == 0)
 {
      for(i = 0; i < 3; i++)
 {
  Glcd_Dot( x + i, y, colour);

  Glcd_Dot( x + i, y + 4, colour);
 }

 for(i = 1; i < 4; i++)
 {
  Glcd_Dot( x, y + i, colour);

  Glcd_Dot( x + 2, y + i, colour);

 }
 }
 else if( num == 1)
 {

 Glcd_Dot( x, y+1, colour);

 Glcd_Dot( x+1, y, colour);

 for( i = 0; i < 5; i++)
      Glcd_Dot( x+2, y+i, colour);

 
 }
 else if( num == 2)
 {
     for( i = 0; i < 3; i++)
      Glcd_Dot( x+i, y, colour);

 for( i = 0; i < 3; i++)
      Glcd_Dot( x+2-i, y+1+i, colour);

 for( i = 0; i < 3; i++)
      Glcd_Dot( x+i, y+4, colour);
 
 }
 else if( num == 3)
 {

 for(i = 0; i < 5; i++)
       Glcd_Dot( x+2, y+i, colour);

 for(i = 0; i<2; i++)
 {
       Glcd_Dot( x+i, y, colour);

       Glcd_Dot( x+i, y+2, colour);

       Glcd_Dot( x+i, y+4, colour);

 }
 
 }
 else if( num == 4)
 {
 
 for(i = 0; i < 2; i++)
 {
  Glcd_Dot( x, y+i, colour);

  Glcd_Dot( x+2, y+1+i, colour);

  Glcd_Dot( x+i, y+2, colour);


 }

 Glcd_Dot( x+2, y+3, colour);

 Glcd_Dot( x+2, y+4, colour);
 
 }
 else if( num == 5)
 {
     for(i = 0; i < 3; i++)
 {
  Glcd_Dot( x+i, y, colour);

  Glcd_Dot( x+i, y+4, colour);

  Glcd_Dot( x+i, y+2, colour);

 }

 Glcd_Dot( x, y+1, colour);

 Glcd_Dot( x+2, y+3, colour);
 
 }
 else if( num == 6)
 {
    for(i = 0; i < 5; i++)
       Glcd_Dot( x, y+i, colour);

 for(i = 0; i < 3; i++)
       Glcd_Dot( x+2, y+2+i, colour);

 Glcd_Dot( x+1, y+2, colour);

 Glcd_Dot( x+1, y+4, colour);
 
 }
 else if( num == 7)
 {
     Glcd_Dot( x, y, colour);

 Glcd_Dot( x+1, y, colour);

 for(i = 0; i < 5; i++)
  Glcd_Dot( x+2, y+i, colour);
 
 }
 else if( num == 8)
 {
    for(i = 0; i<3; i++)
 {
  Glcd_Dot( x+i, y, colour);

  Glcd_Dot( x+i, y+2, colour);

  Glcd_Dot( x+i, y+4, colour);

 }

 Glcd_Dot( x, y+1, colour);
 Glcd_Dot( x, y+3, colour);

 Glcd_Dot( x+2, y+1, colour);
 Glcd_Dot( x+2, y+3, colour);
 
 }
 else if( num == 9)
 {

 for(i = 0; i < 3; i++)
 {
  Glcd_Dot( x+i, y, colour);

  Glcd_Dot( x+i, y+2, colour);

 }

 Glcd_Dot( x, y+1, colour);

 Glcd_Dot( x+2, y+1, colour);

 for( i = 0; i<2; i++)
      Glcd_Dot( x+2, y+3+i, colour);
 
 }
 
}

int reverse( int number)
{

 int sum = 0;

 while(number != 0)
 {
  sum *= 10;

  sum += number%10;

  number = number/10;

 }

 return sum;

}

void PrintNumber( int x, int y, int number, int colour)
{
 if(number > 9)
 {
  Number( number % 10, x-3, y, colour);

  number /= 10;

  Number( Number % 10, x+1, y, colour);

 }
 else
 {

  Number( number % 10, x, y, colour);

 }

}

void PrintHours( int start, int end, int colour)
{
 int i = 0;

 int origin = 0;

 int move = 11;

 int num = 0;

 for( i = start; i<=end; i++)
 {

  if(i >= 10)
       num = reverse( i*10 + 1 );
  else
      num = reverse( i );

  PrintNumber( (int) (origin + move)/2 , 47, num, 2);

  origin = move + 2;

  move = origin + 11;


 }


}

int PrintTemperature( int start, int temperature)
{

 int num = reverse( abs( temperature ) * 10 + 1 );

 if( abs(temperature) <= 9)
     num = reverse( abs( temperature ) );

 if(temperature == 0)
 {

  PrintNumber( (int) ( (start + 2) + ( start + 2 + 11) )/2, 31 /* Check */, num, 2);

  Render_C( (int) ( (start + 2) + ( start + 2 + 11) ) / 2 + 1, 38, 2);

  return (start + 2 + 11);

 }

 //Test Block 200x200

 if( abs(temperature) < 15)
 {

  if(temperature > 0)
  {


   PrintNumber( (int) ( (start + 2) + ( start + 2 + 11) )/2, 44 - ( temperature + 1 + 11) , num, 2);

   Render_C( (int) ( (start + 2) + ( start + 2 + 11) ) / 2 + 1, 44 - ( temperature + 1 + 5), 2);

   return ( start + 2 + 11);

  }
  else
  {

   Render_Minus( (int) ( (start + 2) + ( start + 2 + 11) )/2 + 1, 44 + 7, 2);

   PrintNumber( (int) ( (start + 2) + ( start + 2 + 11) )/2, 44 + 9, num, 2);

   Render_C( (int) ( (start + 2) + ( start + 2 + 11) ) / 2 + 1, 44 + 15, 2);

   return ( start + 2 + 11);

  }

 }
 else
 {

  if(temperature > 0)
  {

   PrintNumber( (int) ( (start + 2) + ( start + 2 + 11) )/2, (int) (44 + (44 - temperature) ) / 2 - 5 , num, 2); //Check

   Render_C( (int) ( (start + 2) + ( start + 2 + 11) ) / 2 + 1, (int) (44 + (44 - temperature) ) / 2 + 1, 2);

   return ( start + 2 + 11);

  }
  else
  {


   PrintNumber( (int) ( (start + 2) + ( start + 2 + 11) )/2, 44 + 9, num, 2);

   Render_C( (int) ( (start + 2) + ( start + 2 + 11) ) / 2 + 1, 44 + 15, 2);

   return ( start + 2 + 11);

  }

 }



}

void initialize()
{
 KP_R0 = 0;
 KP_R1 = 0;
 KP_R2 = 0;
 KP_R3 = 0;
 KP_R4 = 0;
 KP_R5 = 0;

}

unsigned char Key()
{

 if(KP_R0 == 1)
  return 'U';
 else if(KP_R1 == 1)
  return 'L';
 else if(KP_R2 == 1)
  return 'R';
 else if(KP_R3 == 1)
  return 'D';
 else if(KP_R4 == 1)
  return 'O';
 else if(KP_R5 == 1)
  return 'C';
 else
  return '1';

}

unsigned char KeyClick()
{
 unsigned char Key = '1';

 initialize();

 while( (Key = Key()) == '1' );

 Delay_ms(100);

 return Key;

}

void Render_Block(int temperature, int index)
{

 if(temperature == -2000000)
 {
  return;

 }
 else if( temperature > 1)
 {

  switch(index)
  {
   case 1:
        Glcd_Box( 0, 44-temperature /* Height Inverse */, 11, 44 /* Bottom */, 1);
                  break;
   case 2:
        Glcd_Box( 13, 44-temperature /* Height Inverse */, 24, 44 /* Bottom */, 1);
                  break;
   case 3:
        Glcd_Box( 26, 44-temperature /* Height Inverse */, 37, 44 /* Bottom */, 1);
                  break;
   case 4:
        Glcd_Box( 39, 44-temperature /* Height Inverse */, 50, 44 /* Bottom */, 1);
                  break;
   case 5:
        Glcd_Box( 52, 44-temperature /* Height Inverse */, 63, 44 /* Bottom */, 1);
                  break;
   case 6:
        Glcd_Box( 65, 44-temperature /* Height Inverse */, 76, 44 /* Bottom */, 1);
                  break;
   case 7:
        Glcd_Box( 78, 44-temperature /* Height Inverse */, 89, 44 /* Bottom */, 1);
                  break;
   case 8:
        Glcd_Box( 91, 44-temperature /* Height Inverse */, 102, 44 /* Bottom */, 1);
                  break;
   case 9:
        Glcd_Box( 104, 44-temperature /* Height Inverse */, 115, 44 /* Bottom */, 1);
                  break;
   case 10:
        Glcd_Box( 117, 44-temperature /* Height Inverse */, 128, 44 /* Bottom */, 1);
                  break;

  }

 }
 else
 {
  switch(index)
  {
   case 1:
        Glcd_Box( 0, 44 /* Height Inverse */, 11, 44+abs(temperature) /* If Temp is > 1 Bottom */, 1);
                  break;
   case 2:
        Glcd_Box( 13, 44 /* Height Inverse */, 24, 44+abs(temperature) /* If Temp is > 1 Bottom */, 1);
                  break;
   case 3:
        Glcd_Box( 26, 44 /* Height Inverse */, 37, 44+abs(temperature) /* If Temp is > 1 Bottom */, 1);
                  break;
   case 4:
        Glcd_Box( 39, 44 /* Height Inverse */, 50, 44+abs(temperature) /* If Temp is > 1 Bottom */, 1);
                  break;
   case 5:
      Glcd_Box( 52, 44 /* Height Inverse */, 63, 44+abs(temperature) /* If Temp is > 1 Bottom */, 1);
                  break;
   case 6:
        Glcd_Box( 65, 44 /* Height Inverse */, 76, 44+abs(temperature) /* If Temp is > 1 Bottom */, 1);
                  break;
   case 7:
        Glcd_Box( 78, 44 /* Height Inverse */, 89, 44+abs(temperature) /* If Temp is > 1 Bottom */, 1);
                  break;
   case 8:
        Glcd_Box( 91, 44 /* Height Inverse */, 102, 44+abs(temperature) /* If Temp is > 1 Bottom */, 1);
                  break;
   case 9:
        Glcd_Box( 104, 44 /* Height Inverse */, 115, 44+abs(temperature) /* If Temp is > 1 Bottom */, 1);
                  break;
   case 10:
        Glcd_Box( 117, 44 /* Height Inverse */, 128, 44+abs(temperature) /* If Temp is > 1 Bottom */, 1);
                  break;

  }

 }

}


void main() {

  int i = 0;
  int pre = 0;
  int j = 0;
  char key;
  int origin = -2;
  
  //MainMenu
  
  SelectMenu = 0;
  
  Current = 0;
  
  //Timer
  count = 9192;
  TMR0 = 0;
  OPTION_REG = 0x07;
  INTCON = 0XA0;
  
  ANSEL  = 0;                                    // Configure AN pins as digital
  ANSELH = 0;
  C1ON_bit = 0;                                  // Disable comparators
  C2ON_bit = 0;

  TRISC = 0;

  SCL_Direction = 0;                 // SCL is output
  
  Glcd_Init();
  Glcd_Fill( 0x00 );

  /*for(i = 0; i < 24; i++)
        hourlyTemperature[i] = Sample[i];
    */

   for(i = 0; i < 24; i++)
        hourlyTemperature[i] = -2000000;

    
   i = 0;

  //Glcd_H_Line( 0, 128, 44, 1 );

 //Render_1Histogram();


 Glcd_Fill( 0x00 );

 Glcd_H_Line( 0, 128, 44, 1 );

  for(j = 0; j < 10; j++)
  {

  Render_Block( hourlyTemperature[j] , j+1);

  origin = PrintTemperature( origin, hourlyTemperature[j] );

  }

  PrintHours( 0, 9, 2);

 //

 origin = -2;

 
 while(1)
 {
  pre = i;
  key = KeyClick();

  //Temperature

  if( count > 9192 )
  {
     INTCON = 0X00;

     Delay_ms(100);
     
     if(Current >= 24)
     {
      Current = 0;
      
      for( i2 = 0; i2<24; i2++)
           hourlyTemperature[ i2 ] = -2000000;
     
     }
     
     hourlyTemperature[ Current ] = Measure( 0x03 );

     Current++;
     
     count = 0;
     
     INTCON = 0XA0;
     
 }
  //
  
  if(key == 'R')
  {
       if(i < 2)
            i++;
  }
  else if(key == 'L')
  {
       if(i > 0)
            i--;
  }
  else if(key == 'C')
   return;

  if(pre == i)
   continue;

   if(i == 0)
   {
    //Render_1Histogram();

   j = 0;

   Glcd_Fill( 0x00 );

   Glcd_H_Line( 0, 128, 44, 1 );

   for(j = 0; j < 10; j++)
   {

   Render_Block( hourlyTemperature[j] , j+1);

   origin = PrintTemperature( origin, hourlyTemperature[j] );

  }

   PrintHours( 0, 9, 2);

 //

   }
   else if(i == 1)
   {

    //Render_2Histogram()


       Glcd_Fill( 0x00 );

       Glcd_H_Line( 0, 128, 44, 1 );

       for(j = 0; j < 10; j++)
       {

        Render_Block( hourlyTemperature[j+10], j+1);

        origin = PrintTemperature( origin, hourlyTemperature[j+10] );

       }

       PrintHours( 10, 19, 2);

       //

   }
   else if( i == 2)
   {

       //Render_3Histogram()

       Glcd_Fill( 0x00 );

       Glcd_H_Line( 0, 128, 44, 1 );

       for(j = 0; j < 4; j++)
       {

        Render_Block( hourlyTemperature[j+20], j+1);

        origin = PrintTemperature( origin, hourlyTemperature[j+20] );
       }

       PrintHours( 20, 23, 2);

       //

   }

   origin = -2;

 }

}
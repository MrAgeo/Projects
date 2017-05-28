// Ejemplo de uso de encoder con LCD

// === Conexion Encoder ===
//
//     +-------+
//     |       |
//     |  {_}  |
//     +-------+
//      v  v  v
//     (+) A  B
//
// OJO: A,B a tierra (con Resistencia!)


#include <LiquidCrystal.h>
#include <Thread.h>

int RS = 40,
    E = 42,
    D4 = 41,
    D5 = 43,
    D6 = 45,
    D7 = 47;
    
int a = 46, b = 44, a2 = 49, b2 = 48, estadoA, estadoB, estadoA2, estadoB2;

Thread t1 = Thread();
Thread t2 = Thread();

LiquidCrystal lcd(RS, E, D4, D5, D6, D7);

void encoder1();
void encoder2();

void setup() {
  lcd.begin(16,2);
  lcd.clear();
  
  pinMode(a, INPUT);
  pinMode(a2, INPUT);
  
  pinMode(b, INPUT);
  pinMode(b2, INPUT);
  
  t1.onRun(encoder1);
  t2.onRun(encoder2);
  
  t1.setInterval(1);
  t2.setInterval(1);
}

void loop() {
  if(t1.shouldRun())
    t1.run();
    
  if(t2.shouldRun())
    t2.run();
}

void encoder1()
{
  estadoA = digitalRead(a);
  estadoB = digitalRead(b);
  
  // Ocurre Pulso
  if ((estadoB == HIGH) || (estadoA== HIGH))
  {
    lcd.setCursor(0,0);
    if (estadoA==HIGH)
    {
      lcd.print("CCW");
    }
    else
    {
      lcd.print("CW ");
    }
    while(digitalRead(b)==HIGH)
    {}
  }
}

void encoder2()
{
  estadoA2 = digitalRead(a2);
  estadoB2 = digitalRead(b2);
  
  // Ocurre Pulso
  if ((estadoB2 == HIGH) || (estadoA2== HIGH))
  {
    lcd.setCursor(0,1);
    if (estadoA2==HIGH)
    {
      lcd.print("CCW");
    }
    else
    {
      lcd.print("CW ");
    }
    while(digitalRead(b2)==HIGH)
    {}
  }
}

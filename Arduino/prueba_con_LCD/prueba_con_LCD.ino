#include <LiquidCrystal.h>
int RS = 36,
    E = 37,
    D4 = 43,
    D5 = 45,
    D6 = 47,
    D7 = 49;

LiquidCrystal lcd(RS, E, D4, D5, D6, D7);
void setup() {
  lcd.begin(16,2);
  lcd.clear();
}

void loop() {
  lcd.setCursor(0,0);
  lcd.print("Hola Mundo!");
}

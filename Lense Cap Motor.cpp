// --- Pin Definitions ---
// Motor Driver (H-Bridge) Pins
const int MOTOR_PIN_A = 5;  // Input 1 on Driver
const int MOTOR_PIN_B = 6;  // Input 2 on Driver

// Limit Switch Pins (Wire common to GND, NO to Pin)
const int LIMIT_OPEN_PIN = 7;  // Triggered when cap is fully OPEN
const int LIMIT_CLOSE_PIN = 8; // Triggered when cap is fully CLOSED

// --- Configuration ---
const unsigned long SAFETY_TIMEOUT = 3000; // Stop after 3 seconds if switch not hit

void setup() {
  Serial.begin(9600);
  
  pinMode(MOTOR_PIN_A, OUTPUT);
  pinMode(MOTOR_PIN_B, OUTPUT);
  
  // Use Internal Pullups: Switches read LOW when pressed, HIGH when open
  pinMode(LIMIT_OPEN_PIN, INPUT_PULLUP);
  pinMode(LIMIT_CLOSE_PIN, INPUT_PULLUP);
  
  stopMotor();
  Serial.println("System Initialized: Lens Cap Ready");
}

void loop() {
  if (Serial.available() > 0) {
    char command = Serial.read();
    
    if (command == 'o') {
      openCap();
    } 
    else if (command == 'c') {
      closeCap();
    }
  }
}

// --- Function to OPEN the Cap ---
void openCap() {
  if (digitalRead(LIMIT_OPEN_PIN) == LOW) {
    Serial.println("Error: Already Open");
    return;
  }

  Serial.println("Opening Cap...");
  unsigned long startTime = millis();

  // Spin motor Forward (Adjust PIN_A/B logic if it spins wrong way)
  digitalWrite(MOTOR_PIN_A, HIGH);
  digitalWrite(MOTOR_PIN_B, LOW);

  // Keep spinning until switch is hit OR timeout occurs
  while (digitalRead(LIMIT_OPEN_PIN) == HIGH) {
    if (millis() - startTime > SAFETY_TIMEOUT) {
      Serial.println("ERROR: Timeout - Jammed?");
      break; 
    }
  }

  stopMotor();
  Serial.println("Cap Fully OPEN");
}

// --- Function to CLOSE the Cap ---
void closeCap() {
  if (digitalRead(LIMIT_CLOSE_PIN) == LOW) {
    Serial.println("Error: Already Closed");
    return;
  }

  Serial.println("Closing Cap...");
  unsigned long startTime = millis();

  // Spin motor Backward
  digitalWrite(MOTOR_PIN_A, LOW);
  digitalWrite(MOTOR_PIN_B, HIGH);

  // Keep spinning until switch is hit OR timeout occurs
  while (digitalRead(LIMIT_CLOSE_PIN) == HIGH) {
    if (millis() - startTime > SAFETY_TIMEOUT) {
      Serial.println("ERROR: Timeout - Jammed?");
      break; 
    }
  }

  stopMotor();
  Serial.println("Cap Fully CLOSED");
}

void stopMotor() {
  digitalWrite(MOTOR_PIN_A, LOW);
  digitalWrite(MOTOR_PIN_B, LOW);
}

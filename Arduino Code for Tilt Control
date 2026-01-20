#include <Servo.h>

Servo tiltServo;  // Create servo object to control the tilt

// --- Configuration ---
const int TILT_PIN = 9;       // Pin connected to the Tilt Servo
const int START_ANGLE = 90;   // Neutral position (Horizon)

// --- Safety Limits (Adjust these based on your physical prototype) ---
const int MIN_TILT = 45;      // Lowest angle (Down)
const int MAX_TILT = 135;     // Highest angle (Up)

int currentTiltAngle = START_ANGLE;

void setup() {
  Serial.begin(9600);
  tiltServo.attach(TILT_PIN);
  
  // specific command to move to start position immediately
  tiltServo.write(START_ANGLE);
  Serial.println("System Initialized: Tilt at Neutral (90)");
}

void loop() {
  // Example: Listen for serial commands 'u' (up) and 'd' (down)
  if (Serial.available() > 0) {
    char command = Serial.read();
    
    if (command == 'u') {
      moveTilt(10); // Tilt Up by 10 degrees
    } 
    else if (command == 'd') {
      moveTilt(-10); // Tilt Down by 10 degrees
    }
  }
}

// --- Custom Function to Handle Movement Safely ---
void moveTilt(int degrees) {
  int targetAngle = currentTiltAngle + degrees;
  
  // specific logic to clamp values between Safety Limits
  if (targetAngle > MAX_TILT) {
    targetAngle = MAX_TILT;
    Serial.println("Warning: Max Tilt Reached");
  } else if (targetAngle < MIN_TILT) {
    targetAngle = MIN_TILT;
    Serial.println("Warning: Min Tilt Reached");
  }
  
  tiltServo.write(targetAngle);
  currentTiltAngle = targetAngle;
  
  Serial.print("Current Tilt: ");
  Serial.println(currentTiltAngle);
}

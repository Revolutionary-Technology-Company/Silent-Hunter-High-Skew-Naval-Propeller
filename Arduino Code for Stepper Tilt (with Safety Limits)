#include <AccelStepper.h>

// --- Pin Definitions ---
const int STEP_PIN = 3;
const int DIR_PIN  = 4;

// --- Configuration ---
// Motor interface type (1 = Driver like A4988 or DRV8825)
#define MOTOR_INTERFACE_TYPE 1

// Create a new instance of the AccelStepper class:
AccelStepper tiltStepper(MOTOR_INTERFACE_TYPE, STEP_PIN, DIR_PIN);

// --- Mechanical Calibration ---
const int STEPS_PER_REV = 200;  // Standard for NEMA 17 (1.8 deg/step)
// If you use microstepping on your driver, multiply this number (e.g., 200 * 16)

// --- Safety Limits (in Steps) ---
// Assuming 0 is the starting horizon. Positive is UP, Negative is DOWN.
const long MAX_UP_STEPS = 1000;   // e.g., approx 45 degrees up
const long MAX_DOWN_STEPS = -500; // e.g., approx 22 degrees down

void setup() {
  Serial.begin(9600);

  // Set the maximum speed (steps per second)
  tiltStepper.setMaxSpeed(200.0);
  
  // Set the acceleration (steps per second^2)
  // Lower = smoother start/stop, better for heavy lenses
  tiltStepper.setAcceleration(50.0);

  Serial.println("System Initialized: Stepper Ready");
}

void loop() {
  // Read Serial commands
  if (Serial.available() > 0) {
    char command = Serial.read();
    
    if (command == 'u') {
      moveTilt(100); // Move Up 100 steps
    } 
    else if (command == 'd') {
      moveTilt(-100); // Move Down 100 steps
    }
  }

  // CRITICAL: This function must be called as often as possible 
  // to actually make the motor move.
  tiltStepper.run();
}

void moveTilt(long stepsToMove) {
  long targetPosition = tiltStepper.currentPosition() + stepsToMove;

  // --- Software Limit Switch Logic ---
  if (targetPosition > MAX_UP_STEPS) {
    targetPosition = MAX_UP_STEPS;
    Serial.println("Warning: Max Up Limit Reached");
  } 
  else if (targetPosition < MAX_DOWN_STEPS) {
    targetPosition = MAX_DOWN_STEPS;
    Serial.println("Warning: Max Down Limit Reached");
  }

  // Set the new target position
  tiltStepper.moveTo(targetPosition);
  
  Serial.print("Moving to: ");
  Serial.println(targetPosition);
}

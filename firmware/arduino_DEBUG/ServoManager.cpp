#include "ServoManager.h"

#define SERVO_MIN 150
#define SERVO_MAX 600

ServoManager::ServoManager(uint8_t count) : count(count) {
  servos = new ServoState[count];
}

void ServoManager::begin() {
  pwm.begin();
  pwm.setPWMFreq(50);
}

void ServoManager::addServo(uint8_t index, uint8_t channel, float startAngle) {
  servos[index] = {
    .channel = channel,
    .currentAngle = startAngle,
    .targetAngle = startAngle,
    .speedDegPerSec = 0,
    .lastUpdate = millis(),
    .active = false
  };
  writeServo(channel, startAngle);
}

void ServoManager::moveTo(uint8_t index, float angle, float speed) {
  servos[index].targetAngle = angle;
  servos[index].speedDegPerSec = speed;
  servos[index].lastUpdate = millis();
  servos[index].active = true;
}

void ServoManager::update() {
  unsigned long now = millis();

  for (int i = 0; i < count; i++) {
    if (!servos[i].active) continue;

    float delta = servos[i].targetAngle - servos[i].currentAngle;
    if (abs(delta) < 0.5) {
      servos[i].currentAngle = servos[i].targetAngle;
      writeServo(servos[i].channel, servos[i].currentAngle);
      servos[i].active = false;
      continue;
    }

    float dir = (delta > 0) ? 1.0 : -1.0;
    float elapsedSec = (now - servos[i].lastUpdate) / 1000.0;
    float step = servos[i].speedDegPerSec * elapsedSec * dir;

    if (abs(step) > abs(delta)) step = delta; // clamp overshoot

    servos[i].currentAngle += step;
    servos[i].lastUpdate = now;
    writeServo(servos[i].channel, servos[i].currentAngle);
  }
}

void ServoManager::writeServo(uint8_t channel, float angle) {
  angle = constrain(angle, 0, 180);
  uint16_t pulse = map(angle, 0, 180, SERVO_MIN, SERVO_MAX);
  pwm.setPWM(channel, 0, pulse);
}


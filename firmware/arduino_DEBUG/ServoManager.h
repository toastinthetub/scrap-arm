#ifndef SERVOMANAGER_H
#define SERVOMANAGER_H

#include <Adafruit_PWMServoDriver.h>

struct ServoState {
  uint8_t channel;
  float currentAngle;
  float targetAngle;
  float speedDegPerSec;
  unsigned long lastUpdate;
  bool active;
};

class ServoManager {
  public:
    ServoManager(uint8_t count);
    void begin();
    void addServo(uint8_t index, uint8_t channel, float startAngle = 90);
    void moveTo(uint8_t index, float angle, float speedDegPerSec);
    void update(); 

  private:
    Adafruit_PWMServoDriver pwm;
    ServoState* servos;
    uint8_t count;

    void writeServo(uint8_t channel, float angle);
};

#endif


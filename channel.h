#ifndef _CHANNEL_H
#define _CHANNEL_H

#include <avr/io.h>
#include <avr/interrupt.h>

#define ro PB2			// audio out to speaker or amp
#define lo PB3			// audio out to speaker or amp

class Channel {
protected:
	uint8_t pin;

public:
	Channel(uint8_t pin) : pin(pin) {}

	virtual void set(uint16_t freq);
	virtual void stop();
};

class Timer1Channel : public Channel {
public:
	Timer1Channel(uint16_t pin) : Channel(pin) {}
	void set(uint16_t freq);
	void stop();
};

class Timer2Channel : public Channel {
public:
	Timer2Channel(uint16_t pin)
		: Channel(pin) {}
	void set(uint16_t freq);
	void stop();
};

Timer2Channel leftChannel(lo);
Timer1Channel rightChannel(ro);

#endif

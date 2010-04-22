#ifndef _CHANNEL_H
#define _CHANNEL_H

#include <avr/io.h>
#include <avr/interrupt.h>

#define ro PB2			// audio out to speaker or amp
#define lo PB3			// audio out to speaker or amp

#define BASEOCTAVE 4
#define BASETEMPO 0

//octaves  - corresponds to piano octaves
// oct[0] means the 0. octave
uint16_t oct[] = { 1024, 512, 256, 128, 64, 32, 16, 8, 4, 2 };
uint8_t tmpo[] = { 0, 1, 2, 4, 8, 16, 32 };

class Channel {
protected:
	uint8_t pin;
	uint16_t period;
	bool active;
	uint32_t last_tick;
	uint32_t now;

	virtual void set() = 0;
	virtual void end() = 0;
public:
	Channel(uint8_t pin);
	uint8_t octave;
	uint8_t tempo;

	void reset_octave();
	void reset_tempo();

	void begin();
	void tick(uint16_t beat, uint32_t now_);

	virtual void play_note(uint16_t basefreq);
	virtual void stop();
};

class Timer1Channel : public Channel {
protected:
	void set();
	void end();
public:
	Timer1Channel(uint16_t pin) : Channel(pin) {}
	void play_note(uint16_t period);
	void stop();
};

class Timer2Channel : public Channel {
protected:
	void set();
	void end();
public:
	Timer2Channel(uint16_t pin)
		: Channel(pin) {}
	void play_note(uint16_t period);
	void stop();
};

Timer2Channel leftChannel(lo);
Timer1Channel rightChannel(ro);

#endif

#ifndef _CHANNEL_H
#define _CHANNEL_H

#define ro 10			// audio out to speaker or amp
#define lo 11			// audio out to speaker or amp

class Channel {
private:
	unsigned char pin;
	unsigned int period;
	unsigned long int tlast, tnow;
	bool state;
	bool active;

public:
	Channel(unsigned char pin) : pin(pin), active(false) {}

	void play();
	void set(unsigned int freq);
	void stop();
};

Channel leftChannel(lo);
Channel rightChannel(ro);

#endif

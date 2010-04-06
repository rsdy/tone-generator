#include "channel.h"

void Channel::play()
{
	if (!active) return;

	tnow = micros();
	if (tnow - tlast >= period) {
		state = !state;
		digitalWrite(pin, state);
		tlast = tnow;
	}
}

void Channel::stop() {
	active = false;
	pinMode(pin, INPUT);
}

void Channel::set(unsigned int freq)
{
	period = (500000 / freq);
	state = false;
	tlast = micros();
	active = true;

	pinMode(pin, OUTPUT);
}

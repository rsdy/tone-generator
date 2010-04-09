#include "channel.h"
#include <TimerOne.h>
#include <FrequencyTimer2.h>

inline void Channel::set(uint16_t freq)
{
	DDRB |= _BV(pin);
}

inline void Channel::stop()
{
	DDRB &= ~_BV(pin);
}

inline void Timer2Channel::stop()
{
	FrequencyTimer2::disable();
	Channel::stop();
}

inline void Timer2Channel::set(uint16_t freq)
{
	Channel::set(pin);
	FrequencyTimer2::setPeriod(1000000/freq);
	FrequencyTimer2::enable();
}

inline void Timer1Channel::stop()
{
	Timer1.stop();
}

inline void Timer1Channel::set(uint16_t freq)
{
	Channel::set(pin);
	Timer1.pwm(pin, 512, 1000000/freq);
}

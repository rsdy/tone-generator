#include "channel.h"
#include <TimerOne.h>
#include <FrequencyTimer2.h>

inline Channel::Channel(uint8_t pin) : pin(pin), active(false), last_tick(0)
{
	reset_octave();
	reset_tempo();
}

inline void Channel::reset_octave()
{
	octave = BASEOCTAVE;
}

inline void Channel::reset_tempo()
{
	tempo = BASETEMPO;
}

inline void Channel::stop()
{
	DDRB &= ~_BV(pin);
	active = false;
}

inline void Channel::play_note(uint16_t basefreq)
{
	DDRB |= _BV(pin);
	period = 1000000/(basefreq/oct[octave]);
	active = true;
}

inline void Channel::begin() {
	active = true;
	last_tick = millis();
	set();
}

void Channel::tick(uint16_t beat, uint32_t now_)
{
	if(!active || tempo < 1 || tempo > 6 )
		return;

	now = now_;
	if(now - last_tick > beat/tmpo[tempo]) {
		end();
		active = false;
	}
}

/////////////////
void Timer2Channel::stop()
{
	FrequencyTimer2::disable();
	Channel::stop();
}

void Timer2Channel::play_note(uint16_t note)
{
	Channel::play_note(note);
	FrequencyTimer2::setPeriod(period);
	FrequencyTimer2::enable();
}

void Timer2Channel::set()
{
    TCCR2A |= _BV(COM2A0);
}

void Timer2Channel::end()
{
	TCCR2A &= ~(_BV(COM2A0));
}

/////////////////
void Timer1Channel::stop()
{
	Timer1.stop();
	Channel::stop();
}

void Timer1Channel::play_note(uint16_t note)
{
	Channel::play_note(note);
	Timer1.pwm(pin, 512, period);
}

void Timer1Channel::set()
{	
  TCCR1B |= Timer1.clockSelectBits;
}

void Timer1Channel::end()
{	
  TCCR1B &= ~(Timer1.clockSelectBits);
}

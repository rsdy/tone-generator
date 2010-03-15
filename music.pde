#include "music.h"
#include "sounds.pde"
#include <TimerOne.h>

void Channel::play()
{
	if (!on_job) return;

	currmicros = millis();
	if(currmicros - lastmicros > cycles)
	{
		pinMode(pin, INPUT);
		Timer1.stop();
		on_job = false;
	}
}

void Channel::set(unsigned int f, unsigned int t)
{
	this->freq = (50000000 / f);
	cycles = ((long)f*(long)t)/25000;

	pinMode(pin, OUTPUT);
	Timer1.pwm(pin, 512, this->freq);
	lastmicros = millis();

	Serial.println(pin, DEC);

	on_job = true;
}

void setup()
{
	Serial.begin(9600);
	fp = v_1;
	Timer1.initialize();
}

void freqout(int freq1, int freq2, int t)
{
	leftChannel.set(freq1, t);
	rightChannel.set(freq2, t);
}

int charToNote(char c)
{
	switch (c) {
	case 'q':
		return C / 2;
	case '2':
		return CS / 2;
	case 'w':
		return D / 2;
	case '3':
		return DS / 2;
	case 'e':
		return E / 2;
	case 'r':
		return F / 2;
	case '5':
		return FS / 2;
	case 't':
		return G / 2;
	case '6':
		return GS / 2;
	case 'y':
		return A;
	case '7':
		return AS;
	case 'u':
		return B;
	case 'z':
		return C;
	case 's':
		return CS;
	case 'x':
		return D;
	case 'd':
		return DS;
	case 'c':
		return E;
	case 'v':
		return F;
	case 'g':
		return FS;
	case 'b':
		return G;
	case 'h':
		return GS;
	case 'n':
		return A * 2;
	case 'j':
		return AS * 2;
	case 'm':
		return B * 2;
	case '!':
		fp = v_1;
		return 0;
	case '@':
		fp = u_2;
		return 0;
	case '#':
		fp = u_3;
		return 0;
	case '+':
		--o;
		return 0;
	case '-':
		++o;
		return 0;
	case '0':
		o = 5;
		return 0;
	default:
		return 0;
	}
}

void loop()
{
	if (Serial.available()) {
		ch = Serial.read();
		Serial.print(ch);
		int tt;
		tt = charToNote(ch);
		if (tt) {
			fp(tt);
		}
	}
/*
	leftChannel.play();
	rightChannel.play();
	*/
}

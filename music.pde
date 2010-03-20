#include "music.h"

void setup()
{
	Serial.begin(9600);
	fp = v_1;
}

void freqout(int freq1, int freq2, int t)	// freq in hz, t in ms
{
	unsigned int hperiodl, hperiodr;	//calculate 1/2 period in us
	long cycles, i;
	unsigned long int curr, lastlo, lastro;
	boolean rval = false, lval = false;

	hperiodl = (500000 / freq1) - 7;	// subtract 7 us to make up for digitalWrite overhead
	hperiodr = (500000 / freq2) - 7;	// subtract 7 us to make up for digitalWrite overhead

	cycles = ((long)freq1 * (long)t) / 1000;
	pinMode(ro, OUTPUT);	// turn on output pin
	pinMode(lo, OUTPUT);
	lastlo = curr = lastro = micros();
	for (i = 0; i <= cycles * 2; curr = micros()) {
		if (curr - lastlo >= hperiodl) {
			lval = !lval;
			digitalWrite(lo, lval);
			lastlo = curr;
			i++;
		}
		if (curr - lastro >= hperiodr) {
			rval = !rval;
			digitalWrite(ro, rval);
			lastro = curr;
		}
	}

	pinMode(ro, INPUT);	// shut off pin to avoid noise from other operations
	pinMode(lo, INPUT);	// shut off pin to avoid noise from other operations
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
		Serial.print(ch,BYTE);
		int tt;
		tt = charToNote(ch);
		if (tt)
			fp(tt);
	}
}

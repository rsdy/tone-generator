#include "music.h"
#include "channel.h"

void handleNote(char c)
{
	switch (c) {
	case 'q':
		leftChannel.set(C/oct[octl]); break;
	case '2':
		leftChannel.set(CS/oct[octl]); break;
	case 'w':
		leftChannel.set(D/oct[octl]); break;
	case '3':
		leftChannel.set(DS/oct[octl]); break;
	case 'e':
		leftChannel.set(E/oct[octl]); break;
	case 'r':
		leftChannel.set(F/oct[octl]); break;
	case '5':
		leftChannel.set(FS/oct[octl]); break;
	case 't':
		leftChannel.set(G/oct[octl]); break;
	case '6':
		leftChannel.set(GS/oct[octl]); break;
	case 'z':
		leftChannel.set(A/oct[octl]); break;
	case 's':
		leftChannel.set(AS/oct[octl]); break;
	case 'x':
		leftChannel.set(B/oct[octl]); break;
/////////////////
	case 'u':
		rightChannel.set(C/oct[octr]); break;
	case '8':
		rightChannel.set(CS/oct[octr]); break;
	case 'i':
		rightChannel.set(D/oct[octr]); break;
	case '9':
		rightChannel.set(DS/oct[octr]); break;
	case 'o':
		rightChannel.set(E/oct[octr]); break;
	case 'p':
		rightChannel.set(F/oct[octr]); break;
	case '-':
		rightChannel.set(FS/oct[octr]); break;
	case '[':
		rightChannel.set(G/oct[octr]); break;
	case '=':
		rightChannel.set(GS/oct[octr]); break;
	case 'm':
		rightChannel.set(A/oct[octr]); break;
	case 'k':
		rightChannel.set(AS/oct[octr]); break;
	case ',':
		rightChannel.set(B/oct[octr]); break;
/////////////////
	case 'f':
		leftChannel.stop();
		break;
	case 'l':
		rightChannel.stop();
		break;
	case 'g':
		++octl;
		break;
	case 'v':
		--octl;
		break;
	case '\'':
		++octr;
		break;
	case '/':
		--octr;
		break;
	case '\\':
		octl = octr = BASEOCTAVE;
		break;
	default:
		break;
	}
}

void setup()
{
	Serial.begin(9600);
	octl = octr = BASEOCTAVE;
}

void loop()
{
	if (Serial.available())
		handleNote(Serial.read());

	rightChannel.play();
	leftChannel.play();
}

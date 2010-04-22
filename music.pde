#include "notes.h"
#include "channel.h"
#include <TimerOne.h>

#define BASEBPM 100

static uint8_t bpm = BASEBPM;
static uint16_t beat;
static uint32_t last = millis();
static uint32_t now;

void handleNote(uint8_t c)
{
	switch (c) {
	case 'q': leftChannel.play_note(C); break;
	case '2': leftChannel.play_note(CS); break;
	case 'w': leftChannel.play_note(D); break;
	case '3': leftChannel.play_note(DS); break;
	case 'e': leftChannel.play_note(E); break;
	case 'r': leftChannel.play_note(F); break;
	case '5': leftChannel.play_note(FS); break;
	case 't': leftChannel.play_note(G); break;
	case '6': leftChannel.play_note(GS); break;
	case 'z': leftChannel.play_note(A); break;
	case 's': leftChannel.play_note(AS); break;
	case 'x': leftChannel.play_note(B); break;
/////////////////
	case 'u': rightChannel.play_note(C); break;
	case '8': rightChannel.play_note(CS); break;
	case 'i': rightChannel.play_note(D); break;
	case '9': rightChannel.play_note(DS); break;
	case 'o': rightChannel.play_note(E); break;
	case 'p': rightChannel.play_note(F); break;
	case '-': rightChannel.play_note(FS); break;
	case '[': rightChannel.play_note(G); break;
	case '=': rightChannel.play_note(GS); break;
	case 'm': rightChannel.play_note(A); break;
	case 'k': rightChannel.play_note(AS); break;
	case ',': rightChannel.play_note(B); break;
/////////////////
	case 'f': leftChannel.stop(); break;
	case 'l': rightChannel.stop(); break;
	case 'g': ++leftChannel.octave; break;
	case 'v': --leftChannel.octave; break;
	case '\'': ++rightChannel.octave; break;
	case '/': --rightChannel.octave; break;
	case 'G': ++leftChannel.tempo; break;
	case 'V': --leftChannel.tempo; break;
	case '"': ++rightChannel.tempo; break;
	case '?': --rightChannel.tempo; break;
	case '\\':
		leftChannel.reset_octave();
		rightChannel.reset_octave();
		break;
	case '|':
		leftChannel.reset_tempo();
		rightChannel.reset_tempo();
		break;
	default:
		break;
	}
}

void setup()
{
	Serial.begin(9600);
	Timer1.initialize();
}

void loop()
{
	if (Serial.available())
		handleNote(Serial.read());
	
	beat = 60000/bpm;
	now = millis();
	if(now - last > beat) {
		leftChannel.begin();
		rightChannel.begin();
		last = now;
	}
	
	leftChannel.tick(beat, now);
	rightChannel.tick(beat, now);
}

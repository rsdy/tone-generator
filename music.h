#include <math.h>		// requires an Atmega168 chip

#define ro 9			// audio out to speaker or amp
#define lo 10			// audio out to speaker or amp
int o;
void (*fp)(int) = NULL;

// note values for two octave scale
// divide them by powers of two to generate other octaves
float A = 14080;
float AS = 14917.2;
float B = 15804.3;
float C = 16744;
float CS = 17739.7;
float D = 18794.5;
float DS = 19912.1;
float E = 21096.2;
float F = 22350.6;
float FS = 23679.6;
float G = 25087.7;
float GS = 26579.5;
float A2 = 28160;
float A2S = 29834.5;
float B2 = 31608.5;
float C2 = 33488.1;
float C2S = 35479.4;
float D2 = 37589.1;
float D2S = 39824.3;
float E2 = 42192.3;
float F2 = 44701.2;
float F2S = 47359.3;
float G2 = 50175.4;
float G2S = 53159;
float A3 = 56320;

//octaves  - corresponds to piano octaves
float oct[] = { 4, 8, 16, 32, 64, 128, 256, 512, 1024 };

//rhythm values
int wh = 1024;
int h = 512;
int dq = 448;
int q = 256;
int qt = 170;
int de = 192;
int e = 128;
int et = 85;
int dsx = 96;
int sx = 64;
int thx = 32;

void v_1(int);
void u_2(int);
void u_3(int);
void freqout(int leftf, int rigthf, int time);

class Channel {
	unsigned char pin;
	unsigned int freq;
	unsigned int time;
	unsigned long currmillis, lastmillis;
	bool on_job;

public:
	Channel(unsigned char pin) : pin(pin), on_job(false) {}

	bool onjob() { return on_job; };

	void play();
	void set(unsigned int freq, unsigned int time);
};

Channel leftChannel(lo);
Channel rightChannel(ro);

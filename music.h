#ifndef _MUSIC_H
#define _MUSIC_H

#define BASEOCTAVE 4

int octl, octr;

float C = 16744;
float CS = 17739.7;
float D = 18794.5;
float DS = 19912.1;
float E = 21096.2;
float F = 22350.6;
float FS = 23679.6;
float G = 25087.7;
float GS = 26579.5;
float A = 28160;
float AS = 29834.5;
float B = 31608.5;
float C2= 33488.1;
float C2S = 35479.4;
float D2 = 37589.1;
float D2S = 39824.3;
float E2 = 42192.3;
float F2 = 44701.2;
float F2S = 47359.3;
float G2 = 50175.4;
float G2S = 53159;
float A2 = 56320;

//octaves  - corresponds to piano octaves
// oct[0] means the 0. octave
float oct[] = { 1024, 512, 256, 128, 64, 32, 16, 8, 4, 2 };

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

#endif

void v_1(int t)
{
	int l[] = {
		A / oct[o],
		A / oct[o],
		A / oct[o],
		A / oct[o],
		A / oct[o],
		A / oct[o],
		A / oct[o],	
		A / oct[o],
		A / oct[o],
		A / oct[o],
		A / oct[o],
		C / oct[o],
		C / oct[o],
		D / oct[o],
		D / oct[o]
	};
	int r[] = {
		A / (oct[o]),    
		A / (oct[o]),    
		A / (oct[o] / 2),
		A / (oct[o] / 3),
		A / (oct[o] / 4),
		A / (oct[o] / 5),
		A / (oct[o] / 4),
		C / (oct[o] / 4),
		D / (oct[o] / 2),
		C / (oct[o] / 4),
		D / (oct[o] / 2),
		A / (oct[o] / 2),
		A / (oct[o] / 4),
		D / (oct[o] / 2),
		D / (oct[o] / 3)
	};

	for(int i = 0; i < 15; i++) {
		freqout(l[i], r[i], (i > 1 && i < 5) ? 100 : 400);
		while(rightChannel.onjob()) {
			leftChannel.play();
			rightChannel.play();
		}
	}
}

void u_2(int t)
{
/*
      freqout(t / oct[o] , 100);
      freqout(t / oct[o] , 100);
      freqout(t / oct[o] * 2, 100);
      freqout(t / oct[o] * 3 , 100);
      delay(40);
      freqout(t / oct[o] , 100);
      freqout(t / oct[o] , 100);
      freqout(t / oct[o] / 2, 100);
      freqout(t / oct[o] / 3, 100);
      delay(40);
      freqout(t / oct[o] , 100);
      freqout(t / oct[o] , 100);
      freqout(t / oct[o] * 2, 100);
      freqout(t / oct[o] * 3, 100);
      delay(40);
      freqout(t / oct[o] , 100);
      freqout(t / oct[o] , 100);
      freqout(t / oct[o] / 2, 100);
      freqout(t / oct[o] / 3, 100);
      delay(40);
*/
}

void u_3(int t)
{
/*
      freqout(t / oct[o] / 2 , 100);
      freqout(t / oct[o] / 2, 100);
      freqout(t / oct[o] , 100);
      freqout(t / oct[o] * 2 , 100);
      delay(40);
      freqout(t / oct[o] / 2, 100);
      freqout(t / oct[o] / 2, 100);
      freqout(t / oct[o] * 2, 100);
      freqout(t / oct[o] * 3, 100);
      delay(40);
      freqout(t / oct[o] / 2, 100);
      freqout(t / oct[o] / 2, 100);
      freqout(t / oct[o] , 100);
      freqout(t / oct[o] * 2, 100);
      delay(40);
      freqout(t / oct[o] / 2, 100);
      freqout(t / oct[o] / 2, 100);
      freqout(t / oct[o] * 2, 100);
      freqout(t / oct[o] * 3, 100);
      delay(40);
*/
}

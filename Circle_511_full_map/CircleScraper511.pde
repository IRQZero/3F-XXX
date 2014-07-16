/*
This software copyright Digital Ambience, 2014.
This software may not be used for any commercial purpose. 
The only rights granted are for demonstration of capabilities of the software of Digital Ambience.
Any use outside of the expressed and written agreements between Digital Ambience and its business associates is a violation of this copyright and good faith between parties. 
Author: M. Howell (matthewdhowell@gmail.com)
*/

int NumLEDs = 256;
int NumLEDs2 = 255;

class CircleScraper {

  Point[] circleArray;  // array that holds the offsets to each pixel
  Point[] circleArray2; // array that holds the offsets to each pixel

  Point  position;    // the scrape location for the center of the circle
  float  scaleX;      // scale factor horizontal
  float  scaleY;      // scale factor vertical
  CircleScraper(float x, float y, float scaleX, float scaleY, float rotation) {
    circleArray= new Point[NumLEDs];
    circleArray2= new Point[NumLEDs2];
    initCircleArray();

    this.scaleX = scaleY;
    this.position = new Point(x, y);

    // We want to save the time taken to do the matrix manipulation during the scrape,
    // so we'll pre-transform and pre-translate the array here.

    for (int i=0; i<NumLEDs; i++)
    {
      circleArray[i].rotate90();
      circleArray[i] = circleArray[i].scale(scaleX, scaleY);
      circleArray[i] = circleArray[i].invertX();
      //circleArray[i] = circleArray[i].invertY();
      circleArray[i] = circleArray[i].add(position);
      //println("("+circleArray[i].x+","+circleArray[i].y+")");
    }
    
    for (int i=0; i<NumLEDs2; i++) 
    {
      circleArray2[i].rotate90();
      circleArray2[i] = circleArray2[i].scale(scaleX, scaleY);
      circleArray2[i] = circleArray2[i].invertX();
      //circleArray[i] = circleArray[i].invertY();
      circleArray2[i] = circleArray2[i].add(position);
      //println("("+circleArray2[i].x+","+circleArray2[i].y+")");
    }
    
  }
  
  void scrapeStrip(int boardOffset, Strip s, PImage pi) {
    if((boardOffset > 1) || (boardOffset < 0)) {
      throw new Error("Board Index should be 0 or 1");
    }
    
    int sample;

//    colorMode(HSB, 255);
//    rectMode(CENTER);

    if(boardOffset == 0) {
      for (int i=0; i<NumLEDs; i++) {
        sample = pi.pixels[((int)circleArray[i].x+ ((int)circleArray[i].y)*pi.width)];
        s.setPixel(sample, i);

//        if(showScrapePoints == true) {
//          fill(sample);
//          stroke(0);
//          rect(circleArray[i].x, circleArray[i].y, 2, 2);
//        }
      }
    } else {
      for (int i=0; i<NumLEDs2; i++) {
        sample = pi.pixels[((int)circleArray2[i].x+ ((int)circleArray2[i].y)*pi.width)];
        s.setPixel(sample, i);
        //println("("+circleArray2[i].x+","+circleArray2[i].y+")");
//        if(showScrapePoints == true) {
//          fill(sample);
//          stroke(255);
//          rect(circleArray2[i].x, circleArray2[i].y, 2, 2);
//        }
      }
    }
    pi.updatePixels();
  }
//      if (i==testPixel) {
//        sample = #000000;
//      }
      
//      float brightnessModSample = color(hue(sample), saturation(sample), floor(brightness(sample) * globalAlpha));
//      s.setPixel((int)brightnessModSample, i);
//      s.setPixel(sample, i);

//      rectMode(CENTER);
//      //fill(255, i, i);
//      fill(sample);
//      stroke(0);
//      rect(circleArray[i].y, circleArray[i].x, 20, 20);
//    }
//    if ((frameCount % 30) == 0) {
//      testPixel++;
//      if (testPixel == actualLength) {
//        testPixel = 0;
//      }
//    }
//  }
  
  void initCircleArray() {
    // This is pretty gross, so let's remove it from the constructor. - jls
    // These offsets extracted from the circle generator.
    
    circleArray[0] = new Point(466.27908, 44.186066);
    circleArray[1] = new Point(460.46512, 87.20932);
    circleArray[2] = new Point(453.48837, 129.0698);
    circleArray[3] = new Point(438.3721, 172.09305);
    circleArray[4] = new Point(420.93024, 210.46512);
    circleArray[5] = new Point(401.16278, 247.67442);
    circleArray[6] = new Point(374.4186, 283.72095);
    circleArray[7] = new Point(346.51163, 317.44186);
    circleArray[8] = new Point(315.11627, 348.83722);
    circleArray[9] = new Point(283.72095, 375.5814);
    circleArray[10] = new Point(246.51164, 400.0);
    circleArray[11] = new Point(208.13956, 420.93024);
    circleArray[12] = new Point(167.44186, 439.53488);
    circleArray[13] = new Point(129.0698, 454.65115);
    circleArray[14] = new Point(87.20932, 460.46512);
    circleArray[15] = new Point(41.860474, 469.76746);
    circleArray[16] = new Point(1.1628113, 470.93024);
    circleArray[17] = new Point(-41.860474, 468.60464);
    circleArray[18] = new Point(-86.04651, 462.7907);
    circleArray[19] = new Point(-126.74414, 452.3256);
    circleArray[20] = new Point(-167.44183, 436.0465);
    circleArray[21] = new Point(-208.13953, 420.93024);
    circleArray[22] = new Point(-246.5116, 398.83722);
    circleArray[23] = new Point(-284.88367, 374.4186);
    circleArray[24] = new Point(-315.11627, 346.51163);
    circleArray[25] = new Point(-345.34882, 313.9535);
    circleArray[26] = new Point(-373.2558, 283.72095);
    circleArray[27] = new Point(-399.99994, 248.83722);
    circleArray[28] = new Point(-419.7674, 209.30234);
    circleArray[29] = new Point(-436.04645, 168.60468);
    circleArray[30] = new Point(-449.99994, 129.0698);
    circleArray[31] = new Point(-460.4651, 87.20932);
    circleArray[32] = new Point(-467.44183, 43.023285);
    circleArray[33] = new Point(-468.6046, -1.1627808);
    circleArray[34] = new Point(-436.04645, -2.3255615);
    circleArray[35] = new Point(-432.5581, 40.697693);
    circleArray[36] = new Point(-425.58136, 84.88373);
    circleArray[37] = new Point(-416.27905, 125.58142);
    circleArray[38] = new Point(-401.16278, 169.76746);
    circleArray[39] = new Point(-383.7209, 204.65118);
    circleArray[40] = new Point(-361.62787, 243.02325);
    circleArray[41] = new Point(-336.0465, 275.58142);
    circleArray[42] = new Point(-306.97675, 309.30234);
    circleArray[43] = new Point(-276.74414, 338.3721);
    circleArray[44] = new Point(-239.53485, 365.11627);
    circleArray[45] = new Point(-205.8139, 384.88373);
    circleArray[46] = new Point(-167.44183, 403.48837);
    circleArray[47] = new Point(-125.58136, 417.44186);
    circleArray[48] = new Point(-82.558105, 426.7442);
    circleArray[49] = new Point(-43.023254, 433.72095);
    circleArray[50] = new Point(3.0517578E-5, 436.0465);
    circleArray[51] = new Point(41.860474, 432.55814);
    circleArray[52] = new Point(86.04654, 427.90698);
    circleArray[53] = new Point(126.7442, 416.27908);
    circleArray[54] = new Point(165.1163, 403.48837);
    circleArray[55] = new Point(204.65118, 383.72095);
    circleArray[56] = new Point(241.86047, 363.9535);
    circleArray[57] = new Point(274.4186, 337.2093);
    circleArray[58] = new Point(305.81396, 309.30234);
    circleArray[59] = new Point(336.0465, 276.7442);
    circleArray[60] = new Point(363.9535, 244.18605);
    circleArray[61] = new Point(384.88373, 206.97675);
    circleArray[62] = new Point(402.3256, 167.44186);
    circleArray[63] = new Point(417.44186, 126.7442);
    circleArray[64] = new Point(425.5814, 84.88373);
    circleArray[65] = new Point(432.55814, 41.860474);
    circleArray[66] = new Point(398.83722, 41.860474);
    circleArray[67] = new Point(393.02325, 84.88373);
    circleArray[68] = new Point(382.55814, 124.41861);
    circleArray[69] = new Point(365.11627, 165.1163);
    circleArray[70] = new Point(347.67444, 201.16281);
    circleArray[71] = new Point(324.4186, 236.04651);
    circleArray[72] = new Point(297.67444, 270.93024);
    circleArray[73] = new Point(268.60468, 301.16278);
    circleArray[74] = new Point(234.88373, 324.4186);
    circleArray[75] = new Point(201.16281, 347.67444);
    circleArray[76] = new Point(162.79071, 367.44186);
    circleArray[77] = new Point(124.41861, 382.55814);
    circleArray[78] = new Point(84.88373, 395.34885);
    circleArray[79] = new Point(43.023285, 400.0);
    circleArray[80] = new Point(2.325592, 402.3256);
    circleArray[81] = new Point(-43.023254, 398.83722);
    circleArray[82] = new Point(-82.558105, 393.02325);
    circleArray[83] = new Point(-125.58136, 381.39536);
    circleArray[84] = new Point(-163.95349, 367.44186);
    circleArray[85] = new Point(-200.0, 348.83722);
    circleArray[86] = new Point(-236.04651, 324.4186);
    circleArray[87] = new Point(-267.44183, 301.16278);
    circleArray[88] = new Point(-296.5116, 268.60468);
    circleArray[89] = new Point(-322.09302, 238.3721);
    circleArray[90] = new Point(-345.34882, 201.16281);
    circleArray[91] = new Point(-366.27905, 163.95349);
    circleArray[92] = new Point(-382.5581, 124.41861);
    circleArray[93] = new Point(-390.69763, 86.04654);
    circleArray[94] = new Point(-397.67438, 41.860474);
    circleArray[95] = new Point(-401.16278, -1.1627808);
    circleArray[96] = new Point(-367.44183, 1.1628113);
    circleArray[97] = new Point(-365.11627, 45.348846);
    circleArray[98] = new Point(-355.8139, 89.53491);
    circleArray[99] = new Point(-343.02325, 131.39536);
    circleArray[100] = new Point(-326.74414, 172.09305);
    circleArray[101] = new Point(-301.16278, 212.79071);
    circleArray[102] = new Point(-274.41858, 245.34885);
    circleArray[103] = new Point(-245.34882, 276.7442);
    circleArray[104] = new Point(-209.3023, 303.48837);
    circleArray[105] = new Point(-169.7674, 327.90698);
    circleArray[106] = new Point(-129.06976, 346.51163);
    circleArray[107] = new Point(-86.04651, 358.13953);
    circleArray[108] = new Point(-44.186035, 363.9535);
    circleArray[109] = new Point(1.1628113, 369.76746);
    circleArray[110] = new Point(43.023285, 366.27905);
    circleArray[111] = new Point(87.20932, 358.13953);
    circleArray[112] = new Point(130.23257, 343.02325);
    circleArray[113] = new Point(172.09305, 329.06976);
    circleArray[114] = new Point(210.46512, 304.65118);
    circleArray[115] = new Point(244.18605, 276.7442);
    circleArray[116] = new Point(276.7442, 245.34885);
    circleArray[117] = new Point(302.3256, 209.30234);
    circleArray[118] = new Point(325.58142, 173.25583);
    circleArray[119] = new Point(344.18604, 131.39536);
    circleArray[120] = new Point(358.13953, 89.53491);
    circleArray[121] = new Point(363.9535, 45.348846);
    circleArray[122] = new Point(331.39536, 43.023285);
    circleArray[123] = new Point(324.4186, 88.3721);
    circleArray[124] = new Point(309.30234, 127.90698);
    circleArray[125] = new Point(291.86047, 168.60468);
    circleArray[126] = new Point(267.44186, 205.81396);
    circleArray[127] = new Point(237.20932, 238.3721);
    circleArray[128] = new Point(203.48837, 266.27908);
    circleArray[129] = new Point(166.27908, 291.86047);
    circleArray[130] = new Point(127.90698, 310.46512);
    circleArray[131] = new Point(84.88373, 325.58142);
    circleArray[132] = new Point(45.348846, 336.0465);
    circleArray[133] = new Point(3.0517578E-5, 337.2093);
    circleArray[134] = new Point(-43.023254, 334.88373);
    circleArray[135] = new Point(-87.20929, 325.58142);
    circleArray[136] = new Point(-126.74414, 312.7907);
    circleArray[137] = new Point(-166.27905, 293.02325);
    circleArray[138] = new Point(-201.16278, 266.27908);
    circleArray[139] = new Point(-236.04651, 238.3721);
    circleArray[140] = new Point(-262.79065, 205.81396);
    circleArray[141] = new Point(-288.37207, 170.93024);
    circleArray[142] = new Point(-309.3023, 131.39536);
    circleArray[143] = new Point(-322.09302, 88.3721);
    circleArray[144] = new Point(-333.7209, 44.186066);
    circleArray[145] = new Point(-337.2093, 3.0517578E-5);
    circleArray[146] = new Point(-298.83716, 3.4884033);
    circleArray[147] = new Point(-296.5116, 45.348846);
    circleArray[148] = new Point(-287.2093, 86.04654);
    circleArray[149] = new Point(-272.09302, 126.7442);
    circleArray[150] = new Point(-252.32556, 163.95349);
    circleArray[151] = new Point(-224.41858, 198.83722);
    circleArray[152] = new Point(-195.34882, 227.90698);
    circleArray[153] = new Point(-162.79065, 253.48839);
    circleArray[154] = new Point(-124.41858, 275.58142);
    circleArray[155] = new Point(-83.72089, 289.5349);
    circleArray[156] = new Point(-40.69763, 298.83722);
    circleArray[157] = new Point(2.325592, 302.3256);
    circleArray[158] = new Point(44.186066, 297.67444);
    circleArray[159] = new Point(86.04654, 289.5349);
    circleArray[160] = new Point(124.41861, 275.58142);
    circleArray[161] = new Point(161.62793, 254.65117);
    circleArray[162] = new Point(196.51163, 226.7442);
    circleArray[163] = new Point(226.7442, 198.83722);
    circleArray[164] = new Point(253.48839, 165.1163);
    circleArray[165] = new Point(275.58142, 126.7442);
    circleArray[166] = new Point(290.6977, 84.88373);
    circleArray[167] = new Point(295.34885, 41.860474);
    circleArray[168] = new Point(265.11627, 43.023285);
    circleArray[169] = new Point(251.1628, 90.69769);
    circleArray[170] = new Point(231.39536, 136.04654);
    circleArray[171] = new Point(205.81396, 174.41861);
    circleArray[172] = new Point(172.09305, 206.97675);
    circleArray[173] = new Point(133.72095, 230.23257);
    circleArray[174] = new Point(91.86047, 253.48839);
    circleArray[175] = new Point(47.67444, 266.27908);
    circleArray[176] = new Point(-1.1627808, 270.93024);
    circleArray[177] = new Point(-46.511597, 263.9535);
    circleArray[178] = new Point(-91.86047, 253.48839);
    circleArray[179] = new Point(-133.72089, 233.72095);
    circleArray[180] = new Point(-172.09302, 206.97675);
    circleArray[181] = new Point(-204.65112, 172.09305);
    circleArray[182] = new Point(-231.39532, 134.88373);
    circleArray[183] = new Point(-250.0, 91.86047);
    circleArray[184] = new Point(-262.79065, 50.00003);
    circleArray[185] = new Point(-266.27905, 3.0517578E-5);
    circleArray[186] = new Point(-233.72089, 3.0517578E-5);
    circleArray[187] = new Point(-229.06976, 45.348846);
    circleArray[188] = new Point(-217.44183, 89.53491);
    circleArray[189] = new Point(-194.18604, 132.55817);
    circleArray[190] = new Point(-165.11627, 167.44186);
    circleArray[191] = new Point(-132.5581, 196.51163);
    circleArray[192] = new Point(-89.53485, 217.44186);
    circleArray[193] = new Point(-43.023254, 230.23257);
    circleArray[194] = new Point(1.1628113, 236.04651);
    circleArray[195] = new Point(46.511658, 229.06976);
    circleArray[196] = new Point(89.53491, 216.27908);
    circleArray[197] = new Point(131.39536, 196.51163);
    circleArray[198] = new Point(168.60468, 169.76746);
    circleArray[199] = new Point(195.34885, 133.72095);
    circleArray[200] = new Point(217.44186, 90.69769);
    circleArray[201] = new Point(229.06976, 44.186066);
    circleArray[202] = new Point(195.34885, 43.023285);
    circleArray[203] = new Point(181.39536, 89.53491);
    circleArray[204] = new Point(156.97675, 129.0698);
    circleArray[205] = new Point(124.41861, 159.30234);
    circleArray[206] = new Point(88.3721, 183.72095);
    circleArray[207] = new Point(45.348846, 196.51163);
    circleArray[208] = new Point(3.0517578E-5, 200.0);
    circleArray[209] = new Point(-41.860474, 197.67444);
    circleArray[210] = new Point(-87.20929, 182.55814);
    circleArray[211] = new Point(-125.58136, 160.46512);
    circleArray[212] = new Point(-153.48834, 129.0698);
    circleArray[213] = new Point(-179.06976, 91.86047);
    circleArray[214] = new Point(-193.02325, 46.511658);
    circleArray[215] = new Point(-200.0, 2.325592);
    circleArray[216] = new Point(-166.27905, 1.1628113);
    circleArray[217] = new Point(-160.46509, 45.348846);
    circleArray[218] = new Point(-143.02325, 86.04654);
    circleArray[219] = new Point(-117.44183, 120.93024);
    circleArray[220] = new Point(-81.395325, 147.67444);
    circleArray[221] = new Point(-43.023254, 162.79071);
    circleArray[222] = new Point(3.0517578E-5, 167.44186);
    circleArray[223] = new Point(44.186066, 162.79071);
    circleArray[224] = new Point(84.88373, 145.34885);
    circleArray[225] = new Point(118.604675, 118.604675);
    circleArray[226] = new Point(144.18607, 83.72095);
    circleArray[227] = new Point(160.46512, 44.186066);
    circleArray[228] = new Point(129.0698, 44.186066);
    circleArray[229] = new Point(109.30234, 79.06979);
    circleArray[230] = new Point(79.06979, 110.46512);
    circleArray[231] = new Point(39.534912, 129.0698);
    circleArray[232] = new Point(3.0517578E-5, 134.88373);
    circleArray[233] = new Point(-40.69763, 127.90698);
    circleArray[234] = new Point(-80.232544, 111.62793);
    circleArray[235] = new Point(-106.976746, 82.55817);
    circleArray[236] = new Point(-124.41858, 45.348846);
    circleArray[237] = new Point(-133.72089, 1.1628113);
    circleArray[238] = new Point(-100.0, 2.325592);
    circleArray[239] = new Point(-90.69763, 38.3721);
    circleArray[240] = new Point(-70.93024, 73.25583);
    circleArray[241] = new Point(-37.20929, 95.34885);
    circleArray[242] = new Point(1.1628113, 101.16281);
    circleArray[243] = new Point(37.20932, 94.186066);
    circleArray[244] = new Point(69.767456, 72.09305);
    circleArray[245] = new Point(93.023285, 41.860474);
    circleArray[246] = new Point(58.139557, 36.04654);
    circleArray[247] = new Point(33.720947, 60.46512);
    circleArray[248] = new Point(1.1628113, 70.93024);
    circleArray[249] = new Point(-34.883728, 59.302338);
    circleArray[250] = new Point(-58.139526, 36.04654);
    circleArray[251] = new Point(-66.27905, 3.0517578E-5);
    circleArray[252] = new Point(-27.906982, 19.767456);
    circleArray[253] = new Point(1.1628113, 34.883728);
    circleArray[254] = new Point(30.232574, 19.767456);
    circleArray[255] = new Point(1.1628113, 1.1628113);
    circleArray2[0] = new Point(470.93024, -1.1627808);
    circleArray2[1] = new Point(467.44186, -43.023254);
    circleArray2[2] = new Point(462.7907, -87.20929);
    circleArray2[3] = new Point(451.16278, -129.06976);
    circleArray2[4] = new Point(439.53488, -168.60461);
    circleArray2[5] = new Point(419.76746, -209.3023);
    circleArray2[6] = new Point(398.83722, -250.0);
    circleArray2[7] = new Point(374.4186, -282.5581);
    circleArray2[8] = new Point(347.67444, -313.95343);
    circleArray2[9] = new Point(316.27908, -345.34882);
    circleArray2[10] = new Point(283.72095, -374.41858);
    circleArray2[11] = new Point(247.67442, -398.83716);
    circleArray2[12] = new Point(209.30234, -419.7674);
    circleArray2[13] = new Point(169.76746, -439.53485);
    circleArray2[14] = new Point(129.0698, -449.99994);
    circleArray2[15] = new Point(86.04654, -462.79065);
    circleArray2[16] = new Point(40.697693, -468.6046);
    circleArray2[17] = new Point(1.1628113, -468.6046);
    circleArray2[18] = new Point(-41.860474, -468.6046);
    circleArray2[19] = new Point(-84.88373, -460.4651);
    circleArray2[20] = new Point(-126.74414, -449.99994);
    circleArray2[21] = new Point(-169.7674, -438.37207);
    circleArray2[22] = new Point(-208.13953, -419.7674);
    circleArray2[23] = new Point(-245.34882, -398.83716);
    circleArray2[24] = new Point(-281.39532, -373.2558);
    circleArray2[25] = new Point(-315.11627, -346.5116);
    circleArray2[26] = new Point(-345.34882, -316.27905);
    circleArray2[27] = new Point(-373.2558, -282.5581);
    circleArray2[28] = new Point(-399.99994, -247.67438);
    circleArray2[29] = new Point(-419.7674, -209.3023);
    circleArray2[30] = new Point(-436.04645, -169.7674);
    circleArray2[31] = new Point(-448.83716, -127.90698);
    circleArray2[32] = new Point(-459.3023, -84.88373);
    circleArray2[33] = new Point(-465.11627, -41.860474);
    circleArray2[34] = new Point(-432.5581, -39.53485);
    circleArray2[35] = new Point(-423.2558, -83.72089);
    circleArray2[36] = new Point(-415.11627, -124.41858);
    circleArray2[37] = new Point(-402.32556, -168.60461);
    circleArray2[38] = new Point(-382.5581, -206.97675);
    circleArray2[39] = new Point(-361.62787, -243.02325);
    circleArray2[40] = new Point(-337.2093, -275.58136);
    circleArray2[41] = new Point(-309.3023, -309.3023);
    circleArray2[42] = new Point(-277.90692, -340.69763);
    circleArray2[43] = new Point(-243.02325, -362.79065);
    circleArray2[44] = new Point(-203.48834, -383.7209);
    circleArray2[45] = new Point(-166.27905, -403.48834);
    circleArray2[46] = new Point(-125.58136, -417.44183);
    circleArray2[47] = new Point(-86.04651, -425.58136);
    circleArray2[48] = new Point(-41.860474, -433.7209);
    circleArray2[49] = new Point(1.1628113, -437.2093);
    circleArray2[50] = new Point(44.186066, -434.88367);
    circleArray2[51] = new Point(86.04654, -427.90692);
    circleArray2[52] = new Point(127.90698, -416.27905);
    circleArray2[53] = new Point(167.44186, -402.32556);
    circleArray2[54] = new Point(205.81396, -382.5581);
    circleArray2[55] = new Point(243.02325, -360.4651);
    circleArray2[56] = new Point(276.7442, -336.0465);
    circleArray2[57] = new Point(306.97675, -308.13953);
    circleArray2[58] = new Point(336.0465, -274.41858);
    circleArray2[59] = new Point(361.62793, -240.69763);
    circleArray2[60] = new Point(384.88373, -205.8139);
    circleArray2[61] = new Point(403.48837, -167.44183);
    circleArray2[62] = new Point(416.27908, -125.58136);
    circleArray2[63] = new Point(427.90698, -84.88373);
    circleArray2[64] = new Point(434.88373, -43.023254);
    circleArray2[65] = new Point(437.2093, 3.0517578E-5);
    circleArray2[66] = new Point(402.3256, 3.0517578E-5);
    circleArray2[67] = new Point(397.67444, -41.860474);
    circleArray2[68] = new Point(391.86047, -84.88373);
    circleArray2[69] = new Point(382.55814, -124.41858);
    circleArray2[70] = new Point(367.44186, -163.95349);
    circleArray2[71] = new Point(348.83722, -200.0);
    circleArray2[72] = new Point(326.7442, -237.20929);
    circleArray2[73] = new Point(298.83722, -270.93018);
    circleArray2[74] = new Point(268.60468, -297.67438);
    circleArray2[75] = new Point(236.04651, -325.58136);
    circleArray2[76] = new Point(201.16281, -348.83716);
    circleArray2[77] = new Point(163.95349, -366.27905);
    circleArray2[78] = new Point(123.25583, -381.39532);
    circleArray2[79] = new Point(82.55817, -394.18604);
    circleArray2[80] = new Point(43.023285, -399.99994);
    circleArray2[81] = new Point(1.1628113, -402.32556);
    circleArray2[82] = new Point(-40.69763, -398.83716);
    circleArray2[83] = new Point(-81.395325, -396.5116);
    circleArray2[84] = new Point(-124.41858, -383.7209);
    circleArray2[85] = new Point(-163.95349, -366.27905);
    circleArray2[86] = new Point(-200.0, -347.67438);
    circleArray2[87] = new Point(-238.37207, -325.58136);
    circleArray2[88] = new Point(-267.44183, -298.83716);
    circleArray2[89] = new Point(-297.67438, -268.6046);
    circleArray2[90] = new Point(-324.41858, -236.04651);
    circleArray2[91] = new Point(-347.67438, -200.0);
    circleArray2[92] = new Point(-365.11627, -163.95349);
    circleArray2[93] = new Point(-381.39532, -122.09302);
    circleArray2[94] = new Point(-390.69763, -82.558105);
    circleArray2[95] = new Point(-397.67438, -41.860474);
    circleArray2[96] = new Point(-363.95343, -41.860474);
    circleArray2[97] = new Point(-356.97668, -88.37207);
    circleArray2[98] = new Point(-343.02325, -130.23254);
    circleArray2[99] = new Point(-325.58136, -169.7674);
    circleArray2[100] = new Point(-301.16278, -206.97675);
    circleArray2[101] = new Point(-274.41858, -245.34882);
    circleArray2[102] = new Point(-244.18604, -274.41858);
    circleArray2[103] = new Point(-209.3023, -303.48834);
    circleArray2[104] = new Point(-170.93024, -326.74414);
    circleArray2[105] = new Point(-130.23254, -346.5116);
    circleArray2[106] = new Point(-88.37207, -359.3023);
    circleArray2[107] = new Point(-43.023254, -368.6046);
    circleArray2[108] = new Point(1.1628113, -370.93018);
    circleArray2[109] = new Point(46.511658, -366.27905);
    circleArray2[110] = new Point(88.3721, -358.13953);
    circleArray2[111] = new Point(132.55817, -346.5116);
    circleArray2[112] = new Point(172.09305, -327.90692);
    circleArray2[113] = new Point(210.46512, -303.48834);
    circleArray2[114] = new Point(246.51164, -274.41858);
    circleArray2[115] = new Point(275.58142, -244.18604);
    circleArray2[116] = new Point(304.65118, -208.13953);
    circleArray2[117] = new Point(327.90698, -172.09302);
    circleArray2[118] = new Point(343.02325, -131.39532);
    circleArray2[119] = new Point(358.13953, -88.37207);
    circleArray2[120] = new Point(367.44186, -44.186035);
    circleArray2[121] = new Point(369.76746, -1.1627808);
    circleArray2[122] = new Point(336.0465, 3.0517578E-5);
    circleArray2[123] = new Point(332.55817, -41.860474);
    circleArray2[124] = new Point(324.4186, -86.04651);
    circleArray2[125] = new Point(309.30234, -126.74414);
    circleArray2[126] = new Point(289.5349, -169.7674);
    circleArray2[127] = new Point(265.11627, -203.48834);
    circleArray2[128] = new Point(237.20932, -237.20929);
    circleArray2[129] = new Point(204.65118, -266.27905);
    circleArray2[130] = new Point(169.76746, -289.53485);
    circleArray2[131] = new Point(129.0698, -308.13953);
    circleArray2[132] = new Point(86.04654, -323.2558);
    circleArray2[133] = new Point(44.186066, -332.5581);
    circleArray2[134] = new Point(1.1628113, -336.0465);
    circleArray2[135] = new Point(-44.186035, -333.7209);
    circleArray2[136] = new Point(-87.20929, -324.41858);
    circleArray2[137] = new Point(-127.90698, -309.3023);
    circleArray2[138] = new Point(-167.44183, -289.53485);
    circleArray2[139] = new Point(-203.48834, -266.27905);
    circleArray2[140] = new Point(-233.72089, -237.20929);
    circleArray2[141] = new Point(-263.9535, -203.48834);
    circleArray2[142] = new Point(-288.37207, -168.60461);
    circleArray2[143] = new Point(-308.13953, -129.06976);
    circleArray2[144] = new Point(-322.09302, -87.20929);
    circleArray2[145] = new Point(-331.39532, -44.186035);
    circleArray2[146] = new Point(-298.83716, -41.860474);
    circleArray2[147] = new Point(-288.37207, -83.72089);
    circleArray2[148] = new Point(-274.41858, -124.41858);
    circleArray2[149] = new Point(-252.32556, -161.62787);
    circleArray2[150] = new Point(-227.90692, -197.67438);
    circleArray2[151] = new Point(-197.67438, -227.90692);
    circleArray2[152] = new Point(-162.79065, -253.48834);
    circleArray2[153] = new Point(-125.58136, -274.41858);
    circleArray2[154] = new Point(-84.88373, -289.53485);
    circleArray2[155] = new Point(-40.69763, -297.67438);
    circleArray2[156] = new Point(1.1628113, -302.32556);
    circleArray2[157] = new Point(43.023285, -297.67438);
    circleArray2[158] = new Point(86.04654, -289.53485);
    circleArray2[159] = new Point(126.7442, -273.2558);
    circleArray2[160] = new Point(165.1163, -251.16278);
    circleArray2[161] = new Point(200.0, -225.58136);
    circleArray2[162] = new Point(229.06976, -196.5116);
    circleArray2[163] = new Point(255.81396, -159.3023);
    circleArray2[164] = new Point(274.4186, -122.09302);
    circleArray2[165] = new Point(293.02325, -82.558105);
    circleArray2[166] = new Point(300.0, -39.53485);
    circleArray2[167] = new Point(303.48837, 1.1628113);
    circleArray2[168] = new Point(270.93024, 2.325592);
    circleArray2[169] = new Point(263.9535, -46.511597);
    circleArray2[170] = new Point(252.32559, -89.53485);
    circleArray2[171] = new Point(234.88373, -133.72089);
    circleArray2[172] = new Point(205.81396, -170.93024);
    circleArray2[173] = new Point(172.09305, -203.48834);
    circleArray2[174] = new Point(136.04654, -230.23254);
    circleArray2[175] = new Point(91.86047, -250.0);
    circleArray2[176] = new Point(46.511658, -263.9535);
    circleArray2[177] = new Point(-1.1627808, -266.27905);
    circleArray2[178] = new Point(-44.186035, -261.62787);
    circleArray2[179] = new Point(-90.69763, -251.16278);
    circleArray2[180] = new Point(-133.72089, -231.39532);
    circleArray2[181] = new Point(-170.93024, -203.48834);
    circleArray2[182] = new Point(-204.65112, -170.93024);
    circleArray2[183] = new Point(-231.39532, -134.88373);
    circleArray2[184] = new Point(-251.16278, -89.53485);
    circleArray2[185] = new Point(-262.79065, -47.674377);
    circleArray2[186] = new Point(-229.06976, -44.186035);
    circleArray2[187] = new Point(-215.11627, -88.37207);
    circleArray2[188] = new Point(-194.18604, -129.06976);
    circleArray2[189] = new Point(-165.11627, -163.95349);
    circleArray2[190] = new Point(-130.23254, -194.18604);
    circleArray2[191] = new Point(-88.37207, -217.44183);
    circleArray2[192] = new Point(-45.348816, -232.5581);
    circleArray2[193] = new Point(3.0517578E-5, -234.88367);
    circleArray2[194] = new Point(46.511658, -232.5581);
    circleArray2[195] = new Point(90.69769, -216.27905);
    circleArray2[196] = new Point(131.39536, -193.02325);
    circleArray2[197] = new Point(168.60468, -163.95349);
    circleArray2[198] = new Point(195.34885, -127.90698);
    circleArray2[199] = new Point(216.27908, -89.53485);
    circleArray2[200] = new Point(229.06976, -46.511597);
    circleArray2[201] = new Point(237.20932, 3.0517578E-5);
    circleArray2[202] = new Point(201.16281, -1.1627808);
    circleArray2[203] = new Point(194.18607, -41.860474);
    circleArray2[204] = new Point(180.23257, -86.04651);
    circleArray2[205] = new Point(158.13956, -123.2558);
    circleArray2[206] = new Point(125.58142, -154.65112);
    circleArray2[207] = new Point(89.53491, -177.90698);
    circleArray2[208] = new Point(45.348846, -195.34882);
    circleArray2[209] = new Point(2.325592, -200.0);
    circleArray2[210] = new Point(-44.186035, -193.02325);
    circleArray2[211] = new Point(-88.37207, -179.06976);
    circleArray2[212] = new Point(-125.58136, -155.8139);
    circleArray2[213] = new Point(-155.8139, -125.58136);
    circleArray2[214] = new Point(-180.23254, -86.04651);
    circleArray2[215] = new Point(-195.34882, -45.348816);
    circleArray2[216] = new Point(-161.62787, -40.69763);
    circleArray2[217] = new Point(-144.18604, -83.72089);
    circleArray2[218] = new Point(-119.767395, -118.604614);
    circleArray2[219] = new Point(-84.88373, -147.67438);
    circleArray2[220] = new Point(-44.186035, -161.62787);
    circleArray2[221] = new Point(-2.3255615, -166.27905);
    circleArray2[222] = new Point(44.186066, -160.46509);
    circleArray2[223] = new Point(83.72095, -145.34882);
    circleArray2[224] = new Point(118.604675, -118.604614);
    circleArray2[225] = new Point(145.34885, -84.88373);
    circleArray2[226] = new Point(161.62793, -43.023254);
    circleArray2[227] = new Point(168.60468, 3.0517578E-5);
    circleArray2[228] = new Point(133.72095, 2.325592);
    circleArray2[229] = new Point(125.58142, -40.69763);
    circleArray2[230] = new Point(108.13956, -77.90698);
    circleArray2[231] = new Point(80.232574, -108.13953);
    circleArray2[232] = new Point(43.023285, -127.90698);
    circleArray2[233] = new Point(2.325592, -132.5581);
    circleArray2[234] = new Point(-40.69763, -126.74414);
    circleArray2[235] = new Point(-77.90698, -105.8139);
    circleArray2[236] = new Point(-105.8139, -76.74414);
    circleArray2[237] = new Point(-126.74414, -39.53485);
    circleArray2[238] = new Point(-91.86047, -38.37207);
    circleArray2[239] = new Point(-69.767395, -70.93024);
    circleArray2[240] = new Point(-37.20929, -93.023254);
    circleArray2[241] = new Point(1.1628113, -102.32556);
    circleArray2[242] = new Point(40.697693, -93.023254);
    circleArray2[243] = new Point(72.09305, -69.767395);
    circleArray2[244] = new Point(94.186066, -38.37207);
    circleArray2[245] = new Point(100.0, -1.1627808);
    circleArray2[246] = new Point(67.441864, 3.0517578E-5);
    circleArray2[247] = new Point(58.139557, -33.720886);
    circleArray2[248] = new Point(33.720947, -56.976746);
    circleArray2[249] = new Point(1.1628113, -66.27905);
    circleArray2[250] = new Point(-32.558105, -58.139526);
    circleArray2[251] = new Point(-56.976746, -32.558105);
    circleArray2[252] = new Point(-30.232544, -13.953491);
    circleArray2[253] = new Point(3.4884033, -32.558105);
    circleArray2[254] = new Point(30.232574, -15.116272);
  }
}


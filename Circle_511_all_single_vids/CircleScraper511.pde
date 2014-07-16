int NumLEDs = 256;
int NumLEDs2 = 255;

class CircleScraper {

  Point[] circleArray;  // array that holds the offsets to each pixel
  Point[] circleArray2;  // array that holds the offsets to each pixel
  
  class Point {
    float x;
    float y; 

    Point(float x, float y) {
      this.x = x;
      this.y = y;
    }

    Point add(Point b) {
      return new Point(this.x + b.x, this.y+b.y);
    }

    Point scale(float s) {
      return new Point(int(this.x * s), int(this.y * s));
    }

    Point invertX() {
      return new Point(-(x), y);
    }
    Point invertY() {
      return new Point(x, -(y));
    }

    @Override public String toString() {
      return new String(" "+x+","+y);
    }
  };


  Point   position;     // the scrape location for the center of the circle
  float   size;         // scale factor

  CircleScraper(float x, float y, float size, float rotation) {
    circleArray= new Point[NumLEDs];
    circleArray2= new Point[NumLEDs2];
    initCircleArray();

    this.size = size;
    this.position = new Point(x, y);

    // We want to save the time taken to do the matrix manipulation during the scrape,
    // so we'll pre-transform and pre-translate the array here.

    for (int i=0; i<NumLEDs; i++) 
    {
      circleArray[i] = circleArray[i].scale(size);
      //circleArray[i] = circleArray[i].invertX();
      //circleArray[i] = circleArray[i].invertY();
      circleArray[i] = circleArray[i].add(position);
    }
    
    for (int i=0; i<NumLEDs2; i++) 
    {
      circleArray2[i] = circleArray2[i].scale(size);
      //circleArray[i] = circleArray[i].invertX();
      //circleArray[i] = circleArray[i].invertY();
      circleArray2[i] = circleArray2[i].add(position);
    }
    
  }
  
  void scrapeStrip2(Strip s, PImage pi) {
    // This is easy now we're all initialized up.
    int actualLength=NumLEDs2;
    if (s.getLength() < NumLEDs2) {
      actualLength=s.getLength();
      println("Something's wrong.  These strips are supposed to be " + NumLEDs2 + " pix long, but are only "+s.getLength()+" long.");
    }

    colorMode(HSB, 255);

    // The pixels actually go in reverse order as they're fed from the edge.
    for (int i=0; i<actualLength; i++) {
//      int n1 = pi.get((int)circleArray[i].y + 1, (int)circleArray[i].x - 1);
//      int n2 = pi.get((int)circleArray[i].y + 1, (int)circleArray[i].x);
//      int n3 = pi.get((int)circleArray[i].y + 1, (int)circleArray[i].x + 1);
//      int n4 = pi.get((int)circleArray[i].y, (int)circleArray[i].x - 1);
      int sample = pi.get((int)circleArray2[i].y, (int)circleArray2[i].x);
//      int n6 = pi.get((int)circleArray[i].y, (int)circleArray[i].x + 1);
//      int n7 = pi.get((int)circleArray[i].y - 1, (int)circleArray[i].x - 1);
//      int n8 = pi.get((int)circleArray[i].y - 1, (int)circleArray[i].x);
//      int n9 = pi.get((int)circleArray[i].y - 1, (int)circleArray[i].x + 1);
      
//int average = (n1+n2+n3+n4+sample+n6+n7+n8+n9)/9;
//int average = (n2+n4+sample+n6+n8)/5;
// println("sample: " + sample + " LED index: " + i + " actual length: " + actualLength);

//      if (i==testPixel) {
//        sample = #000000;
//      }
      
//      float brightnessModSample = color(hue(sample), saturation(sample), floor(brightness(sample) * globalAlpha));
//      s.setPixel((int)brightnessModSample, i);
      s.setPixel(sample, i);

//      rectMode(CENTER);
//      //fill(255, i, i);
//      fill(sample);
//      stroke(0);
//      rect(circleArray2[i].y, circleArray2[i].x, 20, 20);
    }
//    if ((frameCount % 30) == 0) {
//      testPixel++;
//      if (testPixel == actualLength) {
//        testPixel = 0;
//      }
//    }
  }

  void scrapeStrip(Strip s, PImage pi) {
    // This is easy now we're all initialized up.
    int actualLength=NumLEDs;
    //println("scraping strip");
    if (s.getLength() < NumLEDs) {
      actualLength=s.getLength();
      println("Something's wrong.  These strips are supposed to be " + NumLEDs + " pix long, but are only "+s.getLength()+" long.");
    }

    colorMode(HSB, 255);
    // The pixels actually go in reverse order as they're fed from the edge.
    for (int i=0; i<actualLength; i++) {
//      int n1 = pi.get((int)circleArray[i].y + 1, (int)circleArray[i].x - 1);
//      int n2 = pi.get((int)circleArray[i].y + 1, (int)circleArray[i].x);
//      int n3 = pi.get((int)circleArray[i].y + 1, (int)circleArray[i].x + 1);
//      int n4 = pi.get((int)circleArray[i].y, (int)circleArray[i].x - 1);
      int sample = pi.get((int)circleArray[i].y, (int)circleArray[i].x);
//      int n6 = pi.get((int)circleArray[i].y, (int)circleArray[i].x + 1);
//      int n7 = pi.get((int)circleArray[i].y - 1, (int)circleArray[i].x - 1);
//      int n8 = pi.get((int)circleArray[i].y - 1, (int)circleArray[i].x);
//      int n9 = pi.get((int)circleArray[i].y - 1, (int)circleArray[i].x + 1);
      
      //int average = (n1+n2+n3+n4+sample+n6+n7+n8+n9)/9;
      //int average = (n2+n4+sample+n6+n8)/5;
      // println("sample: " + sample + " LED index: " + i + " actual length: " + actualLength);

//      if (i==testPixel) {
//        sample = #000000;
//      }
      
//      float brightnessModSample = color(hue(sample), saturation(sample), floor(brightness(sample) * globalAlpha));
//      s.setPixel((int)brightnessModSample, i);
      s.setPixel(sample, i);

//      rectMode(CENTER);
//      //fill(255, i, i);
//      fill(sample);
//      stroke(0);
//      rect(circleArray[i].y, circleArray[i].x, 20, 20);
    }
//    if ((frameCount % 30) == 0) {
//      testPixel++;
//      if (testPixel == actualLength) {
//        testPixel = 0;
//      }
//    }
  }



  

  void initCircleArray() {
    // This is pretty gross, so let's remove it from the constructor. - jls
    // These offsets extracted from the circle generator.


circleArray[0] = new Point(29.0,392.0);
circleArray[1] = new Point(34.0,355.0);
circleArray[2] = new Point(40.0,319.0);
circleArray[3] = new Point(53.0,282.0);
circleArray[4] = new Point(68.0,249.0);
circleArray[5] = new Point(85.0,217.0);
circleArray[6] = new Point(108.0,186.0);
circleArray[7] = new Point(132.0,157.0);
circleArray[8] = new Point(159.0,130.0);
circleArray[9] = new Point(186.0,107.0);
circleArray[10] = new Point(218.0,86.0);
circleArray[11] = new Point(251.0,68.0);
circleArray[12] = new Point(286.0,52.0);
circleArray[13] = new Point(319.0,39.0);
circleArray[14] = new Point(355.0,34.0);
circleArray[15] = new Point(394.0,26.0);
circleArray[16] = new Point(429.0,25.0);
circleArray[17] = new Point(466.0,27.0);
circleArray[18] = new Point(504.0,32.0);
circleArray[19] = new Point(539.0,41.0);
circleArray[20] = new Point(574.0,55.0);
circleArray[21] = new Point(609.0,68.0);
circleArray[22] = new Point(642.0,87.0);
circleArray[23] = new Point(675.0,108.0);
circleArray[24] = new Point(701.0,132.0);
circleArray[25] = new Point(727.0,160.0);
circleArray[26] = new Point(751.0,186.0);
circleArray[27] = new Point(774.0,216.0);
circleArray[28] = new Point(791.0,250.0);
circleArray[29] = new Point(805.0,285.0);
circleArray[30] = new Point(817.0,319.0);
circleArray[31] = new Point(826.0,355.0);
circleArray[32] = new Point(832.0,393.0);
circleArray[33] = new Point(833.0,431.0);
circleArray[34] = new Point(805.0,432.0);
circleArray[35] = new Point(802.0,395.0);
circleArray[36] = new Point(796.0,357.0);
circleArray[37] = new Point(788.0,322.0);
circleArray[38] = new Point(775.0,284.0);
circleArray[39] = new Point(760.0,254.0);
circleArray[40] = new Point(741.0,221.0);
circleArray[41] = new Point(719.0,193.0);
circleArray[42] = new Point(694.0,164.0);
circleArray[43] = new Point(668.0,139.0);
circleArray[44] = new Point(636.0,116.0);
circleArray[45] = new Point(607.0,99.0);
circleArray[46] = new Point(574.0,83.0);
circleArray[47] = new Point(538.0,71.0);
circleArray[48] = new Point(501.0,63.0);
circleArray[49] = new Point(467.0,57.0);
circleArray[50] = new Point(430.0,55.0);
circleArray[51] = new Point(394.0,58.0);
circleArray[52] = new Point(356.0,62.0);
circleArray[53] = new Point(321.0,72.0);
circleArray[54] = new Point(288.0,83.0);
circleArray[55] = new Point(254.0,100.0);
circleArray[56] = new Point(222.0,117.0);
circleArray[57] = new Point(194.0,140.0);
circleArray[58] = new Point(167.0,164.0);
circleArray[59] = new Point(141.0,192.0);
circleArray[60] = new Point(117.0,220.0);
circleArray[61] = new Point(99.0,252.0);
circleArray[62] = new Point(84.0,286.0);
circleArray[63] = new Point(71.0,321.0);
circleArray[64] = new Point(64.0,357.0);
circleArray[65] = new Point(58.0,394.0);
circleArray[66] = new Point(87.0,394.0);
circleArray[67] = new Point(92.0,357.0);
circleArray[68] = new Point(101.0,323.0);
circleArray[69] = new Point(116.0,288.0);
circleArray[70] = new Point(131.0,257.0);
circleArray[71] = new Point(151.0,227.0);
circleArray[72] = new Point(174.0,197.0);
circleArray[73] = new Point(199.0,171.0);
circleArray[74] = new Point(228.0,151.0);
circleArray[75] = new Point(257.0,131.0);
circleArray[76] = new Point(290.0,114.0);
circleArray[77] = new Point(323.0,101.0);
circleArray[78] = new Point(357.0,90.0);
circleArray[79] = new Point(393.0,86.0);
circleArray[80] = new Point(428.0,84.0);
circleArray[81] = new Point(467.0,87.0);
circleArray[82] = new Point(501.0,92.0);
circleArray[83] = new Point(538.0,102.0);
circleArray[84] = new Point(571.0,114.0);
circleArray[85] = new Point(602.0,130.0);
circleArray[86] = new Point(633.0,151.0);
circleArray[87] = new Point(660.0,171.0);
circleArray[88] = new Point(685.0,199.0);
circleArray[89] = new Point(707.0,225.0);
circleArray[90] = new Point(727.0,257.0);
circleArray[91] = new Point(745.0,289.0);
circleArray[92] = new Point(759.0,323.0);
circleArray[93] = new Point(766.0,356.0);
circleArray[94] = new Point(772.0,394.0);
circleArray[95] = new Point(775.0,431.0);
circleArray[96] = new Point(746.0,429.0);
circleArray[97] = new Point(744.0,391.0);
circleArray[98] = new Point(736.0,353.0);
circleArray[99] = new Point(725.0,317.0);
circleArray[100] = new Point(711.0,282.0);
circleArray[101] = new Point(689.0,247.0);
circleArray[102] = new Point(666.0,219.0);
circleArray[103] = new Point(641.0,192.0);
circleArray[104] = new Point(610.0,169.0);
circleArray[105] = new Point(576.0,148.0);
circleArray[106] = new Point(541.0,132.0);
circleArray[107] = new Point(504.0,122.0);
circleArray[108] = new Point(468.0,117.0);
circleArray[109] = new Point(429.0,112.0);
circleArray[110] = new Point(393.0,115.0);
circleArray[111] = new Point(355.0,122.0);
circleArray[112] = new Point(318.0,135.0);
circleArray[113] = new Point(282.0,147.0);
circleArray[114] = new Point(249.0,168.0);
circleArray[115] = new Point(220.0,192.0);
circleArray[116] = new Point(192.0,219.0);
circleArray[117] = new Point(170.0,250.0);
circleArray[118] = new Point(150.0,281.0);
circleArray[119] = new Point(134.0,317.0);
circleArray[120] = new Point(122.0,353.0);
circleArray[121] = new Point(117.0,391.0);
circleArray[122] = new Point(145.0,393.0);
circleArray[123] = new Point(151.0,354.0);
circleArray[124] = new Point(164.0,320.0);
circleArray[125] = new Point(179.0,285.0);
circleArray[126] = new Point(200.0,253.0);
circleArray[127] = new Point(226.0,225.0);
circleArray[128] = new Point(255.0,201.0);
circleArray[129] = new Point(287.0,179.0);
circleArray[130] = new Point(320.0,163.0);
circleArray[131] = new Point(357.0,150.0);
circleArray[132] = new Point(391.0,141.0);
circleArray[133] = new Point(430.0,140.0);
circleArray[134] = new Point(467.0,142.0);
circleArray[135] = new Point(505.0,150.0);
circleArray[136] = new Point(539.0,161.0);
circleArray[137] = new Point(573.0,178.0);
circleArray[138] = new Point(603.0,201.0);
circleArray[139] = new Point(633.0,225.0);
circleArray[140] = new Point(656.0,253.0);
circleArray[141] = new Point(678.0,283.0);
circleArray[142] = new Point(696.0,317.0);
circleArray[143] = new Point(707.0,354.0);
circleArray[144] = new Point(717.0,392.0);
circleArray[145] = new Point(720.0,430.0);
circleArray[146] = new Point(687.0,427.0);
circleArray[147] = new Point(685.0,391.0);
circleArray[148] = new Point(677.0,356.0);
circleArray[149] = new Point(664.0,321.0);
circleArray[150] = new Point(647.0,289.0);
circleArray[151] = new Point(623.0,259.0);
circleArray[152] = new Point(598.0,234.0);
circleArray[153] = new Point(570.0,212.0);
circleArray[154] = new Point(537.0,193.0);
circleArray[155] = new Point(502.0,181.0);
circleArray[156] = new Point(465.0,173.0);
circleArray[157] = new Point(428.0,170.0);
circleArray[158] = new Point(392.0,174.0);
circleArray[159] = new Point(356.0,181.0);
circleArray[160] = new Point(323.0,193.0);
circleArray[161] = new Point(291.0,211.0);
circleArray[162] = new Point(261.0,235.0);
circleArray[163] = new Point(235.0,259.0);
circleArray[164] = new Point(212.0,288.0);
circleArray[165] = new Point(193.0,321.0);
circleArray[166] = new Point(180.0,357.0);
circleArray[167] = new Point(176.0,394.0);
circleArray[168] = new Point(202.0,393.0);
circleArray[169] = new Point(214.0,352.0);
circleArray[170] = new Point(231.0,313.0);
circleArray[171] = new Point(253.0,280.0);
circleArray[172] = new Point(282.0,252.0);
circleArray[173] = new Point(315.0,232.0);
circleArray[174] = new Point(351.0,212.0);
circleArray[175] = new Point(389.0,201.0);
circleArray[176] = new Point(431.0,197.0);
circleArray[177] = new Point(470.0,203.0);
circleArray[178] = new Point(509.0,212.0);
circleArray[179] = new Point(545.0,229.0);
circleArray[180] = new Point(578.0,252.0);
circleArray[181] = new Point(606.0,282.0);
circleArray[182] = new Point(629.0,314.0);
circleArray[183] = new Point(645.0,351.0);
circleArray[184] = new Point(656.0,387.0);
circleArray[185] = new Point(659.0,430.0);
circleArray[186] = new Point(631.0,430.0);
circleArray[187] = new Point(627.0,391.0);
circleArray[188] = new Point(617.0,353.0);
circleArray[189] = new Point(597.0,316.0);
circleArray[190] = new Point(572.0,286.0);
circleArray[191] = new Point(544.0,261.0);
circleArray[192] = new Point(507.0,243.0);
circleArray[193] = new Point(467.0,232.0);
circleArray[194] = new Point(429.0,227.0);
circleArray[195] = new Point(390.0,233.0);
circleArray[196] = new Point(353.0,244.0);
circleArray[197] = new Point(317.0,261.0);
circleArray[198] = new Point(285.0,284.0);
circleArray[199] = new Point(262.0,315.0);
circleArray[200] = new Point(243.0,352.0);
circleArray[201] = new Point(233.0,392.0);
circleArray[202] = new Point(262.0,393.0);
circleArray[203] = new Point(274.0,353.0);
circleArray[204] = new Point(295.0,319.0);
circleArray[205] = new Point(323.0,293.0);
circleArray[206] = new Point(354.0,272.0);
circleArray[207] = new Point(391.0,261.0);
circleArray[208] = new Point(430.0,258.0);
circleArray[209] = new Point(466.0,260.0);
circleArray[210] = new Point(505.0,273.0);
circleArray[211] = new Point(538.0,292.0);
circleArray[212] = new Point(562.0,319.0);
circleArray[213] = new Point(584.0,351.0);
circleArray[214] = new Point(596.0,390.0);
circleArray[215] = new Point(602.0,428.0);
circleArray[216] = new Point(573.0,429.0);
circleArray[217] = new Point(568.0,391.0);
circleArray[218] = new Point(553.0,356.0);
circleArray[219] = new Point(531.0,326.0);
circleArray[220] = new Point(500.0,303.0);
circleArray[221] = new Point(467.0,290.0);
circleArray[222] = new Point(430.0,286.0);
circleArray[223] = new Point(392.0,290.0);
circleArray[224] = new Point(357.0,305.0);
circleArray[225] = new Point(328.0,328.0);
circleArray[226] = new Point(306.0,358.0);
circleArray[227] = new Point(292.0,392.0);
circleArray[228] = new Point(319.0,392.0);
circleArray[229] = new Point(336.0,362.0);
circleArray[230] = new Point(362.0,335.0);
circleArray[231] = new Point(396.0,319.0);
circleArray[232] = new Point(430.0,314.0);
circleArray[233] = new Point(465.0,320.0);
circleArray[234] = new Point(499.0,334.0);
circleArray[235] = new Point(522.0,359.0);
circleArray[236] = new Point(537.0,391.0);
circleArray[237] = new Point(545.0,429.0);
circleArray[238] = new Point(516.0,428.0);
circleArray[239] = new Point(508.0,397.0);
circleArray[240] = new Point(491.0,367.0);
circleArray[241] = new Point(462.0,348.0);
circleArray[242] = new Point(429.0,343.0);
circleArray[243] = new Point(398.0,349.0);
circleArray[244] = new Point(370.0,368.0);
circleArray[245] = new Point(350.0,394.0);
circleArray[246] = new Point(380.0,399.0);
circleArray[247] = new Point(401.0,378.0);
circleArray[248] = new Point(429.0,369.0);
circleArray[249] = new Point(460.0,379.0);
circleArray[250] = new Point(480.0,399.0);
circleArray[251] = new Point(487.0,430.0);
circleArray[252] = new Point(454.0,413.0);
circleArray[253] = new Point(429.0,400.0);
circleArray[254] = new Point(404.0,413.0);
circleArray[255] = new Point(429.0,429.0);


circleArray2[0] = new Point(25.0,431.0);
circleArray2[1] = new Point(28.0,467.0);
circleArray2[2] = new Point(32.0,505.0);
circleArray2[3] = new Point(42.0,541.0);
circleArray2[4] = new Point(52.0,575.0);
circleArray2[5] = new Point(69.0,610.0);
circleArray2[6] = new Point(87.0,645.0);
circleArray2[7] = new Point(108.0,673.0);
circleArray2[8] = new Point(131.0,700.0);
circleArray2[9] = new Point(158.0,727.0);
circleArray2[10] = new Point(186.0,752.0);
circleArray2[11] = new Point(217.0,773.0);
circleArray2[12] = new Point(250.0,791.0);
circleArray2[13] = new Point(284.0,808.0);
circleArray2[14] = new Point(319.0,817.0);
circleArray2[15] = new Point(356.0,828.0);
circleArray2[16] = new Point(395.0,833.0);
circleArray2[17] = new Point(429.0,833.0);
circleArray2[18] = new Point(466.0,833.0);
circleArray2[19] = new Point(503.0,826.0);
circleArray2[20] = new Point(539.0,817.0);
circleArray2[21] = new Point(576.0,807.0);
circleArray2[22] = new Point(609.0,791.0);
circleArray2[23] = new Point(641.0,773.0);
circleArray2[24] = new Point(672.0,751.0);
circleArray2[25] = new Point(701.0,728.0);
circleArray2[26] = new Point(727.0,702.0);
circleArray2[27] = new Point(751.0,673.0);
circleArray2[28] = new Point(774.0,643.0);
circleArray2[29] = new Point(791.0,610.0);
circleArray2[30] = new Point(805.0,576.0);
circleArray2[31] = new Point(816.0,540.0);
circleArray2[32] = new Point(825.0,503.0);
circleArray2[33] = new Point(830.0,466.0);
circleArray2[34] = new Point(802.0,464.0);
circleArray2[35] = new Point(794.0,502.0);
circleArray2[36] = new Point(787.0,537.0);
circleArray2[37] = new Point(776.0,575.0);
circleArray2[38] = new Point(759.0,608.0);
circleArray2[39] = new Point(741.0,639.0);
circleArray2[40] = new Point(720.0,667.0);
circleArray2[41] = new Point(696.0,696.0);
circleArray2[42] = new Point(669.0,723.0);
circleArray2[43] = new Point(639.0,742.0);
circleArray2[44] = new Point(605.0,760.0);
circleArray2[45] = new Point(573.0,777.0);
circleArray2[46] = new Point(538.0,789.0);
circleArray2[47] = new Point(504.0,796.0);
circleArray2[48] = new Point(466.0,803.0);
circleArray2[49] = new Point(429.0,806.0);
circleArray2[50] = new Point(392.0,804.0);
circleArray2[51] = new Point(356.0,798.0);
circleArray2[52] = new Point(320.0,788.0);
circleArray2[53] = new Point(286.0,776.0);
circleArray2[54] = new Point(253.0,759.0);
circleArray2[55] = new Point(221.0,740.0);
circleArray2[56] = new Point(192.0,719.0);
circleArray2[57] = new Point(166.0,695.0);
circleArray2[58] = new Point(141.0,666.0);
circleArray2[59] = new Point(119.0,637.0);
circleArray2[60] = new Point(99.0,607.0);
circleArray2[61] = new Point(83.0,574.0);
circleArray2[62] = new Point(72.0,538.0);
circleArray2[63] = new Point(62.0,503.0);
circleArray2[64] = new Point(56.0,467.0);
circleArray2[65] = new Point(54.0,430.0);
circleArray2[66] = new Point(84.0,430.0);
circleArray2[67] = new Point(88.0,466.0);
circleArray2[68] = new Point(93.0,503.0);
circleArray2[69] = new Point(101.0,537.0);
circleArray2[70] = new Point(114.0,571.0);
circleArray2[71] = new Point(130.0,602.0);
circleArray2[72] = new Point(149.0,634.0);
circleArray2[73] = new Point(173.0,663.0);
circleArray2[74] = new Point(199.0,686.0);
circleArray2[75] = new Point(227.0,710.0);
circleArray2[76] = new Point(257.0,730.0);
circleArray2[77] = new Point(289.0,745.0);
circleArray2[78] = new Point(324.0,758.0);
circleArray2[79] = new Point(359.0,769.0);
circleArray2[80] = new Point(393.0,774.0);
circleArray2[81] = new Point(429.0,776.0);
circleArray2[82] = new Point(465.0,773.0);
circleArray2[83] = new Point(500.0,771.0);
circleArray2[84] = new Point(537.0,760.0);
circleArray2[85] = new Point(571.0,745.0);
circleArray2[86] = new Point(602.0,729.0);
circleArray2[87] = new Point(635.0,710.0);
circleArray2[88] = new Point(660.0,687.0);
circleArray2[89] = new Point(686.0,661.0);
circleArray2[90] = new Point(709.0,633.0);
circleArray2[91] = new Point(729.0,602.0);
circleArray2[92] = new Point(744.0,571.0);
circleArray2[93] = new Point(758.0,535.0);
circleArray2[94] = new Point(766.0,501.0);
circleArray2[95] = new Point(772.0,466.0);
circleArray2[96] = new Point(743.0,466.0);
circleArray2[97] = new Point(737.0,506.0);
circleArray2[98] = new Point(725.0,542.0);
circleArray2[99] = new Point(710.0,576.0);
circleArray2[100] = new Point(689.0,608.0);
circleArray2[101] = new Point(666.0,641.0);
circleArray2[102] = new Point(640.0,666.0);
circleArray2[103] = new Point(610.0,691.0);
circleArray2[104] = new Point(577.0,711.0);
circleArray2[105] = new Point(542.0,728.0);
circleArray2[106] = new Point(506.0,739.0);
circleArray2[107] = new Point(467.0,747.0);
circleArray2[108] = new Point(429.0,749.0);
circleArray2[109] = new Point(390.0,745.0);
circleArray2[110] = new Point(354.0,738.0);
circleArray2[111] = new Point(316.0,728.0);
circleArray2[112] = new Point(282.0,712.0);
circleArray2[113] = new Point(249.0,691.0);
circleArray2[114] = new Point(218.0,666.0);
circleArray2[115] = new Point(193.0,640.0);
circleArray2[116] = new Point(168.0,609.0);
circleArray2[117] = new Point(148.0,578.0);
circleArray2[118] = new Point(135.0,543.0);
circleArray2[119] = new Point(122.0,506.0);
circleArray2[120] = new Point(114.0,468.0);
circleArray2[121] = new Point(112.0,431.0);
circleArray2[122] = new Point(141.0,430.0);
circleArray2[123] = new Point(144.0,466.0);
circleArray2[124] = new Point(151.0,504.0);
circleArray2[125] = new Point(164.0,539.0);
circleArray2[126] = new Point(181.0,576.0);
circleArray2[127] = new Point(202.0,605.0);
circleArray2[128] = new Point(226.0,634.0);
circleArray2[129] = new Point(254.0,659.0);
circleArray2[130] = new Point(284.0,679.0);
circleArray2[131] = new Point(319.0,695.0);
circleArray2[132] = new Point(356.0,708.0);
circleArray2[133] = new Point(392.0,716.0);
circleArray2[134] = new Point(429.0,719.0);
circleArray2[135] = new Point(468.0,717.0);
circleArray2[136] = new Point(505.0,709.0);
circleArray2[137] = new Point(540.0,696.0);
circleArray2[138] = new Point(574.0,679.0);
circleArray2[139] = new Point(605.0,659.0);
circleArray2[140] = new Point(631.0,634.0);
circleArray2[141] = new Point(657.0,605.0);
circleArray2[142] = new Point(678.0,575.0);
circleArray2[143] = new Point(695.0,541.0);
circleArray2[144] = new Point(707.0,505.0);
circleArray2[145] = new Point(715.0,468.0);
circleArray2[146] = new Point(687.0,466.0);
circleArray2[147] = new Point(678.0,502.0);
circleArray2[148] = new Point(666.0,537.0);
circleArray2[149] = new Point(647.0,569.0);
circleArray2[150] = new Point(626.0,600.0);
circleArray2[151] = new Point(600.0,626.0);
circleArray2[152] = new Point(570.0,648.0);
circleArray2[153] = new Point(538.0,666.0);
circleArray2[154] = new Point(503.0,679.0);
circleArray2[155] = new Point(465.0,686.0);
circleArray2[156] = new Point(429.0,690.0);
circleArray2[157] = new Point(393.0,686.0);
circleArray2[158] = new Point(356.0,679.0);
circleArray2[159] = new Point(321.0,665.0);
circleArray2[160] = new Point(288.0,646.0);
circleArray2[161] = new Point(258.0,624.0);
circleArray2[162] = new Point(233.0,599.0);
circleArray2[163] = new Point(210.0,567.0);
circleArray2[164] = new Point(194.0,535.0);
circleArray2[165] = new Point(178.0,501.0);
circleArray2[166] = new Point(172.0,464.0);
circleArray2[167] = new Point(169.0,429.0);
circleArray2[168] = new Point(197.0,428.0);
circleArray2[169] = new Point(203.0,470.0);
circleArray2[170] = new Point(213.0,507.0);
circleArray2[171] = new Point(228.0,545.0);
circleArray2[172] = new Point(253.0,577.0);
circleArray2[173] = new Point(282.0,605.0);
circleArray2[174] = new Point(313.0,628.0);
circleArray2[175] = new Point(351.0,645.0);
circleArray2[176] = new Point(390.0,657.0);
circleArray2[177] = new Point(431.0,659.0);
circleArray2[178] = new Point(468.0,655.0);
circleArray2[179] = new Point(508.0,646.0);
circleArray2[180] = new Point(545.0,629.0);
circleArray2[181] = new Point(577.0,605.0);
circleArray2[182] = new Point(606.0,577.0);
circleArray2[183] = new Point(629.0,546.0);
circleArray2[184] = new Point(646.0,507.0);
circleArray2[185] = new Point(656.0,471.0);
circleArray2[186] = new Point(627.0,468.0);
circleArray2[187] = new Point(615.0,506.0);
circleArray2[188] = new Point(597.0,541.0);
circleArray2[189] = new Point(572.0,571.0);
circleArray2[190] = new Point(542.0,597.0);
circleArray2[191] = new Point(506.0,617.0);
circleArray2[192] = new Point(469.0,630.0);
circleArray2[193] = new Point(430.0,632.0);
circleArray2[194] = new Point(390.0,630.0);
circleArray2[195] = new Point(352.0,616.0);
circleArray2[196] = new Point(317.0,596.0);
circleArray2[197] = new Point(285.0,571.0);
circleArray2[198] = new Point(262.0,540.0);
circleArray2[199] = new Point(244.0,507.0);
circleArray2[200] = new Point(233.0,470.0);
circleArray2[201] = new Point(226.0,430.0);
circleArray2[202] = new Point(257.0,431.0);
circleArray2[203] = new Point(263.0,466.0);
circleArray2[204] = new Point(275.0,504.0);
circleArray2[205] = new Point(294.0,536.0);
circleArray2[206] = new Point(322.0,563.0);
circleArray2[207] = new Point(353.0,583.0);
circleArray2[208] = new Point(391.0,598.0);
circleArray2[209] = new Point(428.0,602.0);
circleArray2[210] = new Point(468.0,596.0);
circleArray2[211] = new Point(506.0,584.0);
circleArray2[212] = new Point(538.0,564.0);
circleArray2[213] = new Point(564.0,538.0);
circleArray2[214] = new Point(585.0,504.0);
circleArray2[215] = new Point(598.0,469.0);
circleArray2[216] = new Point(569.0,465.0);
circleArray2[217] = new Point(554.0,502.0);
circleArray2[218] = new Point(533.0,532.0);
circleArray2[219] = new Point(503.0,557.0);
circleArray2[220] = new Point(468.0,569.0);
circleArray2[221] = new Point(432.0,573.0);
circleArray2[222] = new Point(392.0,568.0);
circleArray2[223] = new Point(358.0,555.0);
circleArray2[224] = new Point(328.0,532.0);
circleArray2[225] = new Point(305.0,503.0);
circleArray2[226] = new Point(291.0,467.0);
circleArray2[227] = new Point(285.0,430.0);
circleArray2[228] = new Point(315.0,428.0);
circleArray2[229] = new Point(322.0,465.0);
circleArray2[230] = new Point(337.0,497.0);
circleArray2[231] = new Point(361.0,523.0);
circleArray2[232] = new Point(393.0,540.0);
circleArray2[233] = new Point(428.0,544.0);
circleArray2[234] = new Point(465.0,539.0);
circleArray2[235] = new Point(497.0,521.0);
circleArray2[236] = new Point(521.0,496.0);
circleArray2[237] = new Point(539.0,464.0);
circleArray2[238] = new Point(509.0,463.0);
circleArray2[239] = new Point(490.0,491.0);
circleArray2[240] = new Point(462.0,510.0);
circleArray2[241] = new Point(429.0,518.0);
circleArray2[242] = new Point(395.0,510.0);
circleArray2[243] = new Point(368.0,490.0);
circleArray2[244] = new Point(349.0,463.0);
circleArray2[245] = new Point(344.0,431.0);
circleArray2[246] = new Point(372.0,430.0);
circleArray2[247] = new Point(380.0,459.0);
circleArray2[248] = new Point(401.0,479.0);
circleArray2[249] = new Point(429.0,487.0);
circleArray2[250] = new Point(458.0,480.0);
circleArray2[251] = new Point(479.0,458.0);
circleArray2[252] = new Point(456.0,442.0);
circleArray2[253] = new Point(427.0,458.0);
circleArray2[254] = new Point(404.0,443.0);

//    circleArray[0] = new Point(497.0, 41.0);
//    circleArray[1] = new Point(566.0, 49.0);
//    circleArray[2] = new Point(636.0, 67.0);
//    circleArray[3] = new Point(700.0, 94.0);
//    circleArray[4] = new Point(759.0, 130.0);
//    circleArray[5] = new Point(813.0, 177.0);
//    circleArray[6] = new Point(857.0, 227.0);
//    circleArray[7] = new Point(894.0, 286.0);
//    circleArray[8] = new Point(922.0, 349.0);
//    circleArray[9] = new Point(941.0, 419.0);
//    circleArray[10] = new Point(948.0, 487.0);
//    circleArray[11] = new Point(945.0, 557.0);
//    circleArray[12] = new Point(931.0, 627.0);
//    circleArray[13] = new Point(905.0, 689.0);
//    circleArray[14] = new Point(870.0, 750.0);
//    circleArray[15] = new Point(826.0, 804.0);
//    circleArray[16] = new Point(774.0, 851.0);
//    circleArray[17] = new Point(715.0, 888.0);
//    circleArray[18] = new Point(652.0, 918.0);
//    circleArray[19] = new Point(585.0, 937.0);
//    circleArray[20] = new Point(515.0, 944.0);
//    circleArray[21] = new Point(445.0, 939.0);
//    circleArray[22] = new Point(378.0, 925.0);
//    circleArray[23] = new Point(311.0, 899.0);
//    circleArray[24] = new Point(252.0, 864.0);
//    circleArray[25] = new Point(199.0, 821.0);
//    circleArray[26] = new Point(155.0, 767.0);
//    circleArray[27] = new Point(118.0, 705.0);
//    circleArray[28] = new Point(91.0, 642.0);
//    circleArray[29] = new Point(78.0, 574.0);
//    circleArray[30] = new Point(74.0, 503.0);
//    circleArray[31] = new Point(81.0, 433.0);
//    circleArray[32] = new Point(100.0, 368.0);
//    circleArray[33] = new Point(131.0, 305.0);
//    circleArray[34] = new Point(171.0, 246.0);
//    circleArray[35] = new Point(219.0, 198.0);
//    circleArray[36] = new Point(278.0, 159.0);
//    circleArray[37] = new Point(338.0, 126.0);
//    circleArray[38] = new Point(404.0, 107.0);
//    circleArray[39] = new Point(476.0, 98.0);
//    circleArray[40] = new Point(542.0, 101.0);
//    circleArray[41] = new Point(611.0, 117.0);
//    circleArray[42] = new Point(677.0, 144.0);
//    circleArray[43] = new Point(736.0, 181.0);
//    circleArray[44] = new Point(786.0, 229.0);
//    circleArray[45] = new Point(830.0, 285.0);
//    circleArray[46] = new Point(861.0, 347.0);
//    circleArray[47] = new Point(881.0, 414.0);
//    circleArray[48] = new Point(890.0, 485.0);
//    circleArray[49] = new Point(887.0, 553.0);
//    circleArray[50] = new Point(871.0, 621.0);
//    circleArray[51] = new Point(843.0, 684.0);
//    circleArray[52] = new Point(807.0, 742.0);
//    circleArray[53] = new Point(757.0, 794.0);
//    circleArray[54] = new Point(700.0, 835.0);
//    circleArray[55] = new Point(637.0, 863.0);
//    circleArray[56] = new Point(570.0, 882.0);
//    circleArray[57] = new Point(499.0, 885.0);
//    circleArray[58] = new Point(431.0, 879.0);
//    circleArray[59] = new Point(363.0, 860.0);
//    circleArray[60] = new Point(300.0, 827.0);
//    circleArray[61] = new Point(247.0, 784.0);
//    circleArray[62] = new Point(199.0, 730.0);
//    circleArray[63] = new Point(166.0, 672.0);
//    circleArray[64] = new Point(142.0, 604.0);
//    circleArray[65] = new Point(131.0, 540.0);
//    circleArray[66] = new Point(133.0, 468.0);
//    circleArray[67] = new Point(151.0, 398.0);
//    circleArray[68] = new Point(177.0, 335.0);
//    circleArray[69] = new Point(218.0, 279.0);
//    circleArray[70] = new Point(269.0, 231.0);
//    circleArray[71] = new Point(328.0, 194.0);
//    circleArray[72] = new Point(396.0, 168.0);
//    circleArray[73] = new Point(462.0, 158.0);
//    circleArray[74] = new Point(530.0, 158.0);
//    circleArray[75] = new Point(601.0, 174.0);
//    circleArray[76] = new Point(663.0, 203.0);
//    circleArray[77] = new Point(719.0, 243.0);
//    circleArray[78] = new Point(766.0, 292.0);
//    circleArray[79] = new Point(801.0, 354.0);
//    circleArray[80] = new Point(822.0, 418.0);
//    circleArray[81] = new Point(834.0, 489.0);
//    circleArray[82] = new Point(828.0, 558.0);
//    circleArray[83] = new Point(809.0, 626.0);
//    circleArray[84] = new Point(776.0, 686.0);
//    circleArray[85] = new Point(729.0, 741.0);
//    circleArray[86] = new Point(674.0, 781.0);
//    circleArray[87] = new Point(615.0, 812.0);
//    circleArray[88] = new Point(544.0, 830.0);
//    circleArray[89] = new Point(474.0, 829.0);
//    circleArray[90] = new Point(407.0, 813.0);
//    circleArray[91] = new Point(340.0, 785.0);
//    circleArray[92] = new Point(286.0, 744.0);
//    circleArray[93] = new Point(242.0, 690.0);
//    circleArray[94] = new Point(209.0, 628.0);
//    circleArray[95] = new Point(192.0, 562.0);
//    circleArray[96] = new Point(190.0, 495.0);
//    circleArray[97] = new Point(200.0, 425.0);
//    circleArray[98] = new Point(228.0, 364.0);
//    circleArray[99] = new Point(274.0, 307.0);
//    circleArray[100] = new Point(324.0, 262.0);
//    circleArray[101] = new Point(386.0, 233.0);
//    circleArray[102] = new Point(454.0, 217.0);
//    circleArray[103] = new Point(523.0, 217.0);
//    circleArray[104] = new Point(591.0, 233.0);
//    circleArray[105] = new Point(654.0, 265.0);
//    circleArray[106] = new Point(706.0, 313.0);
//    circleArray[107] = new Point(748.0, 372.0);
//    circleArray[108] = new Point(770.0, 436.0);
//    circleArray[109] = new Point(777.0, 504.0);
//    circleArray[110] = new Point(766.0, 575.0);
//    circleArray[111] = new Point(739.0, 637.0);
//    circleArray[112] = new Point(697.0, 692.0);
//    circleArray[113] = new Point(642.0, 736.0);
//    circleArray[114] = new Point(578.0, 763.0);
//    circleArray[115] = new Point(509.0, 773.0);
//    circleArray[116] = new Point(440.0, 764.0);
//    circleArray[117] = new Point(374.0, 734.0);
//    circleArray[118] = new Point(322.0, 697.0);
//    circleArray[119] = new Point(277.0, 639.0);
//    circleArray[120] = new Point(251.0, 570.0);
//    circleArray[121] = new Point(245.0, 506.0);
//    circleArray[122] = new Point(257.0, 441.0);
//    circleArray[123] = new Point(288.0, 378.0);
//    circleArray[124] = new Point(335.0, 324.0);
//    circleArray[125] = new Point(396.0, 287.0);
//    circleArray[126] = new Point(464.0, 273.0);
//    circleArray[127] = new Point(533.0, 273.0);
//    circleArray[128] = new Point(600.0, 298.0);
//    circleArray[129] = new Point(656.0, 340.0);
//    circleArray[130] = new Point(697.0, 398.0);
//    circleArray[131] = new Point(717.0, 463.0);
//    circleArray[132] = new Point(718.0, 531.0);
//    circleArray[133] = new Point(697.0, 596.0);
//    circleArray[134] = new Point(657.0, 653.0);
//    circleArray[135] = new Point(597.0, 695.0);
//    circleArray[136] = new Point(532.0, 715.0);
//    circleArray[137] = new Point(460.0, 710.0);
//    circleArray[138] = new Point(397.0, 684.0);
//    circleArray[139] = new Point(346.0, 637.0);
//    circleArray[140] = new Point(311.0, 576.0);
//    circleArray[141] = new Point(300.0, 510.0);
//    circleArray[142] = new Point(316.0, 444.0);
//    circleArray[143] = new Point(355.0, 383.0);
//    circleArray[144] = new Point(410.0, 343.0);
//    circleArray[145] = new Point(478.0, 327.0);
//    circleArray[146] = new Point(549.0, 338.0);
//    circleArray[147] = new Point(606.0, 371.0);
//    circleArray[148] = new Point(647.0, 432.0);
//    circleArray[149] = new Point(662.0, 498.0);
//    circleArray[150] = new Point(647.0, 565.0);
//    circleArray[151] = new Point(606.0, 620.0);
//    circleArray[152] = new Point(544.0, 653.0);
//    circleArray[153] = new Point(473.0, 654.0);
//    circleArray[154] = new Point(411.0, 623.0);
//    circleArray[155] = new Point(369.0, 568.0);
//    circleArray[156] = new Point(360.0, 500.0);
//    circleArray[157] = new Point(385.0, 437.0);
//    circleArray[158] = new Point(438.0, 394.0);
//    circleArray[159] = new Point(509.0, 387.0);
//    circleArray[160] = new Point(567.0, 416.0);
//    circleArray[161] = new Point(603.0, 476.0);
//    circleArray[162] = new Point(595.0, 545.0);
//    circleArray[163] = new Point(547.0, 590.0);
//    circleArray[164] = new Point(475.0, 597.0);
//    circleArray[165] = new Point(423.0, 550.0);
//    circleArray[166] = new Point(421.0, 486.0);
//    circleArray[167] = new Point(474.0, 443.0);
//    circleArray[168] = new Point(535.0, 466.0);
//    circleArray[169] = new Point(535.0, 529.0);
//    circleArray[170] = new Point(483.0, 510.0);
  }
}



//






//0  29  29
//1  34  34
//2  40  40
//3  53  53
//4  68  68
//5  85  85
//6  108  108
//7  132  132
//8  159  159
//9  186  186
//10  218  218
//11  251  251
//12  286  286
//13  319  319
//14  355  355
//15  394  394
//16  429  429
//17  466  466
//18  504  504
//19  539  539
//20  574  574
//21  609  609
//22  642  642
//23  675  675
//24  701  701
//25  727  727
//26  751  751
//27  774  774
//28  791  791
//29  805  805
//30  817  817
//31  826  826
//32  832  832
//33  833  833
//34  805  805
//35  802  802
//36  796  796
//37  788  788
//38  775  775
//39  760  760
//40  741  741
//41  719  719
//42  694  694
//43  668  668
//44  636  636
//45  607  607
//46  574  574
//47  538  538
//48  501  501
//49  467  467
//50  430  430
//51  394  394
//52  356  356
//53  321  321
//54  288  288
//55  254  254
//56  222  222
//57  194  194
//58  167  167
//59  141  141
//60  117  117
//61  99  99
//62  84  84
//63  71  71
//64  64  64
//65  58  58
//66  87  87
//67  92  92
//68  101  101
//69  116  116
//70  131  131
//71  151  151
//72  174  174
//73  199  199
//74  228  228
//75  257  257
//76  290  290
//77  323  323
//78  357  357
//79  393  393
//80  428  428
//81  467  467
//82  501  501
//83  538  538
//84  571  571
//85  602  602
//86  633  633
//87  660  660
//88  685  685
//89  707  707
//90  727  727
//91  745  745
//92  759  759
//93  766  766
//94  772  772
//95  775  775
//96  746  746
//97  744  744
//98  736  736
//99  725  725
//100  711  711
//101  689  689
//102  666  666
//103  641  641
//104  610  610
//105  576  576
//106  541  541
//107  504  504
//108  468  468
//109  429  429
//110  393  393
//111  355  355
//112  318  318
//113  282  282
//114  249  249
//115  220  220
//116  192  192
//117  170  170
//118  150  150
//119  134  134
//120  122  122
//121  117  117
//122  145  145
//123  151  151
//124  164  164
//125  179  179
//126  200  200
//127  226  226
//128  255  255
//129  287  287
//130  320  320
//131  357  357
//132  391  391
//133  430  430
//134  467  467
//135  505  505
//136  539  539
//137  573  573
//138  603  603
//139  633  633
//140  656  656
//141  678  678
//142  696  696
//143  707  707
//144  717  717
//145  720  720
//146  687  687
//147  685  685
//148  677  677
//149  664  664
//150  647  647
//151  623  623
//152  598  598
//153  570  570
//154  537  537
//155  502  502
//156  465  465
//157  428  428
//158  392  392
//159  356  356
//160  323  323
//161  291  291
//162  261  261
//163  235  235
//164  212  212
//165  193  193
//166  180  180
//167  176  176
//168  202  202
//169  214  214
//170  231  231
//171  253  253
//172  282  282
//173  315  315
//174  351  351
//175  389  389
//176  431  431
//177  470  470
//178  509  509
//179  545  545
//180  578  578
//181  606  606
//182  629  629
//183  645  645
//184  656  656
//185  659  659
//186  631  631
//187  627  627
//188  617  617
//189  597  597
//190  572  572
//191  544  544
//192  507  507
//193  467  467
//194  429  429
//195  390  390
//196  353  353
//197  317  317
//198  285  285
//199  262  262
//200  243  243
//201  233  233
//202  262  262
//203  274  274
//204  295  295
//205  323  323
//206  354  354
//207  391  391
//208  430  430
//209  466  466
//210  505  505
//211  538  538
//212  562  562
//213  584  584
//214  596  596
//215  602  602
//216  573  573
//217  568  568
//218  553  553
//219  531  531
//220  500  500
//221  467  467
//222  430  430
//223  392  392
//224  357  357
//225  328  328
//226  306  306
//227  292  292
//228  319  319
//229  336  336
//230  362  362
//231  396  396
//232  430  430
//233  465  465
//234  499  499
//235  522  522
//236  537  537
//237  545  545
//238  516  516
//239  508  508
//240  491  491
//241  462  462
//242  429  429
//243  398  398
//244  370  370
//245  350  350
//246  380  380
//247  401  401
//248  429  429
//249  460  460
//250  480  480
//251  487  487
//252  454  454
//253  429  429
//254  404  404
//255  429  429






//0  25  25
//1  28  28
//2  32  32
//3  42  42
//4  52  52
//5  69  69
//6  87  87
//7  108  108
//8  131  131
//9  158  158
//10  186  186
//11  217  217
//12  250  250
//13  284  284
//14  319  319
//15  356  356
//16  395  395
//17  429  429
//18  466  466
//19  503  503
//20  539  539
//21  576  576
//22  609  609
//23  641  641
//24  672  672
//25  701  701
//26  727  727
//27  751  751
//28  774  774
//29  791  791
//30  805  805
//31  816  816
//32  825  825
//33  830  830
//34  802  802
//35  794  794
//36  787  787
//37  776  776
//38  759  759
//39  741  741
//40  720  720
//41  696  696
//42  669  669
//43  639  639
//44  605  605
//45  573  573
//46  538  538
//47  504  504
//48  466  466
//49  429  429
//50  392  392
//51  356  356
//52  320  320
//53  286  286
//54  253  253
//55  221  221
//56  192  192
//57  166  166
//58  141  141
//59  119  119
//60  99  99
//61  83  83
//62  72  72
//63  62  62
//64  56  56
//65  54  54
//66  84  84
//67  88  88
//68  93  93
//69  101  101
//70  114  114
//71  130  130
//72  149  149
//73  173  173
//74  199  199
//75  227  227
//76  257  257
//77  289  289
//78  324  324
//79  359  359
//80  393  393
//81  429  429
//82  465  465
//83  500  500
//84  537  537
//85  571  571
//86  602  602
//87  635  635
//88  660  660
//89  686  686
//90  709  709
//91  729  729
//92  744  744
//93  758  758
//94  766  766
//95  772  772
//96  743  743
//97  737  737
//98  725  725
//99  710  710
//100  689  689
//101  666  666
//102  640  640
//103  610  610
//104  577  577
//105  542  542
//106  506  506
//107  467  467
//108  429  429
//109  390  390
//110  354  354
//111  316  316
//112  282  282
//113  249  249
//114  218  218
//115  193  193
//116  168  168
//117  148  148
//118  135  135
//119  122  122
//120  114  114
//121  112  112
//122  141  141
//123  144  144
//124  151  151
//125  164  164
//126  181  181
//127  202  202
//128  226  226
//129  254  254
//130  284  284
//131  319  319
//132  356  356
//133  392  392
//134  429  429
//135  468  468
//136  505  505
//137  540  540
//138  574  574
//139  605  605
//140  631  631
//141  657  657
//142  678  678
//143  695  695
//144  707  707
//145  715  715
//146  687  687
//147  678  678
//148  666  666
//149  647  647
//150  626  626
//151  600  600
//152  570  570
//153  538  538
//154  503  503
//155  465  465
//156  429  429
//157  393  393
//158  356  356
//159  321  321
//160  288  288
//161  258  258
//162  233  233
//163  210  210
//164  194  194
//165  178  178
//166  172  172
//167  169  169
//168  197  197
//169  203  203
//170  213  213
//171  228  228
//172  253  253
//173  282  282
//174  313  313
//175  351  351
//176  390  390
//177  431  431
//178  468  468
//179  508  508
//180  545  545
//181  577  577
//182  606  606
//183  629  629
//184  646  646
//185  656  656
//186  627  627
//187  615  615
//188  597  597
//189  572  572
//190  542  542
//191  506  506
//192  469  469
//193  430  430
//194  390  390
//195  352  352
//196  317  317
//197  285  285
//198  262  262
//199  244  244
//200  233  233
//201  226  226
//202  257  257
//203  263  263
//204  275  275
//205  294  294
//206  322  322
//207  353  353
//208  391  391
//209  428  428
//210  468  468
//211  506  506
//212  538  538
//213  564  564
//214  585  585
//215  598  598
//216  569  569
//217  554  554
//218  533  533
//219  503  503
//220  468  468
//221  432  432
//222  392  392
//223  358  358
//224  328  328
//225  305  305
//226  291  291
//227  285  285
//228  315  315
//229  322  322
//230  337  337
//231  361  361
//232  393  393
//233  428  428
//234  465  465
//235  497  497
//236  521  521
//237  539  539
//238  509  509
//239  490  490
//240  462  462
//241  429  429
//242  395  395
//243  368  368
//244  349  349
//245  344  344
//246  372  372
//247  380  380
//248  401  401
//249  429  429
//250  458  458
//251  479  479
//252  456  456
//253  427  427
//254  404  404

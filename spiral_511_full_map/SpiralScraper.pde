int NumLEDs = 171;

class SpiralScraper {

  Point[] spiralArray;  // array that holds the offsets to each pixel
  Point   position;     // the scrape location for the center of the spiral
  float   size;         // scale factor
  int     id;           // scraper number

  SpiralScraper(int id, float x, float y, float size, float rotation) {
    spiralArray= new Point[NumLEDs];
    initSpiralArray();
    
    this.id = id;
    this.size = size;
    this.position = new Point(x, y);
    
    // We want to save the time taken to do the matrix manipulation during the scrape,
    // so we'll pre-transform and pre-translate the array here.
    
    for (int i=0; i<NumLEDs; i++) {
      //println("before: " + spiralArray[i]);
      //spiralArray[i] = spiralArray[i].scale(size);
      //spiralArray[i] = spiralArray[i].invertX();
      //spiralArray[i] = spiralArray[i].invertY();
        spiralArray[i] = spiralArray[i].add(position);
      //println(spiralArray[i]);
    }
  }

  void scrapeStrip(Strip s, PImage pi, float adjAlpha) {
     // This is easy now we're all initialized up.
     int actualLength=NumLEDs;
     //println("scraping strip");
     if (s.getLength() < NumLEDs) {
       actualLength=s.getLength();
       println("Something's wrong.  These strips are supposed to be " + NumLEDs + " pix long, but are only "+s.getLength()+" long.");
     }
  
    colorMode(HSB,255);
    // The pixels actually go in reverse order as they're fed from the edge.
    for (int i=0; i<actualLength; i++) {
      int sample = pi.get(int(spiralArray[i].x), int(spiralArray[i].y));
      //println("sample: " + sample + " LED index: " + i + " actual length: " + actualLength);
      
      //      if (i==testPixel) {
      //        sample = #000000;
      //      }
      //println(adjAlpha);
      int brightnessModSample = color(hue(sample), saturation(sample), floor(brightness(sample) * adjAlpha));
      s.setPixel(brightnessModSample, i);
      rectMode(CENTER);
      fill(sample);
      stroke(0);
      rect(int(this.position.x), int(this.position.y), 20, 20);
      fill(255);
      text(""+(this.id+1)+"", int(this.position.x), int(this.position.y));
//      rectMode(CENTER);
//      fill(sample);
//      stroke(255);
//      rect(int(spiralArray[i].x), int(spiralArray[i].y), 10, 10);
    }
//     if ((frameCount % 30) == 0) {
//         testPixel++;
//        if (testPixel == actualLength) {
//          testPixel = 0;
//        }
//      }
}
  
  void initSpiralArray() {
    // This is pretty gross, so let's remove it from the constructor. - jls
    // These offsets extracted from the spiral generator.
    
    spiralArray[0] = new Point(497.0, 41.0);
    spiralArray[1] = new Point(566.0, 49.0);
    spiralArray[2] = new Point(636.0, 67.0);
    spiralArray[3] = new Point(700.0, 94.0);
    spiralArray[4] = new Point(759.0, 130.0);
    spiralArray[5] = new Point(813.0, 177.0);
    spiralArray[6] = new Point(857.0, 227.0);
    spiralArray[7] = new Point(894.0, 286.0);
    spiralArray[8] = new Point(922.0, 349.0);
    spiralArray[9] = new Point(941.0, 419.0);
    spiralArray[10] = new Point(948.0, 487.0);
    spiralArray[11] = new Point(945.0, 557.0);
    spiralArray[12] = new Point(931.0, 627.0);
    spiralArray[13] = new Point(905.0, 689.0);
    spiralArray[14] = new Point(870.0, 750.0);
    spiralArray[15] = new Point(826.0, 804.0);
    spiralArray[16] = new Point(774.0, 851.0);
    spiralArray[17] = new Point(715.0, 888.0);
    spiralArray[18] = new Point(652.0, 918.0);
    spiralArray[19] = new Point(585.0, 937.0);
    spiralArray[20] = new Point(515.0, 944.0);
    spiralArray[21] = new Point(445.0, 939.0);
    spiralArray[22] = new Point(378.0, 925.0);
    spiralArray[23] = new Point(311.0, 899.0);
    spiralArray[24] = new Point(252.0, 864.0);
    spiralArray[25] = new Point(199.0, 821.0);
    spiralArray[26] = new Point(155.0, 767.0);
    spiralArray[27] = new Point(118.0, 705.0);
    spiralArray[28] = new Point(91.0, 642.0);
    spiralArray[29] = new Point(78.0, 574.0);
    spiralArray[30] = new Point(74.0, 503.0);
    spiralArray[31] = new Point(81.0, 433.0);
    spiralArray[32] = new Point(100.0, 368.0);
    spiralArray[33] = new Point(131.0, 305.0);
    spiralArray[34] = new Point(171.0, 246.0);
    spiralArray[35] = new Point(219.0, 198.0);
    spiralArray[36] = new Point(278.0, 159.0);
    spiralArray[37] = new Point(338.0, 126.0);
    spiralArray[38] = new Point(404.0, 107.0);
    spiralArray[39] = new Point(476.0, 98.0);
    spiralArray[40] = new Point(542.0, 101.0);
    spiralArray[41] = new Point(611.0, 117.0);
    spiralArray[42] = new Point(677.0, 144.0);
    spiralArray[43] = new Point(736.0, 181.0);
    spiralArray[44] = new Point(786.0, 229.0);
    spiralArray[45] = new Point(830.0, 285.0);
    spiralArray[46] = new Point(861.0, 347.0);
    spiralArray[47] = new Point(881.0, 414.0);
    spiralArray[48] = new Point(890.0, 485.0);
    spiralArray[49] = new Point(887.0, 553.0);
    spiralArray[50] = new Point(871.0, 621.0);
    spiralArray[51] = new Point(843.0, 684.0);
    spiralArray[52] = new Point(807.0, 742.0);
    spiralArray[53] = new Point(757.0, 794.0);
    spiralArray[54] = new Point(700.0, 835.0);
    spiralArray[55] = new Point(637.0, 863.0);
    spiralArray[56] = new Point(570.0, 882.0);
    spiralArray[57] = new Point(499.0, 885.0);
    spiralArray[58] = new Point(431.0, 879.0);
    spiralArray[59] = new Point(363.0, 860.0);
    spiralArray[60] = new Point(300.0, 827.0);
    spiralArray[61] = new Point(247.0, 784.0);
    spiralArray[62] = new Point(199.0, 730.0);
    spiralArray[63] = new Point(166.0, 672.0);
    spiralArray[64] = new Point(142.0, 604.0);
    spiralArray[65] = new Point(131.0, 540.0);
    spiralArray[66] = new Point(133.0, 468.0);
    spiralArray[67] = new Point(151.0, 398.0);
    spiralArray[68] = new Point(177.0, 335.0);
    spiralArray[69] = new Point(218.0, 279.0);
    spiralArray[70] = new Point(269.0, 231.0);
    spiralArray[71] = new Point(328.0, 194.0);
    spiralArray[72] = new Point(396.0, 168.0);
    spiralArray[73] = new Point(462.0, 158.0);
    spiralArray[74] = new Point(530.0, 158.0);
    spiralArray[75] = new Point(601.0, 174.0);
    spiralArray[76] = new Point(663.0, 203.0);
    spiralArray[77] = new Point(719.0, 243.0);
    spiralArray[78] = new Point(766.0, 292.0);
    spiralArray[79] = new Point(801.0, 354.0);
    spiralArray[80] = new Point(822.0, 418.0);
    spiralArray[81] = new Point(834.0, 489.0);
    spiralArray[82] = new Point(828.0, 558.0);
    spiralArray[83] = new Point(809.0, 626.0);
    spiralArray[84] = new Point(776.0, 686.0);
    spiralArray[85] = new Point(729.0, 741.0);
    spiralArray[86] = new Point(674.0, 781.0);
    spiralArray[87] = new Point(615.0, 812.0);
    spiralArray[88] = new Point(544.0, 830.0);
    spiralArray[89] = new Point(474.0, 829.0);
    spiralArray[90] = new Point(407.0, 813.0);
    spiralArray[91] = new Point(340.0, 785.0);
    spiralArray[92] = new Point(286.0, 744.0);
    spiralArray[93] = new Point(242.0, 690.0);
    spiralArray[94] = new Point(209.0, 628.0);
    spiralArray[95] = new Point(192.0, 562.0);
    spiralArray[96] = new Point(190.0, 495.0);
    spiralArray[97] = new Point(200.0, 425.0);
    spiralArray[98] = new Point(228.0, 364.0);
    spiralArray[99] = new Point(274.0, 307.0);
    spiralArray[100] = new Point(324.0, 262.0);
    spiralArray[101] = new Point(386.0, 233.0);
    spiralArray[102] = new Point(454.0, 217.0);
    spiralArray[103] = new Point(523.0, 217.0);
    spiralArray[104] = new Point(591.0, 233.0);
    spiralArray[105] = new Point(654.0, 265.0);
    spiralArray[106] = new Point(706.0, 313.0);
    spiralArray[107] = new Point(748.0, 372.0);
    spiralArray[108] = new Point(770.0, 436.0);
    spiralArray[109] = new Point(777.0, 504.0);
    spiralArray[110] = new Point(766.0, 575.0);
    spiralArray[111] = new Point(739.0, 637.0);
    spiralArray[112] = new Point(697.0, 692.0);
    spiralArray[113] = new Point(642.0, 736.0);
    spiralArray[114] = new Point(578.0, 763.0);
    spiralArray[115] = new Point(509.0, 773.0);
    spiralArray[116] = new Point(440.0, 764.0);
    spiralArray[117] = new Point(374.0, 734.0);
    spiralArray[118] = new Point(322.0, 697.0);
    spiralArray[119] = new Point(277.0, 639.0);
    spiralArray[120] = new Point(251.0, 570.0);
    spiralArray[121] = new Point(245.0, 506.0);
    spiralArray[122] = new Point(257.0, 441.0);
    spiralArray[123] = new Point(288.0, 378.0);
    spiralArray[124] = new Point(335.0, 324.0);
    spiralArray[125] = new Point(396.0, 287.0);
    spiralArray[126] = new Point(464.0, 273.0);
    spiralArray[127] = new Point(533.0, 273.0);
    spiralArray[128] = new Point(600.0, 298.0);
    spiralArray[129] = new Point(656.0, 340.0);
    spiralArray[130] = new Point(697.0, 398.0);
    spiralArray[131] = new Point(717.0, 463.0);
    spiralArray[132] = new Point(718.0, 531.0);
    spiralArray[133] = new Point(697.0, 596.0);
    spiralArray[134] = new Point(657.0, 653.0);
    spiralArray[135] = new Point(597.0, 695.0);
    spiralArray[136] = new Point(532.0, 715.0);
    spiralArray[137] = new Point(460.0, 710.0);
    spiralArray[138] = new Point(397.0, 684.0);
    spiralArray[139] = new Point(346.0, 637.0);
    spiralArray[140] = new Point(311.0, 576.0);
    spiralArray[141] = new Point(300.0, 510.0);
    spiralArray[142] = new Point(316.0, 444.0);
    spiralArray[143] = new Point(355.0, 383.0);
    spiralArray[144] = new Point(410.0, 343.0);
    spiralArray[145] = new Point(478.0, 327.0);
    spiralArray[146] = new Point(549.0, 338.0);
    spiralArray[147] = new Point(606.0, 371.0);
    spiralArray[148] = new Point(647.0, 432.0);
    spiralArray[149] = new Point(662.0, 498.0);
    spiralArray[150] = new Point(647.0, 565.0);
    spiralArray[151] = new Point(606.0, 620.0);
    spiralArray[152] = new Point(544.0, 653.0);
    spiralArray[153] = new Point(473.0, 654.0);
    spiralArray[154] = new Point(411.0, 623.0);
    spiralArray[155] = new Point(369.0, 568.0);
    spiralArray[156] = new Point(360.0, 500.0);
    spiralArray[157] = new Point(385.0, 437.0);
    spiralArray[158] = new Point(438.0, 394.0);
    spiralArray[159] = new Point(509.0, 387.0);
    spiralArray[160] = new Point(567.0, 416.0);
    spiralArray[161] = new Point(603.0, 476.0);
    spiralArray[162] = new Point(595.0, 545.0);
    spiralArray[163] = new Point(547.0, 590.0);
    spiralArray[164] = new Point(475.0, 597.0);
    spiralArray[165] = new Point(423.0, 550.0);
    spiralArray[166] = new Point(421.0, 486.0);
    spiralArray[167] = new Point(474.0, 443.0);
    spiralArray[168] = new Point(535.0, 466.0);
    spiralArray[169] = new Point(535.0, 529.0);
    spiralArray[170] = new Point(483.0, 510.0);
  }

}



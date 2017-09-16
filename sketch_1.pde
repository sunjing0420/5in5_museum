PImage img;
import ddf.minim.analysis.FFT;
import ddf.minim.*;

Minim minim;
AudioPlayer song;
FFT fftLog;


// Modifiable parameters
//float spectrumScale = 2;
//float STROKE_MAX = 10;
//float STROKE_MIN = 2;
//float strokeMultiplier = 1;
//float audioThresh = .9;
float[] circles = new float[2];
//float DECAY_RATE = 2;

void setup() {
  size(1000, 667, P3D);

  img=loadImage("1234.jpg");
  image(img, 0, 0);

  minim = new Minim(this);
  song = minim.loadFile("002.mp3", 512);
  song.loop();

  fftLog = new FFT( song.bufferSize(), song.sampleRate());
  fftLog.logAverages( 10, 3);
}

void draw() {

  // Push new audio samples to the FFT
  fftLog.forward(song.mix);


  // Loop through frequencies and compute width for ellipse stroke widths, and amplitude for size
  for (int i = 0; i < 2; i++) {

    float amplitude = fftLog.getAvg(i);



    circles[i] = amplitude*(height/4);
    println(circles[i]);

    float pointillize = map(mouseX, 0, width, circles[i]/20, circles[i]/20);
    int x = int(random(270,730));
    int y = int(random(110,540));

    //get the color from the image
    color pix = img.get(x, y);

    //draw
    fill(pix, 128);
    noStroke();
    ellipse(x, y, pointillize, pointillize);
  }
}
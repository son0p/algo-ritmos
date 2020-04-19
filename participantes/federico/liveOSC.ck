Library lib;
Inmutable inmutable;

120::ms => dur beat;

// create our OSC receiver
OscRecv recv;
// use port 6449
6449 => recv.port;
// start listening (launch thread)
recv.listen();

// create an address in the receiver, store in new variable
recv.event( "/audio/1/int, i" )   @=>    OscEvent oi;
recv.event( "/audio/1/float, f" ) @=>    OscEvent of;
recv.event( "/audio/2/bass, i" )  @=>    OscEvent oscBass;
recv.event( "/audio/2/bd, i" )    @=>    OscEvent oscBD;

int intNotes[16];
int intBass[16];
int intBD[16];
inmutable.inmutableArray @=> intNotes;
inmutable.inmutableBass  @=> intBass;
inmutable.inmutableBD    @=> intBD;
float floatNotes[16];

fun  void oscRxFloat()
{
    int i;
    while ( true ){
        // wait for event to arrive
        of => now;
        while ( of.nextMsg() != 0 ){
            of.getFloat() => floatNotes[i%16];
            i++;
        }
    }
}
fun void oscRxInt()
{
    int j;
    while ( true ){
        // wait for event to arrive
        oi => now;
        while ( oi.nextMsg() != 0 ){
            oi.getInt() =>  inmutable.inmutableArray[j%16];
            j++;
        }
    }
}
fun void oscRxBass(){
    int j;
    while ( true ){
        // wait for event to arrive
        oscBass => now;
        while ( oscBass.nextMsg() != 0 ){
            oscBass.getInt() =>  inmutable.inmutableBass[j%16];
            j++;
        }
    }
}
fun void oscRxBD(){
    int i;
    while(true){
        oscBD => now;
        while( oscBD.nextMsg() != 0 ){
            oscBD.getInt() => inmutable.inmutableBD[i%16]; <<< intBD[i]>>>;
            i++;
        }
    }
}


//// TEST sound

JCRev rev;
SinOsc sin6 => rev => dac;
SqrOsc sqr =>  dac;
0.01 => rev.mix;
0.2 => sqr.gain;
0.4 => sin6.gain;

fun void simplePlay(){
    while(true){
        for(0 => int i; i < 15; i++){
            intNotes[i] => sin6.freq;
            lib.run(beat);
        }
    }
}
fun void bassPlay(){
    while(true){
        for(0 => int i; i < 15; i++){
            intBass[i] => sqr.freq;
            lib.run(beat);
        }
    }
}

fun void playDrum(ADSR instrument){
  while(true){
      for(0 => int i; i < 15; i++){
      intBD[i] => int value; 
      if( value != 0 && instrument == lib.bd ){
          lib.playDrums(instrument, lib.bdImpulse);
      }
      if(value != 0){
      lib.playDrums(instrument);
      lib.run(beat);
    }
    else
    {
      lib.run(beat); 
    }
      }
  }
}
/// end TEST sound
fun void runningOSC(){
    spork~ oscRxInt();
    spork~ oscRxBass();
    spork~ oscRxBD();
    1::week => now;
}

spork~ runningOSC();
spork~ simplePlay();
spork~ bassPlay();
spork~ playDrum(lib.hh);

while(true){
    beat => now;
}




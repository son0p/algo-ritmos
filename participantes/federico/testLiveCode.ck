BPM.sync(170.00) => BPM.tempo => dur beat;
16 => BPM.steps; // no anda
Generator generator;
PlayerDrums dr;
PlayerMelodies melodier;
PlayerBass bassist;
MelodyGenerator ml;
Player play;
ProgressionGenerator prog;
Synth synth;
SynthBass synthBass;
CollectionBeats beats;
CollectionMelodies melodies;
CollectionBasses basses;
Moodizer moodizer;
0 => int counter;

48 =>  BPM.root;

//spork~ moodizer.dancefloor("expo",0);
testDrop(0);
//live();


function void live(){
    [
    [
    [1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0],
    [0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0],
    [0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,1]
    ]
    ]@=>  int liveBeat[][][];
    [
    [
    [0.0,   0,   0,   12.0 ],
    [2.0,  .25, .25, 1.0],
    [0.0,   8,   16 ,   28 ]
    ]
    ]
    @=> float liveBass[][][];

    [
    [
    [12.0, 12.0,  12,  12,    7,  7,    5,   5,   3,   0 ],
    [.25,  .25,   .25, .25, .25, .25, .25, .25, .25, .25 ],
    [8.0,    10,     12,  16,  18, 20,  22,  24,  26,  30 ]
    ]
    ]@=> float liveMel[][][];



    spork~ dr.arrayDrums(liveBeat[0]);
    spork~ bassist.arrays(liveBass[0]);
    spork~ melodier.arrays(liveMel[0]);//live
}



// function void bassIntegrated()
// {
//   0 => int counter;
//     while(true)
//   {
//     counter % 32 => int bassPhrase;
//     if(bassPhrase == 0){spork~ bassist.arrays(basses.cumbia[Math.random2(0,basses.cumbia.cap()-1)]);}
//     if(bassPhrase == 0){spork~ bassist.arrays(basses.cumbiaBuildUp[Math.random2(0,basses.cumbia.cap()-1)]);}
//      if(bassPhrase == 0){spork~ bassist.arrays(basses.cumbiaDrop[Math.random2(0,basses.cumbia.cap()-1)]);}

//     beat * 1 => now;
//     counter++;
//  }
// }

//test
function void testExpo(int arrayPosition)
{
    spork~ melodier.arrays(melodies.cumbia[arrayPosition]);
    spork~ bassist.arrays(basses.cumbia[arrayPosition]);
    spork~ dr.arrayDrums(beats.cumbia[arrayPosition]);
}

function void testBuild(int arrayPosition)
{
    spork~ melodier.arrays(melodies.cumbiaBuild[arrayPosition]);
    spork~ bassist.arrays(basses.cumbiaBuild[arrayPosition]);
    spork~ dr.arrayDrums(beats.cumbiaBuild[arrayPosition]);
}
function void testDrop(int arrayPosition)
{
    spork~ melodier.arrays(melodies.cumbiaDrop[arrayPosition]);
    spork~ bassist.arrays(basses.cumbiaDrop[arrayPosition]);
    spork~ dr.arrayDrums(beats.cumbiaDrop[arrayPosition]);
}

// function void testArrays2(int arrayPosition, string text)
// {
//     spork~ melodier.arrays(melodies.cumbia+text[arrayPosition]);
//     spork~ bassist.arrays(basses.cumbia+text[arrayPosition]);
//     spork~ dr.arrayDrums(beats.cumbia+text[arrayPosition]);
// }

function void melodyIntegrated()
{
  while(true)
  {
      counter % 32 => int phrase;
      if (phrase == 0){ spork~ melodier.arrays(melodies.cumbia[1]); }
      if(phrase == 16){ spork~ melodier.arrays(melodies.cumbia[1]); }
      beat * 0.25  => now;
      counter++;
  }
}



//spork~ build();
//spork~ drop();


//spork~ dr.arrayDrums(liveBeat[0]);
//spork~ BPM.metro(8, beat);
//spork~ dr.arrayDrums(beats.cumbia[0]);

//spork~ bassist.arrays(liveBass[0]);
//spork~ bassIntegrated();


//spork~ melodier.arrays(liveMel[0]);//live
//spork~ melodyIntegrated();

//spork~ dr.reverbTransformation(1);
spork~ dr.soundTransformation();

//spork~ dr.fill(5, 0.125);
//spork~ melodier.arrays(melodies.base[1]);
//spork~ melodier.arrays(liveMel[0]);
//spork~ play.chordPlayer(test,1);
//spork~ synth.playChord([57,60,64], 1, 0);
//spork~ play.chordPlayer([[57,60,64], [57,63,67], [80, 84, 88]]);
//spork~ play.playMelody(1, root, 3, [[(test[0]),2],[test(1),1]]);
//spork~ play.playMelody(1, root, 3, [[0,1],[3,1]]);
//spork~ play.playMelody(1, root, 3, [[0,2],[4,1],[2,2],[0,1],[-88,1],[6,1],[-88,1]]);
//spork~ ml.searchMelody( root,6,4, 8);
//spork~ ml.generateMelody(root,2);


// Modulation zone
function void bassModulator(int modulationGain, float ratio)
{
   modulationGain => synthBass.modulatorGain;
   ratio => synthBass.ratio;
}
// ensaye relaciones 0.38, 0.5, 1.0, 2.0, 4.0, 1.33333, 0.33333, 0.2857
spork~ bassModulator(50, 2.0);

function void melodyModulator(int modulationGain, float ratio)
{
   modulationGain => synth.modulatorGain;
   ratio => synth.ratio;
}
spork~ melodyModulator(200, 0.5);
// mantiene vivos los sporks
while( true ){
    100::ms => now;
}

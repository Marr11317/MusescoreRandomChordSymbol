//==============================================
//  Random Harmonies Generator v 0.1
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//==============================================

import QtQuick 2.0
import MuseScore 1.0

MuseScore {
      version:  "0.1"
      description: "This plugin generates completely random harmonies over the score. As a jazz player, you could use it to  practice your sight-reading"    
      menuPath: "Plugins.Random Harmonies Generator"

      onRun: {
            console.log("Generating Random Harmonies");
            
            var nbOfMeasures = 32;
            
            var pluginScore = newScore("RandomHarmonies.mscz", "piano", nbOfMeasures);
            
	    	
            var theTimeSig = newElement(Element.TIMESIG);
            var numerator = 4;
            var denominator = 4;
            theTimeSig.setSig(numerator, denominator);
            
            //var theKeySig = newElement(Element.KEYSIG);;
            //theKeySig.setKey(0); // Sets the key signature to C/Am
            
            pluginScore.addText("title", "==Random Harmonies Score's title==");
            pluginScore.addText("subtitle", "==By: The Random Harmonies Generator v 0.1==");
            
            var pluginCursor = pluginScore.newCursor();
            pluginCursor.rewind(0); // rewind to the beginning of the score
            var cursorMeasure = 0;
            
            pluginCursor.add(theTimeSig);
            //pluginCursor.add(theKeySig); //Unfortunately, this doesn't work for some reason
            
            //var noteNamesAll = [["Fbb", "Cbb","Gbb","Dbb","Abb","Ebb","Bbb"]
            //                    ["Fb","Cb","Gb","Db","Ab","Eb","Bb"]
            //                    ["F","C","G","D","A","E","B"]
            //                    ["F#","C#","G#","D#","A#","E#","B#"]
            //                    ["F##","C##","G##","D##","A##","E##","B##"]]; //tonalPitchClass (tpc).
            //var noteNamesEasy = noteNamesAll [2];
            var noteNamesEasy = ["F","C","G","D","A","E","B"];
            //var noteNamesMedium = [noteNamesAll [1], noteNamesAll [2], noteNamesAll [3]]
			
            var chordExtensionsJazz = ["", "m", "o", "+", "sus4", "sus2",
                                       "t7", "7", "+7", "t7+",
                                       "-7", "-t7",
                                       "7sus4", "7sus2"]

            console.log("Cursor at Measure:", cursorMeasure);

            var myBreak = newElement(Element.LAYOUT_BREAK);
            myBreak.layoutBreakType = LayoutBreak.LINE;

            while (cursorMeasure < nbOfMeasures){
                  if (cursorMeasure % 4 === 3){
                        pluginCursor.add(myBreak);
                  }
                  var pluginHarmony = newElement(Element.HARMONY);
                  /*pluginHarmony.baseTpc = 14 + Math.floor(Math.random() * noteNamesEasy.length);
                  //pluginHarmony.rootTpc = noteNamesEasy[Math.floor(Math.random() * noteNamesEasy.length)];
                  pluginHarmony.rootTpc = 14 + Math.floor(Math.random() * noteNamesEasy.length);
                  //pluginHarmony.id = chordExtensionsJazz[Math.floor(Math.random() * chordExtensionsJazz.length)];
                  pluginHarmony.id = Math.floor(Math.random() * 64);*/
				  
                  var chordName = noteNamesEasy[Math.floor(Math.random() * noteNamesEasy.length)] + chordExtensionsJazz[Math.floor(Math.random() * chordExtensionsJazz.length)] + "/" + noteNamesEasy[Math.floor(Math.random() * noteNamesEasy.length)];
                  console.log("New chord: " + chordName);
                  pluginHarmony.text = chordName;
				  
                  pluginCursor.add(pluginHarmony);

                  pluginCursor.nextMeasure();
                  cursorMeasure ++;
            }
            
            console.log("Generation complete");     
            Qt.quit();
      }
}

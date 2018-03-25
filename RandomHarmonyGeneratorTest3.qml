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
            
            var theKeySig = newElement(Element.KEYSIG);;
            //theKeySig.setKey(0); // Sets the key signature to C/Am
            
            pluginScore.addText("title", "==Random Harmonies Score's title==");
            pluginScore.addText("subtitle", "==By: The Random Harmonies Generator v 0.1==");
            
            var pluginCursor = pluginScore.newCursor();
            pluginCursor.rewind(0); // rewind to the beginning of the score
            int cursorMeasure = 0;
            
            pluginCursor.add(theTimeSig);
            //pluginCursor.add(theKeySig);
            
            var currentRest;
            var xmlHarmonyIDsToAccept = [1, 2, 6, 16, 19, 64];
            var beginTonalPitchClass_enum = 8;
            var endTonalPitchClass_enum = 24;

            console.log("Cursor at Measure:", cursorMeasure);

            while (cursorMeasure < pluginScore.nmeasures){
                  var pluginHarmony = newElement(Element.HARMONY);


                  pluginHarmony: {
                        id: xmlHarmonyIDsToAccept[Math.floor(Math.random() * xmlHarmonyIDsToAccept.size())];
                        root: beginTonalPitchClass_enum + Math.floor(Math.random() * (endTonalPitchClass_enum - beginTonalPitchClass_enum));
                  };

                  if(cursor.isRest()){
                        var rest = cursor.rest();
                        rest.addHarmony(myHarmony);
                  }
                  console.log("Add harmony: " + myHarmony.root + myHarmony.id + " at measure: " + pluginCursor.measure);
                  pluginCursor.nextMeasure();
                  cursorMeasure ++;
            }
            
            console.log("Generation complete");     
            Qt.quit();
      }
}

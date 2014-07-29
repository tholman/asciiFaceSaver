////
////  asciiFaces.swift
////  ascii-faces
////
////  Created by Timothy Holman on 7/28/14.
////  Copyright (c) 2014 Timothy Holman. All rights reserved.
////
//
import Foundation

class asciiFaceManager {

    var faces = [ "~(˘▾˘~)", "(ノಠ益ಠ)ノ", "(ಠ_ಠ)" ];
    var usedFaces: [String] = [];

    // Returns a random face that hasn't been used this cycle.
    // The only way you can get the same face twice, is after they have all played.
    func getFace() -> String {

        //@TODO: Is there a nicer way to get a random array item?
        var randomIndex = Int(arc4random_uniform(UInt32(faces.count)));
        var face = faces.removeAtIndex( randomIndex );
        usedFaces.append( face );

        if( faces.count == 0 ) {
            faces = usedFaces;
            usedFaces = [];
        }
        
        return face;
    }
}
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

    var faces = [ "(ノಠ益ಠ)ノ", "~(˘▾˘~)", "(ಠ_ಠ)" ];

    func getFace() -> String {

        //@TODO: Is there a nicer way to get a random array item?
        var randomIndex = Int(arc4random_uniform(UInt32(faces.count)));
        return faces[randomIndex];
    }
}
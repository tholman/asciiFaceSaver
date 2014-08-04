/*
 *  asciiFaces.swift
 *  ascii-faces
 *
 *  Created by Timothy Holman on 7/28/14.
 *  Copyright (c) 2014 Timothy Holman. All rights reserved.
 */

import Foundation

// Manages the ascii faces, and dishing them out randomly!
class asciiFaceManager {

    // If you're adding to this, please try to keep it uniform...
    // guys like this: ༼ つ ◕_◕ ༽つ (despite being awesome) make
    // the screen saver look a bit odd. by taking up too much space.
    var faces = [ "~(˘▾˘~)" ,
                  "(ノಠ益ಠ)ノ",
                  "(ಠ_ಠ)",
                  "(ू˃̣̣̣̣̣̣︿˂̣̣̣̣̣̣ ू)",
                  "(ó ì_í)",
                  "(ง'̀-'́)ง",
                  "ლ(ಠ益ಠლ)",
                  "(ꐦ°᷄д°᷅)",
                  "ᕕ( ᐛ )ᕗ",
                  "(●´∀｀●)",
                  "ヽ(；▽；)ノ",
                  "（＾_＾）",
                  "(＾▽＾)",
                  "（*＾ワ＾*）",
                  "(ﾉﾟ0ﾟ)ﾉ~",
                  "w(°ｏ°)w",
                  "(*ﾟﾛﾟ)",
                  "o(╥﹏╥)o",
                  "｡･ﾟﾟ･(>д<)･ﾟﾟ･｡",
                  "(╯︵╰,)",
                  "o(-`д´- ｡)",
                  "ᕦ(ò_óˇ)ᕤ",
                  "╭(๑¯д¯๑)╮",
                  "(҂⌣̀_⌣́)",
                  "o(´^｀)o",
                  "ʕ•ᴥ•ʔ",
                  "ლ(ಠ益ಠლ)",
                  "(๑>ᴗ<๑)",
                  "(੭ु ຶਊ ຶ)੭ु",
                  "(ﾉಥ益ಥ）ﾉ",
                  "( ͡° ͜ʖ ͡°)",
                  "(ಠ_ರೃ)",
                  "щ(ºДºщ)",
                  "(ಥ﹏ಥ)" 
    ];
    
    var usedFaces: [String] = [];

    // Returns a random face that hasn't been used.
    func getFace() -> String {

        var randomIndex = Int(arc4random_uniform(UInt32(faces.count)));
        var face = faces.removeAtIndex( randomIndex );
        usedFaces.append( face );

        // If all the faces have been used, start the cycle again.
        if( faces.count == 0 ) {
            faces = usedFaces;
            usedFaces = [];
        }
        
        return face;
    }
}
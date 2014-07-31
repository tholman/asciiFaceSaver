//
//  asciiFacesView
//  ascii-faces
//
//  Created by Timothy Holman on 7/27/14.
//  Copyright (c) 2014 Timothy Holman. All rights reserved.
//

import Cocoa
import ScreenSaver

class asciiFacesView: ScreenSaverView {
    
    
    // @TODO: Move this into some other file, somewhow.
    var currentFace = 0;
    var currentFrame = 0;
    var totalFramesInSet = 90;
    var fadeTime = 30; // frames.
    var faceManager = asciiFaceManager();
    var face: String;
    
    
    // Initializers
    convenience init() {
        self.init(frame: CGRectZero, isPreview: false);
    }
    
    init(frame: NSRect, isPreview: Bool) {
        
        face = faceManager.getFace();
        super.init(frame: frame, isPreview: isPreview)
        setAnimationTimeInterval( 1.0 / 30.0 );
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    // NSView
    
    override func drawRect(rect: NSRect) {
        super.drawRect(rect)
    }
    
    
    // ScreenSaverView
    
    override func animateOneFrame() {
        
        // Check changing font
        // @TODO: Does this belong in animateOneFrame... probably not.
        currentFrame++;
        if( currentFrame > totalFramesInSet ) {
            face = faceManager.getFace();
            currentFrame = 0;
        }
        
        var alphaValue: CGFloat;
        // Fade in
        if ( currentFrame < fadeTime ) {
            alphaValue = CGFloat( currentFrame ) / CGFloat( fadeTime );
        // Fade out
        } else if ( currentFrame > ( totalFramesInSet - fadeTime ) ) {
            alphaValue = CGFloat(1.0) -
                
                        CGFloat(currentFrame - (totalFramesInSet - fadeTime)) / CGFloat(fadeTime);
        } else {
            alphaValue = CGFloat(1.0);
        }
        
        fillBG();
        
        // Draw the face!
        var font: NSFont;
        font = NSFont(name: "HelveticaNeue", size: 124.0 );
        
        var paragraph: NSMutableParagraphStyle;
        paragraph = NSMutableParagraphStyle();
        paragraph.alignment = NSTextAlignment.CenterTextAlignment
        

        var textColor = NSColor(calibratedRed: 0.0, green: 0.0, blue: 0.0, alpha: alphaValue)
        
        var string: NSAttributedString;
        string = NSAttributedString(string: face, attributes: [
            NSFontAttributeName: font,
            NSParagraphStyleAttributeName: paragraph,
            NSForegroundColorAttributeName: textColor
        ]);
        
        var rect: NSRect;
        var size: NSSize;
        
        size = self.bounds.size;
        var stringSize = string.size;
        
        // @TODO: Does this need to be defined every single frame?
        rect = NSRect();
        rect.size = NSMakeSize( size.width, stringSize.height );
        rect.origin.x = 0.0;
        rect.origin.y = (size.height - stringSize.height) / 2;
    
        string.drawInRect( rect );

        
        return;
    }
    
    override func hasConfigureSheet() -> Bool {
      return false;
    }
    
    override func configureSheet() -> NSWindow! {
        return nil;
    }
    
    // Private
    func fillBG() {
        
        var path: NSBezierPath;
        var rect: NSRect;
        var size: NSSize;
        var color: NSColor;
        
        size = self.bounds.size;
        color = NSColor(calibratedRed: 0.98, green: 0.98, blue: 0.98, alpha: 1)

        rect = NSRect();
        rect.size = NSMakeSize( size.width, size.height );
        rect.origin.x = 0.0;
        rect.origin.y = 0.0;
        
        path = NSBezierPath( rect: rect );
        
        color.setFill();
        path.fill();
    }
}
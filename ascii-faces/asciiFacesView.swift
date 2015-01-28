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
    
    // Misc
    var size             = NSSize();
    var lightTheme       = false;
    var lightColor       = NSColor(calibratedRed: 0.98, green: 0.98, blue: 0.98, alpha: 1);
    var darkColor        = NSColor(calibratedRed: 0.02, green: 0.02, blue: 0.02, alpha: 1);
    
    
    
    // Frame management
    var currentFrame     = CGFloat(0.0);
    var totalFramesInSet = CGFloat(200.0);
    var fadeTime         = CGFloat(50.0); // frames.
    
    // Face management
    var face: String;
    var faceManager      = asciiFaceManager();

    // Background management
    var bgPath           = NSBezierPath();
    var bgColor          = NSColor();

    // Text Management
    var baseFaceColor    = NSColor();
    var faceColor        = NSColor();
    var textRect         = NSRect();
    var faceString       = NSAttributedString();
    var faceFont         = NSFont(name: "HelveticaNeue", size: 124.0 );
    var fontStyle        = NSMutableParagraphStyle();
    
    convenience override init() {
        self.init(frame: CGRectZero, isPreview: false);
    }
    
    override init(frame: NSRect, isPreview: Bool) {
        
        // Get first face
        face = faceManager.getFace();
        
        super.init(frame: frame, isPreview: isPreview);
        
        size = self.bounds.size;
        
        // Prepare background path.
        var bgRect = NSRect();
        bgRect.size = NSMakeSize( size.width, size.height );
        bgRect.origin.x = 0.0;
        bgRect.origin.y = 0.0;
        bgPath = NSBezierPath( rect: bgRect );
        
        // Set theme
        if( lightTheme == true ) {
            baseFaceColor = darkColor;
            bgColor       = lightColor;
        } else {
            baseFaceColor = lightColor;
            bgColor       = darkColor;
        }
        
        // Prepare text variables
        fontStyle.alignment = NSTextAlignment.CenterTextAlignment;
        
        setAnimationTimeInterval( 1.0 / 30.0 );
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: NSRect) {
        super.drawRect(rect)
    }
    
    override func hasConfigureSheet() -> Bool {
        return false;
    }
    
    override func configureSheet() -> NSWindow! {
        return nil;
    }
    
    // Main Loop
    override func animateOneFrame() {
        
        // Keep track of frames past, for changing and fading faces.
        currentFrame++;
        if( currentFrame > totalFramesInSet ) {
            face = faceManager.getFace();
            currentFrame = 0.0;
        }
        
        fillBG();
        
        faceColor = baseFaceColor.colorWithAlphaComponent( getTextAlpha() );
        faceString = NSAttributedString(string: face, attributes: [
            NSFontAttributeName: faceFont!,
            NSParagraphStyleAttributeName: fontStyle,
            NSForegroundColorAttributeName: faceColor
        ]);
        
        // Create rect in the center of the screen, based on the face string height.
        textRect = NSRect();
        textRect.size = NSMakeSize( size.width, faceString.size.height );
        textRect.origin.x = 0.0;
        textRect.origin.y = (size.height - faceString.size.height) / 2;
    
        faceString.drawInRect( textRect );
        
        return;
    }
    
    // Return the alpha value (fade in/out) for the text.
    func getTextAlpha() -> CGFloat {

        // Fade in
        if ( currentFrame < fadeTime ) {
        
            return (currentFrame / fadeTime);
    
        // Fade out
        } else if ( currentFrame > ( totalFramesInSet - fadeTime ) ) {
            
            return (1.0 - (currentFrame - (totalFramesInSet - fadeTime)) / fadeTime);
        }
        
        // Solid
        return 1.0;
    }
    
    // Private, clears the background
    func fillBG() {
        
        //Properties set during init.
        bgColor.setFill();
        bgPath.fill();
    }
}
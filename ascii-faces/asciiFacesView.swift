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
    
    
    // Initializers
    
    convenience init() {
        self.init(frame: CGRectZero, isPreview: false)
    }
    
    init(frame: NSRect, isPreview: Bool) {
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
        
        fillBG();
        
        // Draw the face!
        var font: NSFont;
        font = NSFont(name: "HelveticaNeue", size: 124.0 );
        
        var paragraph: NSMutableParagraphStyle;
        paragraph = NSMutableParagraphStyle();
        paragraph.alignment = NSTextAlignment.CenterTextAlignment
        
        
        var string: NSAttributedString;
        string = NSAttributedString(string: "(ノಠ益ಠ)ノ", attributes: [
            NSFontAttributeName: font,
            NSParagraphStyleAttributeName: paragraph
        ]);
        
        var rect: NSRect;
        var size: NSSize;
        
        size = self.bounds.size;
        var stringSize = string.size;
        
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
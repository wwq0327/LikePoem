//
//  FontStyle.swift
//  LikePoem
//
//  Created by wyatt on 16/3/1.
//  Copyright © 2016年 Wanqing Wang. All rights reserved.
//

import Foundation
import UIKit

struct FontID {
    static let fontSize = "fontSize"
    static let fontColor = "fontColor"
    static let fontName = "fontName"
    
    enum FontFamily: String {
        case Pingfang = "PingFangSC-Light"
        case Songkeben = "FZSKBXKJW--GB1-0"
        case Kaiti = "KaiTi"
        case Fangsong = "FangSong"
        case Wenyue = "Wyue-GutiFangsong-NC"
        case Zhao = "SentyZHAO"
    }
}

extension UILabel {
    func setLineHeight(lineHeight: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.0
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.alignment = self.textAlignment
        
        let attrString = NSMutableAttributedString(string: self.text!)
        attrString.addAttribute(NSFontAttributeName, value: self.font, range: NSMakeRange(0, attrString.length))
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        self.attributedText = attrString
    }
}

class PoeLabel: myUILabel {
    var textAttributes: [String: AnyObject]!
    
    convenience init(fontname: String, labelText: String, fontSize: CGFloat, lineHeight: CGFloat) {
        self.init(frame: CGRectZero)
        
        let font = UIFont(name: fontname, size: fontSize) as UIFont!
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineHeight
        
        textAttributes = [NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle]
        let labelSize = (labelText as NSString).boundingRectWithSize(CGSizeZero, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: textAttributes, context: nil)
        // 设定label的大小
        let _x = (UIScreen.mainScreen().bounds.width - labelSize.width) / 2
        self.frame = CGRectMake(_x, -60 , labelSize.width, labelSize.height)
        self.attributedText = NSAttributedString(string: labelText, attributes: textAttributes)
        self.lineBreakMode = NSLineBreakMode.ByCharWrapping
        self.numberOfLines = 0
        self.verticalAlignment = VerticalAlignmentTop
        self.textAlignment = .Center
    }
}
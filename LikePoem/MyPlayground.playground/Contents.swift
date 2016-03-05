//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

struct FontStyle {
    enum FontFamily: String {
        case FZSKBXKJW = "FZSKBXKJW--GB1-0"
        case FZFXJ = "fx"
    }
    
    enum FontColor: String {
        case black = "#000000"
    }
    
    enum FontSize: Int {
        case S = 16
        case M = 20
        case L = 24
    }
}

FontStyle.FontFamily.FZFXJ


var fontList = UIFont.familyNames()

for fontName in fontList {
    let lab = UILabel()
    lab.text = "你好，世界, Hello, world"
    lab.font = UIFont(name: fontName, size: 16)
}




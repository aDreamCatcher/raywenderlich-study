//
//  CTView.swift
//  CoreTextMagazine
//
//  Created by xin on 2018/7/11.
//  Copyright © 2018年 xin. All rights reserved.
//

import UIKit
import CoreText

class CTView: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // 2
        guard let context = UIGraphicsGetCurrentContext() else { return }
        // 3
        let path = CGMutablePath()
        path.addRect(bounds)
        // 4
        let attrString = NSAttributedString(string: "Hello World")
        // 5
        let framesetter = CTFramesetterCreateWithAttributedString(attrString)
        // 6
        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attrString.length), path, nil)
        // 7
        CTFrameDraw(frame, context)
        
    }
    

}

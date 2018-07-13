//
//  CTColumnView.swift
//  CoreTextMagazine
//
//  Created by xin on 2018/7/12.
//  Copyright © 2018年 xin. All rights reserved.
//

import UIKit

class CTColumnView: UIView {

    // MARK: - Properties
    var ctFrame: CTFrame!
    var images: [(image: UIImage, frame: CGRect)] = []
    
    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    required init(frame: CGRect, ctFrame: CTFrame) {
        super.init(frame: frame)
        self.ctFrame = ctFrame
        backgroundColor = .white
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.textMatrix = .identity
        context.translateBy(x: 0, y: bounds.size.height)
        context.scaleBy(x: 1.0, y: -1.0);
        
        CTFrameDraw(ctFrame, context)
        
        // draw image
        for imageData in images {
            if let image = imageData.image.cgImage {
                let imageBounds = imageData.frame
                context.draw(image, in: imageBounds)
            }
        }
    }
 

}

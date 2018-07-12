//
//  CTView.swift
//  CoreTextMagazine
//
//  Created by xin on 2018/7/11.
//  Copyright © 2018年 xin. All rights reserved.
//

import UIKit
import CoreText

class CTView: UIScrollView {
    
    // MARK: - Properties
    var imageIndex: Int!
    
    // 1
    func buildFrames(withAttrString attrString: NSAttributedString,
                     andImages images: [[String: Any]]) {
        // 2
        isPagingEnabled = true
        // 3
        let frameSetter = CTFramesetterCreateWithAttributedString(attrString as CFAttributedString)
        // 4
        var pageView = UIView()
        var textPos = 0
        var columnIndex: CGFloat = 0
        var pageIndex: CGFloat = 0
        let settings = CTSettings()
        // 5
        while textPos < attrString.length {
            if columnIndex.truncatingRemainder(dividingBy: settings.columnsPerPage) == 0{
                columnIndex = 0
                pageView = UIView(frame: settings.pageRect.offsetBy(dx: pageIndex * bounds.width, dy: 0))
                addSubview(pageView)
                // 2
                pageIndex += 1
            }
            // 3
            let columnXOrigin = pageView.frame.size.width / settings.columnsPerPage
            let columnOffset = columnIndex * columnXOrigin
            let columnFrame = settings.columnRect.offsetBy(dx: columnOffset, dy: 0)
            
            // 1
            let path = CGMutablePath()
            path.addRect(CGRect(origin: .zero, size: columnFrame.size))
            let ctFrame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(textPos, 0), path, nil)
            // 2
            let column = CTColumnView(frame: columnFrame, ctFrame: ctFrame)
            pageView.addSubview(column)
            // 3
            let frameRange = CTFrameGetVisibleStringRange(ctFrame)
            textPos += frameRange.length
            // 4
            columnIndex += 1
            
            contentSize = CGSize(width: CGFloat(pageIndex) * bounds.width,
                                 height: bounds.height)
        }
        
    }
    
    //
    func attachImagesWithFrame(_ images: [[String: Any]],
                               ctFrame: CTFrame,
                               margin: CGFloat,
                               columnView: CTColumnView) {
        // 1
        let lines = CTFrameGetLines(ctFrame) as NSArray
        
        <#function body#>
    }
    
}

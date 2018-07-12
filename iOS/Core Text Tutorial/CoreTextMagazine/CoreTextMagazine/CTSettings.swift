//
//  CTSettings.swift
//  CoreTextMagazine
//
//  Created by xin on 2018/7/12.
//  Copyright © 2018年 xin. All rights reserved.
//

import UIKit

class CTSettings {
    // 1
    // MARK: - Properties
    let margin: CGFloat = 20
    var columnsPerPage: CGFloat!
    var pageRect: CGRect!
    var columnRect: CGRect!
    
    // MARK: - Initializers
    init() {
        // 2
        columnsPerPage = UIDevice.current.userInterfaceIdiom == .phone ? 1 : 2
        // 3
        pageRect = UIScreen.main.bounds.insetBy(dx: margin, dy: margin)
        // 4
        columnRect = CGRect(x: 0,
                            y: 0,
                            width: pageRect.width / columnsPerPage,
                            height: pageRect.height).insetBy(dx: margin, dy: margin)
    }
}

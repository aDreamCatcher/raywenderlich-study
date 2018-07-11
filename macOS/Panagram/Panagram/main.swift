//
//  main.swift
//  Panagram
//
//  Created by xin on 2018/3/16.
//  Copyright © 2018年 lgy. All rights reserved.
//

import Foundation

let panagram = Panagram()
if CommandLine.argc < 2 {
    // TODO: Handle interactive code
} else {
    panagram.staticMode()
}


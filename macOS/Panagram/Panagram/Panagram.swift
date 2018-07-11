//
//  Panagram.swift
//  Panagram
//
//  Created by xin on 2018/3/16.
//  Copyright © 2018年 lgy. All rights reserved.
//

import Foundation

enum OptionType: String {
    case palindrome = "p"
    case anagram = "a"
    case help = "h"
    case unkown
    
    init(value: String) {
        switch value {
        case "a": self = .anagram
        case "p": self = .palindrome
        case "h": self = .help
        default:
            self = .unkown
        }
    }
}

class Panagram {
    
    let consoleIO = ConsoleIO()
    
    func staticMode() {
        let argCount = CommandLine.argc
        let argument = CommandLine.arguments[1]
        
//        let (option, value) = getOption(argument.substring(from: argument.index(argument.startIndex, offsetBy: 1)))
        let index = argument.index(argument.startIndex, offsetBy: 1)
        let (option, value) = getOption(String(argument[..<index]))
        consoleIO.writeMessage("Argument count: \(argCount) Option: \(option) Value: \(value)")
    }
    
    func getOption(_ option: String) -> (option:OptionType, value:String) {
        return (OptionType(value: option), option)
    }
}

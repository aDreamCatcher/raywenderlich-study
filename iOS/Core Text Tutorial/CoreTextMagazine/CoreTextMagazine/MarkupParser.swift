//
//  MarkupParser.swift
//  CoreTextMagazine
//
//  Created by xin on 2018/7/12.
//  Copyright © 2018年 xin. All rights reserved.
//

import UIKit

class MarkupParser: NSObject {
    
    // MARK: - Properties
    var color: UIColor = .black
    var fontName: String = "Arial"
    var attrString: NSMutableAttributedString!
    var images: [[String: Any]] = []
    
    // MARK: - Initializers
    override init() {
         super.init()
    }
    
    // MARK: - Internal
    func parseMarkup(_ markup: String) {
        // 1
        attrString = NSMutableAttributedString(string: "")
        // 2
        do {
            let regex = try NSRegularExpression(pattern: "(.*?)(<[^>]+>|\\Z)",
                                                options:[.caseInsensitive,
                                                         .dotMatchesLineSeparators])
            let chunks = regex.matches(in: markup,
                                       options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                       range: NSRange(location: 0,
                                                      length: markup.count))
            
            let defaultFont: UIFont = .systemFont(ofSize: UIScreen.main.bounds.height / 40)
            
            // 1
            for chunk in chunks {
                // 2
                guard let markupRange = markup.range(from: chunk.range) else { continue }
                // 3
                let parts = markup[markupRange].components(separatedBy: "<")
                // 4
                let font = UIFont(name: fontName, size: UIScreen.main.bounds.size.height / 40) ?? defaultFont
                // 5
                let attrs = [NSAttributedStringKey.foregroundColor : color, NSAttributedStringKey.font : font] as [NSAttributedStringKey: Any]
                let text = NSMutableAttributedString(string: parts[0], attributes: attrs)
                attrString.append(text)
                
                // 1
                if parts.count <= 1 {
                    continue
                }
                let tag = parts[1]
                // 2
                if tag.hasPrefix("font") {
                    // 非获取匹配，反向肯定预查
                    let colorRegex = try NSRegularExpression(pattern: "(?<=color=\")\\w+",
                                                             options: NSRegularExpression.Options(rawValue: 0))
                    colorRegex.enumerateMatches(in: tag, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, tag.count)) { (match, _, _) in
                        // 3
                        if let match = match,
                            let range = tag.range(from: match.range) {
                            let colorSel = NSSelectorFromString(tag[range]+"Color")
                            color = UIColor.perform(colorSel).takeRetainedValue() as? UIColor ?? .black
                        }
                    }
                    // 5
                    let faceRegex = try NSRegularExpression(pattern: "(?<=face=\")[^\"]+",
                                                            options: NSRegularExpression.Options(rawValue: 0))
                    faceRegex.enumerateMatches(in: tag, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, tag.count)) { (match, _, _) in
                        
                        if let match = match,
                            let range = tag.range(from: match.range) {
                            fontName = String(tag[range])
                        }
                    }
                } // end of font parsing
                else if tag.hasPrefix("img") {
                    
                    var filename: String = ""
                    let imgRegex = try NSRegularExpression(pattern: "(?<=src=\")[^\"]+",
                                                           options: NSRegularExpression.Options(rawValue: 0))
                    imgRegex .enumerateMatches(in: tag,
                                               options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                               range: NSMakeRange(0, tag.count)) { (match, _, _) in
                        
                        if let match = match,
                            let range = tag.range(from: match.range) {
                            filename = String(tag[range])
                        }
                    }
                    // 2
                    let settings = CTSettings()
                    var width: CGFloat = settings.columnRect.width
                    var height: CGFloat = 0
                    
                    if let image = UIImage(named: filename) {
                        height = width * (image.size.height / image.size.width)
                        // 3
                        if height > settings.columnRect.height - font.lineHeight {
                            height = settings.columnRect.height - font.lineHeight
                            width = height * (image.size.width / image.size.height)
                        }
                    }
                    
                    images += [["width": NSNumber(value: Float(width)),
                                "height": NSNumber(value: Float(height)),
                                "fileName": filename,
                                "location": NSNumber(value: attrString.length)]]
                    
                    struct RunStruct {
                        let ascent: CGFloat
                        let descent: CGFloat
                        let width: CGFloat
                    }
                    
                    let extentBuffer = UnsafeMutablePointer<RunStruct>.allocate(capacity: 1)
                    extentBuffer.initialize(to: RunStruct(ascent: height, descent: 0, width: width))
                    // 3
                    var callbacks = CTRunDelegateCallbacks(version: kCTRunDelegateVersion1, dealloc: { (pointer) in
                    }, getAscent: { (pointer) -> CGFloat in
                        let d = pointer.assumingMemoryBound(to: RunStruct.self)
                        return d.pointee.ascent
                    }, getDescent: { (pointer) -> CGFloat in
                        let d = pointer.assumingMemoryBound(to: RunStruct.self)
                        return d.pointee.descent
                    }) { (pointer) -> CGFloat in
                        let d = pointer.assumingMemoryBound(to: RunStruct.self)
                        return d.pointee.width
                    }
                    // 4
                    let delegate = CTRunDelegateCreate(&callbacks, extentBuffer)
                    // 5
                    let attrDictionaryDelegate = [(kCTRunDelegateAttributeName as NSAttributedStringKey): (delegate as Any)]
                    attrString.append(NSAttributedString(string: " ", attributes: attrDictionaryDelegate))
                    
                }
                
            }
        } catch _ {
        }
    }

}

// AMRK: - String
extension String {
    
    // NSRange -> Range
    func range(from range: NSRange) -> Range<String.Index>? {
        
        // swift 4
        return Range(range, in: self)
        
//        // swift 3
//        guard let from16 = utf16.index(utf16.startIndex,
//                                       offsetBy: range.location,
//                                       limitedBy: utf16.endIndex),
//        let to16 = utf16.index(from16, offsetBy: range.length, limitedBy: utf16.endIndex),
//        let from = String.Index(from16, within: self),
//            let to = String.Index(to16, within: self) else {
//                return nil
//        }
//
//        return from ..< to
    }
    
    // Range -> NSRange
    func nsRange(from range: Range<String.Index>) -> NSRange {
        // swift 4
        return NSRange(range, in: self)
        
//        // swift 3
//        let from = range.lowerBound.samePosition(in: utf16)
//        let to = range.upperBound.samePosition(in: utf16)
//        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from),
//                       length: utf16.distance(from: from, to: to))

    }
    
    
    
}

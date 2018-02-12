//
//  ViewController.swift
//  MadLibs
//
//  Created by xin on 2018/2/11.
//  Copyright © 2018年 lgy. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var pastTenseVerbTextField: NSTextField!
    @IBOutlet weak var singularNounCombo: NSComboBox!
    @IBOutlet weak var pluralNounPopup: NSPopUpButton!
    @IBOutlet var phraseTextView: NSTextView!
    
    fileprivate let singularNouns = ["dog", "muppet", "ninja", "pirate", "dev"]
    fileprivate let pluralNouns = ["tacos", "rainbows", "iPhones", "gold coins"]
    
    fileprivate let synth = NSSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Sets the default text for the pastTenseVerbTextField property
        pastTenseVerbTextField.stringValue = "ate"
        
        // Setup the combo box with singular nouns
        singularNounCombo.removeAllItems()
        singularNounCombo.addItems(withObjectValues: singularNouns)
        singularNounCombo.selectItem(at: singularNouns.count-1)
        
        // Setup the pop up button with plular nouns
        pluralNounPopup.removeAllItems()
        pluralNounPopup.addItems(withTitles: pluralNouns)
        pluralNounPopup.selectItem(at: 0)
        
        // Setup the default text to display in the text view
        phraseTextView.string = "Me coding Mac Apps!!!"
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    // MARK: button actions
    @IBAction func goButtonClicked(_ sender: Any) {
        let pastTenseVerb = pastTenseVerbTextField.stringValue
        let singularNoun = singularNounCombo.stringValue
        let pluralNoun = pluralNouns[pluralNounPopup.indexOfSelectedItem]
        let phrase = phraseTextView.string
        
        let madLibSentence = "A \(singularNoun) \(pastTenseVerb) \(pluralNoun) and said, \(phrase)"
        
        readSentence(madLibSentence, rate: .normal)
        print("\(madLibSentence)")
    }
    
}

// MARK: speech sentence
extension ViewController {
    fileprivate enum VoiceRate: Int {
        case slow
        case normal
        case fast
        
        var speed: Float {
            switch self {
            case .slow:
                return 60
            case .normal:
                return 175
            case .fast:
                return 360
            }
        }
    }
    
    fileprivate func readSentence(_ sentence: String, rate: VoiceRate) {
        synth.rate = Float(rate.rawValue)
        synth.stopSpeaking()
        synth.startSpeaking(sentence)
    }
}


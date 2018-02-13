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
    @IBOutlet weak var amountLabel: NSTextField!
    @IBOutlet weak var amountSlider: NSSlider!
    @IBOutlet weak var datePicker: NSDatePicker!
    
    @IBOutlet weak var rwDevConRadioButton: NSButton!
    @IBOutlet weak var threeSixtyRadioButton: NSButton!
    @IBOutlet weak var wwdcRadioButton: NSButton!
    @IBOutlet weak var yellCheck: NSButton!
    
    @IBOutlet weak var voiceSegmentControl: NSSegmentedControl!
    @IBOutlet weak var resultTextField: NSTextField!
    @IBOutlet weak var imageView: NSImageView!
    
    fileprivate let singularNouns = ["dog", "muppet", "ninja", "pirate", "dev"]
    fileprivate let pluralNouns = ["tacos", "rainbows", "iPhones", "gold coins"]
    
    fileprivate let synth = NSSpeechSynthesizer()
    
    fileprivate var selectedPlace: String {
        var place = "home"
        if rwDevConRadioButton.state == .on {
            place = "RWDevCon"
        }
        else if threeSixtyRadioButton.state == .on {
            place = "360iDev"
        }
        else if wwdcRadioButton.state == .on {
            place = "WWDC"
        }
        return place
    }
    
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
        
        // Set amount label text
        sliderChanged(self)
        
        // Set the date picker to display current date
        datePicker.dateValue = Date()
        
        // Set the radio group's initial selection
        rwDevConRadioButton.state = .on
        // Set check button state
        yellCheck.state = .off
        // Set the segmented control initial selection
        voiceSegmentControl.selectedSegment = 1
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    // MARK: actions
    @IBAction func sliderChanged(_ sender: Any) {
        let amount = amountSlider.integerValue
        amountLabel.stringValue = "Amount: [\(amount)]"
    }
    
    @IBAction func radioButtonChanged(_ sender: AnyObject) {
        
    }
    
    @IBAction func goButtonClicked(_ sender: Any) {
        let pastTenseVerb = pastTenseVerbTextField.stringValue
        let singularNoun = singularNounCombo.stringValue
        let amount = amountSlider.integerValue
        let pluralNoun = pluralNouns[pluralNounPopup.indexOfSelectedItem]
        let phrase = phraseTextView.string
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        let date = dateFormatter.string(from: datePicker.dateValue)

        var voice = "said"
        if yellCheck.state == .on {
            voice = "yelled"
        }
        
        let madLibSentence = "On \(date), at \(selectedPlace) a \(singularNoun) \(pastTenseVerb) \(amount) \(pluralNoun) and \(voice), \(phrase)"
        
        resultTextField.stringValue = madLibSentence
        imageView.image = NSImage(named: NSImage.Name(rawValue: "face"))
        
        let selectedSegment = voiceSegmentControl.selectedSegment
        let voiceRate = VoiceRate(rawValue: selectedSegment) ?? .normal
        readSentence(madLibSentence, rate: voiceRate)
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


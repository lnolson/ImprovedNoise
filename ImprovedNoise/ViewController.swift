//
//  ViewController.swift
//  ImprovedNoise
//
//  Created by Loren Olson on 6/30/16.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var graphics: Graphics!
    @IBOutlet weak var octavesTextField: NSTextField!
    @IBOutlet weak var octavesSlider: NSSlider!
    @IBOutlet weak var gainTextField: NSTextField!
    @IBOutlet weak var lacunarityTextField: NSTextField!
    @IBOutlet weak var frequencyTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear() {
        print("\(graphics.octaves)")
        self.octavesSlider.integerValue = graphics.octaves
        self.octavesTextField.integerValue = graphics.octaves
        self.gainTextField.doubleValue = graphics.gain
        self.lacunarityTextField.doubleValue = graphics.lacunarity
        self.frequencyTextField.doubleValue = graphics.frequency
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


    @IBAction func octavesSliderAction(_ sender: AnyObject) {
        graphics.octaves = self.octavesSlider.integerValue
        self.octavesTextField.integerValue = self.octavesSlider.integerValue
        graphics.needsDisplay = true
    }
    
    @IBAction func gainAction(_ sender: AnyObject) {
        graphics.gain = self.gainTextField.doubleValue
        graphics.needsDisplay = true
    }
    
    @IBAction func lacunarityAction(_ sender: AnyObject) {
        graphics.lacunarity = self.lacunarityTextField.doubleValue
        graphics.needsDisplay = true
    }
    
    @IBAction func frequencyAction(_ sender: AnyObject) {
        graphics.frequency = self.frequencyTextField.doubleValue
        graphics.needsDisplay = true
    }
    
    
}


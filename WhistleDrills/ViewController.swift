//
//  ViewController.swift
//  WhistleDrills
//
//  Created by Shane Liesegang on 10/30/17.
//  Copyright © 2017 Shane Liesegang. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSWindowDelegate {

    let defaults: UserDefaults = UserDefaults.standard
    
    @IBOutlet weak var noteView: NSImageView!
    @IBOutlet weak var fingeringView: NSImageView!
    
    @IBOutlet weak var revealDelaySlider: NSSlider!
    @IBOutlet weak var changeDelaySlider: NSSlider!
    @IBOutlet weak var revealLabel: NSTextField!
    @IBOutlet weak var changeLabel: NSTextField!
    
    @IBAction func revealChanged(sender: NSSlider) {
        revealLabel.stringValue = String(format: "%.2f", revealDelaySlider.doubleValue)
        self.defaults.set(revealDelaySlider.doubleValue, forKey: "revealDelay")
    }
    @IBAction func changeChanged(sender: NSSlider) {
        changeLabel.stringValue = String(format: "%.2f", changeDelaySlider.doubleValue)
        self.defaults.set(changeDelaySlider.doubleValue, forKey: "changeDelay")
    }
    
    func syncUI() {
        revealDelaySlider.doubleValue = self.defaults.double(forKey: "revealDelay")
        changeDelaySlider.doubleValue = self.defaults.double(forKey: "changeDelay")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        syncUI()
        revealLabel.stringValue = String(format: "%.2f", revealDelaySlider.doubleValue)
        changeLabel.stringValue = String(format: "%.2f", changeDelaySlider.doubleValue)
        
        pickNewNote()
    }
    
    override func viewWillAppear() {
        self.view.window?.delegate = self
        setSubSizes()
    }
    
    func windowDidResize(_ notification: Notification) {
        setSubSizes()
    }
    
    func setSubSizes() {
        let windowBounds = self.view.bounds
        let noteBounds = NSRect(x: 0, y: 0, width: windowBounds.width * 0.6, height: windowBounds.height)
        let fingerBounds = NSRect(x: noteBounds.width, y:0, width: windowBounds.width * 0.4, height: windowBounds.height)
        
        noteView.frame = noteBounds
        fingeringView.frame = fingerBounds
    }
    
    var currentNote: String = ""
    var revealTimer: Timer!
    var changeTimer: Timer!
    
    func pickNewNote() {
        var notes: [String] = ["D", "E", "F", "G", "A", "B", "C", "D+"]
        if (currentNote != "") {
            notes.remove(at: notes.index(of: currentNote)!)
        }
        let noteIndex = Int(arc4random_uniform(UInt32(notes.count)))
        
        currentNote = notes[noteIndex];
        
        noteView.image      = NSImage(named: NSImage.Name(currentNote + "_note.pdf"))
        fingeringView.image = NSImage(named: NSImage.Name(currentNote + "_fingering.pdf"))
        fingeringView.isHidden = true
        
        revealTimer = Timer.scheduledTimer(withTimeInterval: revealDelaySlider.doubleValue, repeats: false) {
            _ in
            self.revealFingering()
        }
    }
    
    func revealFingering() {
        let duration: Double = 3.0
        
        changeTimer = Timer.scheduledTimer(withTimeInterval: changeDelaySlider.doubleValue + duration, repeats: false) {
            _ in
            self.pickNewNote()
        }
        
        NSAnimationContext.beginGrouping()
        NSAnimationContext.current.duration = duration
        fingeringView.animator().isHidden = false
        NSAnimationContext.endGrouping()
    }

}


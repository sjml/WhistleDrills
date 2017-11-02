//
//  AppDelegate.swift
//  WhistleDrills
//
//  Created by Shane Liesegang on 10/30/17.
//  Copyright © 2017 Shane Liesegang. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let defaults: UserDefaults = UserDefaults.standard

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        defaults.set(true, forKey: "NSQuitAlwaysKeepsWindows")
        NSApplication.shared.mainWindow?.backgroundColor = NSColor(red: 1, green: 1, blue: 1, alpha: 1)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }


}


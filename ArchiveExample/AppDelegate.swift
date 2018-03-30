//
//  AppDelegate.swift
//  ArchiveExample
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification)
    {
        // Path to the .caar file
        //
        guard let emojiURL = Bundle.main.url(forResource: "Emoji", withExtension: "caar") else { return }

        // Read the .caar file into memory
        //
        guard let emojiData = try? Data(contentsOf: emojiURL) else { return }

        // Unarchive the NSKeyedArchive as a Dictionary
        //
        guard let rootObject = (try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(emojiData)) as? [String: Any] else { return }

        // Pull out the 'rootLayer' object containing the archived CALayer
        //
        guard let rootLayer = rootObject["rootLayer"] as? CALayer else { return }

        // Start the rootLayer's timeline at the current time
        //
        rootLayer.beginTime = CACurrentMediaTime()

        // Add it to the layer hierarchy
        //
        self.window.contentView?.wantsLayer = true
        self.window.contentView?.layer?.addSublayer(rootLayer)
    }
}

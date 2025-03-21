//
//  AppDelegate.swift
//  Timelist
//
//  Created by Jason Qiu on 3/21/25.
//


import Cocoa
import SwiftUI
import Combine

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem!
    var popover = NSPopover()
    var timerManager = TimerManager()
    
    var iconCancellable: AnyCancellable?


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusItem.button {
            let config = NSImage.SymbolConfiguration(pointSize: 16, weight: .semibold, scale: .large)
            if let icon = NSImage(systemSymbolName: "clock.fill", accessibilityDescription: "Timer")?.withSymbolConfiguration(config) {
                button.image = icon
            }
            button.action = #selector(togglePopover(_:))
        }

        let contentView = TimerListView(timerManager: timerManager)
            .environmentObject(timerManager)

        popover.contentViewController = NSHostingController(rootView: contentView)

        popover.contentSize = NSSize(width: 280, height: 240)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: contentView)
        
        iconCancellable = timerManager.$statusIconName
            .receive(on: RunLoop.main)
            .sink { [weak self] iconName in
                if let button = self?.statusItem.button {
                    button.image = NSImage(systemSymbolName: iconName, accessibilityDescription: "Timer")
                }
            }
    }

    @objc func togglePopover(_ sender: Any?) {
        if popover.isShown {
            popover.performClose(sender)
        } else if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
        }
    }
}

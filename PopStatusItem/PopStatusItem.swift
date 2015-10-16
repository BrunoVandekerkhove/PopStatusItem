//
//  PopStatusItem.swift
//  PopStatusItem
//
//  Created by Adam Hartford on 4/24/15.
//  Copyright (c) 2015 Adam Hartford. All rights reserved.
//

import Cocoa

public class PopStatusItem: NSObject {
    
    public var windowController: NSWindowController?
    
    public let popover = NSPopover()
    
    let dummyMenu = NSMenu()
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSSquareStatusItemLength)
    
    var myWindow: NSWindow!
    var active = false
    var popoverTransiencyMonitor: AnyObject?

    public init(image: NSImage) {
        super.init()
        
        if let button = statusItem.button {
            image.template = true
            button.image = image
            button.appearsDisabled = false
            button.target = self
            button.action = "togglePopover"
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillResignActive:", name: NSApplicationWillResignActiveNotification, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func togglePopover() {
        if active {
            hidePopover()
        } else {
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, 0)
            dispatch_after(delayTime, dispatch_get_main_queue()) { [weak self] in
                self?.statusItem.button?.highlighted = true
            }
            
            showPopover()
        }
    }
    
    func showPopover() {        
        active = true
        statusItem.popUpStatusItemMenu(dummyMenu)
        
        if let _ = windowController?.window {
            popover.contentViewController = windowController?.contentViewController
            popover.showRelativeToRect(NSZeroRect, ofView: statusItem.button!, preferredEdge: .MinY)
            popoverTransiencyMonitor = NSEvent.addGlobalMonitorForEventsMatchingMask([NSEventMask.LeftMouseDownMask, NSEventMask.RightMouseDownMask], handler: { [weak self] event in
                self?.hidePopover()
            })
        }
    }
    
    func hidePopover() {
        active = false
        statusItem.button!.highlighted = false
        popover.close()
        if let monitor: AnyObject = popoverTransiencyMonitor {
            NSEvent.removeMonitor(monitor)
        }
    }
    
    public func applicationWillResignActive(notification: NSNotification) {
        if active {
            hidePopover()
        }
    }
    
}

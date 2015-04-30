# PopStatusItem
Shows an NSPopover from the status bar. Uses NSWindowController with an NSPanel overlay for the look/feel and user interactions you expect in menu bar applications. Supports dark mode on Yosemite.

![Screenshot](https://db.tt/3onYeACR)

## Installation
CocoaPods (TODO)

Carthage (TODO)

## Usage
```swift
func applicationDidFinishLaunching(aNotification: NSNotification) {
    let popStatusItem = PopStatusItem.new()
    let storyboard = NSStoryboard(name: "Main", bundle: nil)
    popStatusItem.windowController = storyboard!.instantiateControllerWithIdentifier("PopStatusItem") as? NSWindowController
    popStatusItem.image = NSImage(named: "statusImage")
    popStatusItem.alternateImage = NSImage(named: "alternateImage")
}
```

To recreate the demo application:

1. Add LSUIElement=YES to Info.plist.
2. Uncheck "Is Initial Controller" in Main.storyboard window controller.
3. Change window controller Class to PopStatusItemPanel and Module to PopStatusItem.

### License
PopDatePicker is released under the MIT license. See LICENSE for details.

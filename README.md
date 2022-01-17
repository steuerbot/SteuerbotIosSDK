# Steuerbot iOS SDK

This Swift Package allows you to add the Steuerbot SDK to your iOS App.

## Installation

### Add the Swift Package to your Project
Add the package by selecting `File` → `Add Packages…` in Xcode’s menu bar. Search for the Steuerbot SDK using the repo's URL:

```console
https://github.com/steuerbot/ios-sdk.git
```

Then, select `Add Package`.

### Embed the Framework

Make sure `Steuerbot` is added to `Frameworks, Libraries and Embedded Content` in your apps target.


## Usage

Present the Steuerbot ViewController
```swift
import Steuerbot
...
let framework = SteuerbotSDK()
let controller = UIViewController()
controller.view = framework.getView()
self.present(controller, animated: true, completion: nil)
```

## License
[TODO](https://todo.de)

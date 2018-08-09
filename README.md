# Estimote Mirror iOS SDK

[Estimote Mirror]: http://blog.estimote.com/post/150398268230/launching-estimote-mirror-the-worlds-first

[![CocoaPod Version](https://cocoapod-badges.herokuapp.com/v/EstimoteMirror/badge.png)](http://cocoapods.org/pods/estimotemirror)
[![Apache License 2.0](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](https://tldrlegal.com/license/apache-license-2.0-(apache-2.0))

*This SDK allows you to take control of the big screen from your iOS app with [Estimote Mirror][]*.

**Main features:**

* *Building Mirror experience based on mobile SDKs* - you can start prototyping your first Mirror application, using only mobile Display SDK. There is no need to upload any code or resources upfront to the Mirror.

* *Pre-defined views* - No need to design your first Mirror app view. iOS Mirror SDK lets you define customized screens based on pre-defined views; All you need to do is to declare basic styling and data.

* *Feedback from Mirror screen to mobile* - Whenever any display action is triggered, your mobile app gets notified about it. You can handle successful screen change and perform further actions inside your mobile app.

Please check the rest of README to get further details.

We really appreciate your [feedback about our SDKs](#your-feedback-and-questions), thank you!

# Table of Contents

* [Installation](#installation)
* [Quick start](#quick-start)
* [Your feedback and questions](#your-feedback-and-questions)
* [Changelog](#changelog)
* [License](#license)

# Installation

## Prerequisities
* 1 [Estimote Mirror][] w/ **1.0.15+** firmware version.
* An account in [Estimote Cloud](https://cloud.estimote.com/).
* An iOS device with Bluetooth Low Energy support. We suggest using iOS 10.0+ (on iPhone 5s or newer).

## Pod

Install via [CocoaPods](https://cocoapods.org/):
- `$ pod init` in the project root directory
- Edit your Podfile to include the following repositories under your project target
~~~ 
  pod 'EstimoteMirror'
  pod 'EstimoteBluetoothScanning'
  pod 'EstimoteProximitySDK'
~~~
- `$ pod install`

## Obtain app credentials from Estimote Cloud

To obtain Estimote Cloud credentials for your mobile application:

1. Log in to your [Estimote Cloud](https://cloud.estimote.com/) account.
2. Go to *Apps* section and click `Add new app` option.
3. Select `Your own app` option.
4. Save your *App Id/App Token* credentials.

# Quick start

Here is simple example for showing Poster View on the screen, when user appears in Mirror nearby range.

```Swift
// Declare mirrorClient and proximityObserver as class properties
let mirrorClient = MirrorClient(appID: "", appToken: "")
var proximityObserver: EPXProximityObserver!

// Inside you class implementation
// Prepare your customized Poster View
let sneakersBanner = Poster() { p in
            
    p.header = "Exceptional traction\nfrom your first to final mile"
    p.body = "Now 20% off!"
    p.image = .preloaded(path: "shoe_big.jpg")
    
    p.style = PosterStyle() { ps in
        
        ps.imagePosition = Position(horizontal: .center, vertical: .top(offset: 80))
        ps.textPosition = Position(horizontal: .center, vertical: .bottom(offset: 80))
        ps.textAlign = .center
        ps.headerFontSize = .percent(130)
    }
}
        
// Initialize your Estimote Cloud credentials
let credentials = CloudCredentials(appID: "", appToken: "")

// Build ProximityObserver with Cloud credentials
self.proximityObserver = ProximityObserver(credentials: credentials, onError: { error in
    
    print("\(error)")
})

// Define near proximity zone
let mirrorZone = ProximityZone(tag: "mirror", range: ProximityRange.near)
mirrorZone.onEnter = { zoneContext in
   
    print("Enter mirror")
    self.mirrorClient.display(sneakersBanner, onMirror: zoneContext.deviceIdentifier)
}
mirrorZone.onExit = { zoneContext in
    
    print("Exit mirror")
}

// Start proximity observation
self.proximityObserver.startObserving([mirrorZone])
```

Zone monitoring is based on Estimote Proximity SDK - the most reliable signal-processing technology.

To get more details, you can check out README for [iOS-Proximity-SDK](https://github.com/Estimote/iOS-Proximity-SDK).

# Your feedback and questions

At Estimote we believe in open feedback! Here are some common ways to share your thoughts with us:

* Posting issue/question/enhancement on [our issues page](../../../issues).
* Asking our community managers on our [Estimote SDK for Android forum](https://forums.estimote.com).

# Changelog

To see what has changed in recent versions of our SDK, please visit [our releases page](../../../releases).

# License

[Apache 2.0](../license.txt)


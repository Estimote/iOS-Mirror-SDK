# Estimote Mirror iOS SDK

**Take control of the big screen from your iOS app with [Estimote Mirror][]**

[Estimote Mirror]: http://blog.estimote.com/post/150398268230/launching-estimote-mirror-the-worlds-first

[![CocoaPod Version](https://cocoapod-badges.herokuapp.com/v/EstimoteMirror/badge.png)](http://cocoapods.org/pods/estimotemirror)
[![Feature requests](https://img.shields.io/badge/feature%20request-canny.io-blue.svg)](https://estimote.canny.io/mirror-display)
[![Apache License 2.0](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](https://tldrlegal.com/license/apache-license-2.0-(apache-2.0))
[![MirrorCore](https://www.bitrise.io/app/13e64565384ed7f0/status.svg?token=UrwNNk7xp6qd2BDglzidDw)](https://www.bitrise.io/app/13e64565384ed7f0)
[![Chat on Gitter](https://img.shields.io/gitter/room/nwjs/nw.js.svg)](https://gitter.im/EstimoteMirror/Mirror-SDK-iOS)

**Got a question?** Join us on [Gitter][], or head over to our [community forums][].

[Gitter]: https://gitter.im/EstimoteMirror
[community forums]: https://forums.estimote.com

**Table of Contents:**

* [Getting started](#getting-started)
   + [Hello, world!](#hello-world)
* [Documentation](#documentation)
* [Installing via CocoaPods](#pod)
* [Known issues or things worth knowing](#known-issues-or-things-worth-knowing)
* ["Work in progress" disclaimer](#work-in-progress-disclaimer)

## Getting started

Clone or download this repo, open MirrorDisplay.xcodeproj, and run the bundled Examples.

Want to integrate it with your own app?

1. Copy this repo into a subdirectory of your project, e.g., `MyProject/MirrorSDK`.

2. Open your project, e.g., `MyProject/MyProject.xcodeproj`. Drag the **MirrorDisplay.xcodeproj** and **MirrorContextSDK.framework** from the `MirrorSDK` folder into the Project Navigator. Verify that the checkbox next to your app's target is selected.

   (You can check out one of the Examples' "Dependencies" group to see what it should look like.)

3. Go to your project's settings, the *General* tab.

4. Add **MirrorDisplay.framework** and **MirrorContextSDK.framework** into the *Embedded Binaries* section.

   (Again, when in doubt, you can compare your General tab to that from one of the Examples.)

### Hello, world!

```swift
import MirrorDisplay

class ViewController: UIViewController {

  let mirrorClient = MirrorClient()

  override func viewDidLoad() {
    super.viewDidLoad()

    let hello = Poster() { p in
      p.header = "Hello, world!"
      p.body = "The programmable screen is here."
      p.image = .preloaded(path: "shoe_big.jpg")

      p.style = PosterStyle() { ps in
        ps.textAlign = .center
        ps.textPosition = Position(horizontal: .center, vertical: .bottom(offset: 80))
        ps.imagePosition = Position(horizontal: .center, vertical: .top(offset: 80))
      }
    }

    mirrorClient.display(hello, inProximity: .near)
  }
}
```

## Documentation

We have extensive documentation available on [Estimote Developer Portal](http://developer.estimote.com).

The best place to get started is with … [Intro to Estimote Mirror](http://developer.estimote.com/mirror/)!

## Pod

Install via [CocoaPods](https://cocoapods.org/):
- `$ pod init` in the project root directory
- Edit your Podfile to include `pod 'EstimoteMirror', '~> 0.1.6'` under your project target
- `$ pod install`

If you need Carthage support, let us know by submitting a feature request or just chat with us over Gitter! (see the badges above)

## Known issues or things worth knowing

- "MirrorContextSDK" will soon be renamed to "MirrorCore"
  - MirrorCore is our framework for discovery, authentication, connection, and sending data to Mirrors
  - MirrorDisplay is a layer on top of that, to provide a convenient way of showing things on Mirror

- `MirrorClient` currently tries to connect to any and all Mirror devices it finds
  - If you want to restrict that: for now, a workaround is to tweak the filter in the `startDeviceDiscovery` call, inside the `ConnectivityService`'s `init`

- Proximity zone thresholds are currently kind of hard-coded in the `Proximity.swift` file
  - For now, you can simply tweak them in there
  - To help with this, there's debug messages with observed RSSI logged in the Xcode console

## "Work in progress" disclaimer

The APIs are not yet considered stable and will likely change … for better, and more powerful, naturally 😇 We'll be providing detailed changelogs and migration advice as we go.

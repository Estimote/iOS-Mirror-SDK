# Estimote Mirror iOS SDK

**Take control of the big screen from your iOS app with [Estimote Mirror][]**

[Estimote Mirror]: http://blog.estimote.com/post/150398268230/launching-estimote-mirror-the-worlds-first

[![Feature requests](https://img.shields.io/badge/feature%20request-canny.io-blue.svg)](https://estimote.canny.io/mirror-display)
[![MIT license](https://img.shields.io/github/license/mashape/apistatus.svg)](https://opensource.org/licenses/MIT)
[![Build status](https://www.bitrise.io/app/c4fe0dd6bb4bca8f/status.svg?token=dty-BSZ34Wt5rRnmzgK43g&branch=master)]()
[![Chat on Gitter](https://img.shields.io/gitter/room/nwjs/nw.js.svg)](https://gitter.im/EstimoteMirror/Mirror-SDK-iOS)

**Got a question?** Join us on [Gitter][], or head over to our [community forums][].

[Gitter]: https://gitter.im/Estimote-Mirror-Display/Lobby
[community forums]: https://forums.estimote.com

## Get started

Clone or download this repo, open MirrorDisplay.xcodeproj, and run the bundled Examples.

Want to integrate it with your own app?

1. Copy this repo into a subdirectory of your project, e.g., "MyProject/MirrorSDK".

2. Open your project, e.g., "MyProject/MyProject.xcodeproj". Drag the "MirrorDisplay.xcodeproj" and "MirrorContextSDK.framework" from the "MirrorSDK" folder into the Project Navigator. Verify that the checkbox next to your app's target is selected.

   (You can check out one of the Examples' "Dependencies" group to see what it should look like.)

3. Go to your project's settings, the "General" tab.

4. Add "MirrorDisplay.framework" and "MirrorContextSDK.framework" into the "Embedded Binaries" section.

   (Again, when in doubt, you can compare your General tab to that from one of the Examples.)

_For easier installation, we'll be adding CocoaPods and Carthage support in the future._

## Time for a Hello World!

If you've seen the Examples, you probably know the drill already 🤓

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

## How does it work?

There are HTML5 web apps loaded on Mirror. We call them "templates", as they're meant to be filled in with context/content from the mobile app.

For example, you could build a "flight info" template—that is, an HTML5 website with some JavaScript that takes flight data sent to it from your mobile app, puts it in the appropriate places, and shows it on the screen. _We'll have more documentation on how to build your own templates soon._

We've also built a "special" template that provides some ready-made views you can use right away, without having to build your own HTML5 template first. Currently, these are:

- `Poster`, i.e., some call-out text ("header" and "body") and an image
- `Table`, i.e., a … table 🙃 _Coming to the iOS SDK soon!_

We'll be expanding the capabilities of this special template, so let us know what views and customization options you'd like to see!

## Known issues or things worth knowing

- "MirrorContextSDK" will soon be renamed to "MirrorCore"
  - MirrorCore is our framework for discovery, authentication, connection, and sending data to Mirrors
  - MirrorDisplay is a layer on top of that, to provide a convenient way of showing things on Mirror

- `MirrorClient` currently tries to connect to any and all Mirror devices it finds
  - If you want to restrict that: for now, a workaround is to tweak the filter in the `startDeviceDiscovery` call, inside the `ConnectivityService`'s `init`

- Proximity zone thresholds are currently kind of hard-coded in the `Proximity.swift` file
  - For now, you can simply tweak them in there
  - To help with this, there's debug messages with observed RSSI logged in the Xcode console

## API reference?

_Coming soon!_ For now, you can browse the source code of the MirrorDisplay framework, and the header files of the MirrorContextSDK framework. And naturally, syntax completion is your friend too!

## "Work in progress" disclaimer

The APIs are not yet considered stable and will likely change … for better, and more powerful, naturally 😇 We'll be providing detailed changelogs and migration advice as we go.

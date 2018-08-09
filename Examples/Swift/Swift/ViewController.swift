import UIKit

import MirrorDisplay
import EstimoteProximitySDK

class ViewController: UIViewController {

    let mirrorClient = MirrorClient(appID: "", appToken: "")
    var proximityObserver: EPXProximityObserver!


    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        let credentials = CloudCredentials(appID: "", appToken: "")
        self.proximityObserver = ProximityObserver(credentials: credentials, onError: { error in
            print("\(error)")
        })
        
        let mirrorZone = ProximityZone(tag: "mirror", range: ProximityRange.near)
        mirrorZone.onEnter = { zoneContext in
            print("Enter mirror")
            self.mirrorClient.display(sneakersBanner, onMirror: zoneContext.deviceIdentifier)
        }
        mirrorZone.onExit = { zoneContext in
            print("Exit mirror")
        }

        self.proximityObserver.startObserving([mirrorZone])
    }
}

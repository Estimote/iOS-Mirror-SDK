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
            p.image = .preloaded(path: "shoe_big.jpg")
            
            p.style = PosterStyle() { ps in
                ps.imagePosition = Position(horizontal: .center, vertical: .top(offset: 80))
                ps.textPosition = Position(horizontal: .center, vertical: .bottom(offset: 80))
                ps.textAlign = .center
                ps.headerFontSize = .percent(130)
            }
        }
        
        let credentials = EPXCloudCredentials(appID: "", appToken: "")
        self.proximityObserver = EPXProximityObserver(credentials: credentials, errorBlock: { error in
            print("\(error)")
        })
        
        let mirrorZone = EPXProximityZone(range: EPXProximityRange.near,
                                             tag: "mirror")
        mirrorZone.onEnterAction = { zoneContext in
            print("Enter mirror")
            self.mirrorClient.display(sneakersBanner, onMirror: zoneContext.deviceIdentifier)
        }
        mirrorZone.onExitAction = { zoneContext in
            print("Exit mirror")
        }

        self.proximityObserver.startObserving([mirrorZone])
    }
}

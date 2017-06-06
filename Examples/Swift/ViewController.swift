import UIKit

import MirrorDisplay

class ViewController: UIViewController {

    let mirrorClient = MirrorClient()

    override func viewDidLoad() {
        super.viewDidLoad()

        let appReady = Poster() { p in

            p.header = "Discover Mirror with\nthe Estimote App"
            p.body = "See the Mirror Demos to learn\nhow Mirror works and what you\ncan use it for."
            p.image = .preloaded(path: "estimote_app.png")

            p.style = PosterStyle() { ps in
                ps.imagePosition = Position(horizontal: .right(offset: 190), vertical: .top(offset: 5))
                ps.backgroundImage = .preloaded(path: "voronoi_bg.png")
                ps.fontColor = UIColor(red: 0x82/255.0, green: 0x86/255.0, blue: 0xE0/255.0, alpha: 1.0)
                ps.headerFontColor = .white
            }
        }

        mirrorClient.display(appReady, inProximity: .far)

        //

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

        mirrorClient.display(sneakersBanner, inProximity: .mid)

        //

        let sneakersDetails = Poster() { p in

            p.header = "New Sneakers"
            p.body = "Experience smooth support, a secure\nmid-foot wrap, a streamlined look,\nand our new cushioning system on\nyour next run."
            p.image = .preloaded(path: "shoe_normal.jpg")

            p.style = PosterStyle() { ps in
                ps.imagePosition = Position(horizontal: .left(offset: 50), vertical: .center)
                ps.textPosition = Position(horizontal: .right(offset: 100), vertical: .center)
                ps.fontSize = .percent(80)
                ps.fontColor = UIColor(white: 0x88/255.0, alpha: 1.0)
                ps.headerFontColor = .black
            }
        }

        mirrorClient.display(sneakersDetails, inProximity: .near)
    }
    
}

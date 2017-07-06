@objc
public class Poster: View {

    let header: String?
    let body: String?
    let image: Image?

    let style: PosterStyle?

    @objc
    public convenience init(_ block: (PosterBuilder) -> Void) {
        let builder = PosterBuilder()
        block(builder)
        self.init(builder: builder)
    }

    init(builder: PosterBuilder) {
        self.header = builder.header
        self.body = builder.body
        self.image = builder.image

        self.style = builder.style
    }

    override var typeName: String {
        get {
            return "ImageView"
        }
    }

    override var dataDict: [String: Any] {
        get {
            return [
                "header": header as Any,
                "body": body as Any,
                "image": image?.serialized as Any,

                "style": style?.dataDict as Any
            ]
        }
    }

}

@objc
public class PosterBuilder: NSObject {

    @objc public var header: String?
    @objc public var body: String?
    @objc public var image: Image?

    @objc public var style: PosterStyle?

}



@objc
public class PosterStyle: NSObject {

    let imagePosition: Position?
    let textPosition: Position?
    let fontSize: FontSize?
    let fontColor: UIColor?
    let textAlign: TextAlign?
    let backgroundColor: UIColor?
    let backgroundImage: Image?

    let headerFontSize: FontSize?
    let headerFontColor: UIColor?

    @objc
    public convenience init(_ block: (PosterStyleBuilder) -> Void) {
        let builder = PosterStyleBuilder()
        block(builder)
        self.init(builder: builder)
    }

    init(builder: PosterStyleBuilder) {
        self.imagePosition = builder.imagePosition
        self.textPosition = builder.textPosition
        self.fontSize = builder.fontSize
        self.fontColor = builder.fontColor
        self.textAlign = builder.textAlign
        self.backgroundColor = builder.backgroundColor
        self.backgroundImage = builder.backgroundImage

        self.headerFontSize = builder.headerFontSize
        self.headerFontColor = builder.headerFontColor
    }

    var dataDict: [String: Any] {
        get {
            return [
                "imagePosition": imagePosition?.serialized as Any,
                "textPosition": textPosition?.serialized as Any,
                "fontSize": fontSize?.serialized as Any,
                "fontColor": fontColor?.serialized as Any,
                "textAlign": textAlign?.serialized as Any,
                "backgroundColor": backgroundColor?.serialized as Any,
                "backgroundImage": backgroundImage?.serialized as Any,

                "header": [
                    "fontSize": headerFontSize?.serialized as Any,
                    "fontColor": headerFontColor?.serialized as Any
                ]
            ]
        }
    }

}

@objc
public class PosterStyleBuilder: NSObject {

    @objc public var imagePosition: Position?
    @objc public var textPosition: Position?
    @objc public var fontSize: FontSize?
    @objc public var fontColor: UIColor?
    @objc public var textAlign: TextAlign = .left
    @objc public var backgroundColor: UIColor?
    @objc public var backgroundImage: Image?

    @objc public var headerFontSize: FontSize?
    @objc public var headerFontColor: UIColor?

}

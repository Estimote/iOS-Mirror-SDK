@objc
public class View: NSObject {

    var typeName: String {
        get {
            assertionFailure("Got a call to `typeName` on an abstract class View, did you forget to override it in a subclass?")

            return "__UnknownView"
        }
    }

    var dataDict: [String: Any] {
        get {
            assertionFailure("Got a call to `dataDict` on an abstract class View, did you forget to override it in a subclass?")

            return [String: Any]()
        }
    }

}



extension UIColor {

    var serialized: String? {
        get {
            func convert(_ val: CGFloat) -> UInt8 {
                var clampedVal: CGFloat = val
                if val > 1.0 {
                    clampedVal = 1.0
                } else if val < 0.0 {
                    clampedVal = 0.0
                }
                return UInt8(clampedVal * 255.0)
            }

            var r: CGFloat = 0.0
            var g: CGFloat = 0.0
            var b: CGFloat = 0.0
            var a: CGFloat = 0.0

            if getRed(&r, green: &g, blue: &b, alpha: &a) {
                return "rgba(\(convert(r)),\(convert(g)),\(convert(b)),\(a))"
            }

            return nil
        }
    }

}



@objc
public enum TextAlign: UInt8 {

    case left
    case center
    case right

    var serialized: String {
        get {
            switch self {
            case .left:
                return "left"
            case .center:
                return "center"
            case .right:
                return "right"
            }
        }
    }

}



@objc
public final class FontSize: NSObject {

    @objc(fontSizeWithPercent:)
    public static func percent(_ percent: UInt16) -> FontSize {
        return FontSize(serialized: "\(percent)%")
    }

    let serialized: String

    private init(serialized: String) {
        self.serialized = serialized;
    }

}



@objc
public final class Image: NSObject {

    @objc(preloadedImageWithPath:)
    public static func preloaded(path: String) -> Image {
        return Image(serialized: "/shared/\(path)")
    }

    let serialized: String

    private init(serialized: String) {
        self.serialized = serialized;
    }

}



@objc
public final class VerticalPosition: NSObject {

    @objc
    public static let top = VerticalPosition(serialized: "top")

    @objc
    public static func top(offset: Int16) -> VerticalPosition {
        return VerticalPosition(serialized: "top \(offset)px")
    }

    @objc
    public static let bottom = VerticalPosition(serialized: "bottom")

    @objc
    public static func bottom(offset: Int) -> VerticalPosition {
        return VerticalPosition(serialized: "bottom \(offset)px")
    }

    @objc
    public static let center = VerticalPosition(serialized: "center")

    let serialized: String

    private init(serialized: String) {
        self.serialized = serialized;
    }

}



@objc
public final class HorizontalPosition: NSObject {

    @objc
    public static let left = HorizontalPosition(serialized: "left")

    @objc
    public static func left(offset: Int16) -> HorizontalPosition {
        return HorizontalPosition(serialized: "left \(offset)px")
    }

    @objc
    public static let right = HorizontalPosition(serialized: "right")

    @objc
    public static func right(offset: Int) -> HorizontalPosition {
        return HorizontalPosition(serialized: "right \(offset)px")
    }

    @objc
    public static let center = HorizontalPosition(serialized: "center")

    let serialized: String

    private init(serialized: String) {
        self.serialized = serialized;
    }

}



@objc
public final class Position: NSObject {

    @objc
    public init(horizontal: HorizontalPosition, vertical: VerticalPosition) {
        serialized = "\(horizontal.serialized) \(vertical.serialized)"
    }

    let serialized: String

}

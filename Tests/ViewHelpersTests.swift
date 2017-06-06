import XCTest

@testable import MirrorDisplay

class ViewHelpersTests: XCTestCase {

    func testUIColorExtension() {
        XCTAssertEqual(UIColor.white.serialized, "rgba(255,255,255,1.0)")
        XCTAssertEqual(UIColor.black.serialized, "rgba(0,0,0,1.0)")

        XCTAssertEqual(UIColor(red: 231/255.0, green: 9/255.0, blue: 127/255.0, alpha: 0.34).serialized, "rgba(231,9,127,0.34)")

        XCTAssertEqual(UIColor(red: 1.1, green: 1.1, blue: 1.1, alpha: 1.0).serialized, "rgba(255,255,255,1.0)")
    }

    func testTextAlign() {
        XCTAssertEqual(TextAlign.left.serialized, "left")
        XCTAssertEqual(TextAlign.center.serialized, "center")
        XCTAssertEqual(TextAlign.right.serialized, "right")
    }

    func testFontSize() {
        XCTAssertEqual(FontSize.percent(125).serialized, "125%")
    }

    func testImage() {
        XCTAssertEqual(Image.preloaded(path: "sneakers_demo/big_shoe.png").serialized, "assets/sneakers_demo/big_shoe.png")
    }

    func testVerticalPosition() {
        XCTAssertEqual(VerticalPosition.top.serialized, "top")
        XCTAssertEqual(VerticalPosition.top(offset: 50).serialized, "top 50px")

        XCTAssertEqual(VerticalPosition.bottom.serialized, "bottom")
        XCTAssertEqual(VerticalPosition.bottom(offset: -50).serialized, "bottom -50px")

        XCTAssertEqual(VerticalPosition.center.serialized, "center")
    }

    func testHorizontalPosition() {
        XCTAssertEqual(HorizontalPosition.left.serialized, "left")
        XCTAssertEqual(HorizontalPosition.left(offset: 50).serialized, "left 50px")

        XCTAssertEqual(HorizontalPosition.right.serialized, "right")
        XCTAssertEqual(HorizontalPosition.right(offset: -50).serialized, "right -50px")

        XCTAssertEqual(HorizontalPosition.center.serialized, "center")
    }

    func testPosition() {
        XCTAssertEqual(Position(horizontal: .center, vertical: .center).serialized, "center center")
        XCTAssertEqual(Position(horizontal: .left(offset: 100), vertical: .bottom(offset: -100)).serialized, "left 100px bottom -100px")
    }

}

#import <UIKit/UIKit.h>

//! Project version number for MirrorDisplay.
FOUNDATION_EXPORT double MirrorDisplayVersionNumber;

//! Project version string for MirrorDisplay.
FOUNDATION_EXPORT const unsigned char MirrorDisplayVersionString[];



// found no good way to define an OptionSet[1] in Swift in a way that'd work well[2] in both Swift and Obj-C, so falling back to this excellent suggestion from Stack Overflow: http://stackoverflow.com/a/32530210/1900855
// [1] we do want an OptionSet to be able to do things like: [.near, .mid, .far] == .any
// [2] works well = behaves like an OptionSet in Swift, and like a good ol' bitmask in Obj-C
typedef NS_OPTIONS(UInt8, ProximityOptions) {
    ProximityOptionsAny  = 0b111,
    ProximityOptionsNear = 0b001,
    ProximityOptionsMid  = 0b010,
    ProximityOptionsFar  = 0b100
};

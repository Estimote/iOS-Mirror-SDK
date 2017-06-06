#import "ViewController.h"

@import MirrorDisplay;



@interface ViewController ()


@property (strong, nonatomic) MirrorClient *mirrorClient;


@end



@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.mirrorClient = [MirrorClient new];



    Poster *appReady = [[Poster alloc] init:^(PosterBuilder *p) {

        p.header = @"Discover Mirror with\nthe Estimote App";
        p.body = @"See the Mirror Demos to learn\nhow Mirror works and what you\ncan use it for.";
        p.image = [Image preloadedImageWithPath:@"estimote_app.png"];

        p.style = [[PosterStyle alloc] init:^(PosterStyleBuilder *ps) {
            ps.imagePosition =
            [[Position alloc] initWithHorizontal:[HorizontalPosition rightWithOffset:190]
                                        vertical:[VerticalPosition topWithOffset:5]];
            ps.backgroundImage = [Image preloadedImageWithPath:@"voronoi_bg.png"];
            ps.fontColor = [UIColor colorWithRed:0x82/255.0 green:0x86/255.0 blue:0xE0/255.0 alpha:1.0];
            ps.headerFontColor = UIColor.whiteColor;
        }];
    }];

    [self.mirrorClient display:appReady inProximity:ProximityOptionsFar];

    //

    Poster *sneakersBanner = [[Poster alloc] init:^(PosterBuilder *p) {

        p.header = @"Exceptional traction\nfrom your first to final mile";
        p.image = [Image preloadedImageWithPath:@"shoe_big.jpg"];

        p.style = [[PosterStyle alloc] init:^(PosterStyleBuilder *ps) {
            ps.imagePosition =
            [[Position alloc] initWithHorizontal:[HorizontalPosition center]
                                        vertical:[VerticalPosition topWithOffset:80]];
            ps.textPosition =
            [[Position alloc] initWithHorizontal:[HorizontalPosition center]
                                        vertical:[VerticalPosition bottomWithOffset:80]];
            ps.textAlign = TextAlignCenter;
            ps.headerFontSize = [FontSize fontSizeWithPercent:130];
        }];
    }];

    [self.mirrorClient display:sneakersBanner inProximity:ProximityOptionsMid];

    //

    Poster *sneakersDetails = [[Poster alloc] init:^(PosterBuilder *p) {

        p.header = @"New Sneakers";
        p.body = @"Experience smooth support, a secure\nmid-foot wrap, a streamlined look,\nand our new cushioning system on\nyour next run.";
        p.image = [Image preloadedImageWithPath:@"shoe_normal.jpg"];

        p.style = [[PosterStyle alloc] init:^(PosterStyleBuilder *ps) {
            ps.imagePosition =
            [[Position alloc] initWithHorizontal:[HorizontalPosition leftWithOffset:50]
                                        vertical:[VerticalPosition center]];
            ps.textPosition =
            [[Position alloc] initWithHorizontal:[HorizontalPosition rightWithOffset:100]
                                        vertical:[VerticalPosition center]];
            ps.fontSize = [FontSize fontSizeWithPercent:80];
            ps.fontColor = [UIColor colorWithWhite:0x88/255.0 alpha:1.0];
            ps.headerFontColor = UIColor.blackColor;
        }];
    }];

    [self.mirrorClient display:sneakersDetails inProximity:ProximityOptionsNear];
}


@end

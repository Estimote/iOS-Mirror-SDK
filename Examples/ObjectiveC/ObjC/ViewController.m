#import "ViewController.h"

@import MirrorDisplay;
@import EstimoteProximitySDK;


@interface ViewController ()

@property (strong, nonatomic) MirrorClient *mirrorClient;
@property (strong, nonatomic) EPXProximityObserver *proximityObserver;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    self.mirrorClient = [[MirrorClient alloc] initWithAppID:@"" appToken:@""];

    EPXCloudCredentials *credentials = [[EPXCloudCredentials alloc] initWithAppID:@"" appToken:@""];
    
    self.proximityObserver = [[EPXProximityObserver alloc] initWithCredentials:credentials errorBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
    
    EPXProximityZone *mirrorZone = [[EPXProximityZone alloc] initWithRange:[EPXProximityRange customRangeWithDesiredMeanTriggerDistance:1.0] tag:@"mirror"];
    
    mirrorZone.onEnterAction = ^(id<EPXProximityZoneContext> context) {
        NSLog(@"Enter mirror");
        [self.mirrorClient displayView:sneakersBanner onMirrorWithIdentifier:context.deviceIdentifier];
    };
    mirrorZone.onExitAction = ^(id<EPXProximityZoneContext> context) {
        NSLog(@"Exit mirror");
    };
    
    [self.proximityObserver startObserving:@[mirrorZone]];
}


@end

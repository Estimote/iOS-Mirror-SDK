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
        p.body = @"Now 20% off!";
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
    
    self.proximityObserver = [[EPXProximityObserver alloc] initWithCredentials:credentials onError:^(NSError * _Nonnull error) {
       
        NSLog(@"%@", error);
    }];
    
    
    EPXProximityZone *mirrorZone = [[EPXProximityZone alloc]  initWithTag:@"mirror" range:[EPXProximityRange customRangeWithDesiredMeanTriggerDistance:1.0]];
    
    mirrorZone.onEnter = ^(EPXProximityZoneContext * _Nonnull zoneContext) {
        NSLog(@"Enter mirror");
        [self.mirrorClient displayView:sneakersBanner onMirrorWithIdentifier:zoneContext.deviceIdentifier];
    };
    
    mirrorZone.onExit = ^(EPXProximityZoneContext * _Nonnull zoneContext) {
        NSLog(@"Exit mirror");
    };

    [self.proximityObserver startObservingZones:@[mirrorZone]];
}


@end

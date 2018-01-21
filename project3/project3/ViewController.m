//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.blueColor;

    UIView *redview = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 250, 300)];
//    redview.backgroundColor = nil;
//    redview.backgroundColor = UIColor.redColor;
//    redview.backgroundColor = UIColor.clearColor;
//    redview.userInteractionEnabled = NO;
    [self.view addSubview:redview];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 32, 32);
    [button setTitle:@"test" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [redview addSubview:button];
    
    UIView *greenView = [[UIView alloc] initWithFrame:CGRectMake(40, 40, 50, 50)];
    greenView.backgroundColor = UIColor.greenColor;
    [redview addSubview:greenView];
    
    UITapGestureRecognizer *r = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(update:)];
    [greenView addGestureRecognizer:r];
    
    NSLog(@"%@", redview.userInteractionEnabled ? @"yes" : @"no");
    NSLog(@"%@", redview.hidden ? @"yes" : @"no");
    NSLog(@"%ff", redview.alpha);
    
//    redview.alpha = 0.25;
    
}

- (void)update:(id)sender {
    NSLog(@"update");
}

- (void)click:(id)sender {
    NSLog(@"click");
}

@end

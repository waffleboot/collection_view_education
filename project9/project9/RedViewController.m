
#import "RedViewController.h"

@interface RedViewController ()
@end

@implementation RedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.orangeColor;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Close" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    button.backgroundColor = UIColor.blueColor;
    button.center = self.view.center;
    button.bounds = CGRectMake(0, 0, 60, 32);
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)close:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end

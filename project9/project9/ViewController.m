
#import "ViewController.h"
#import "RedViewController.h"

@interface ViewController () <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>
@property (nonatomic, strong) UIButton *button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.button setTitle:@"Login" forState:UIControlStateNormal];
    [self.button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.button.backgroundColor = UIColor.blueColor;
    self.button.center = self.view.center;
    self.button.bounds = CGRectMake(0, 0, 60, 32);
    [self.view addSubview:self.button];
    
    [self.button addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)login:(UIButton *)sender {
    RedViewController *vc = [[RedViewController alloc] init];
    vc.transitioningDelegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *srcVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *dstVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    dstVC.view.alpha = 0;
    
    [transitionContext.containerView addSubview:srcVC.view];
    [transitionContext.containerView addSubview:dstVC.view];
    
    CGRect r = self.button.bounds;
    
    [UIView animateWithDuration:2.5 animations:^{
        self.button.bounds = CGRectMake(0, 0, 120, 32);
    } completion:^(BOOL finished) {
        [UIView performWithoutAnimation:^{
            self.button.alpha = 0;
        }];
        [UIView animateWithDuration:2.5 animations:^{
            dstVC.view.alpha = 1;
        } completion:^(BOOL finished) {
            self.button.bounds = r;
            self.button.alpha = 1;
            [transitionContext completeTransition:YES];
        }];
    }];
}

@end

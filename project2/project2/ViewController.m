
#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIView *mainView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
    redView.backgroundColor = [UIColor colorWithRed:0.815
                                              green:0.007
                                               blue:0.105
                                              alpha:1];
    
    UIView *greenView = [[UIView alloc] initWithFrame:CGRectMake(150, 160, 150, 200)];
    greenView.backgroundColor = [UIColor colorWithRed:0.494
                                                green:0.827
                                                 blue:0.129
                                                alpha:1];
    
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(40, 400, 200, 150)];
    blueView.backgroundColor = [UIColor colorWithRed:0.29
                                               green:0.564
                                                blue:0.886
                                               alpha:1];
    
    UIView *yellowView = [[UIView alloc] initWithFrame:CGRectMake(100, 600, 180, 150)];
    yellowView.backgroundColor = [UIColor colorWithRed:0.972
                                                 green:0.905
                                                  blue:0.109
                                                 alpha:1];

    self.mainView = [[UIView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [self.view addSubview:self.mainView];
    
    [self.mainView addSubview:redView];
    [self.mainView addSubview:greenView];
    [self.mainView addSubview:blueView];
    [self.mainView addSubview:yellowView];
    
    [self performSelector:@selector(update) withObject:nil afterDelay:2];
}

- (void)update {
    self.mainView.transform = CGAffineTransformMakeRotation(M_PI_4/10);
    CGRect bounds = self.mainView.bounds;
    bounds.origin = CGPointMake(0, 200);
    [UIView animateWithDuration:3 animations:^{
        self.mainView.bounds = bounds;
    }];
}

@end


#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) UIView *mainView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(800, 800);
    [self.view addSubview:scrollView];

    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    redView.backgroundColor = [UIColor colorWithRed:0.815
                                              green:0.007
                                               blue:0.105
                                              alpha:1];
    [scrollView addSubview:redView];
    
    scrollView.delegate = self;
    
    [self performSelector:@selector(update:) withObject:scrollView afterDelay:2];
}

- (void)update:(UIScrollView *)scrollView {
    scrollView.contentOffset = CGPointZero;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"frame %@", NSStringFromCGRect(scrollView.frame));
    NSLog(@"bounds %@", NSStringFromCGRect(scrollView.bounds));
    NSLog(@"center %@", NSStringFromCGPoint(scrollView.center));
    NSLog(@"offset %@", NSStringFromCGPoint(scrollView.contentOffset));
}

@end

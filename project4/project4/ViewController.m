
#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUInteger x = 20;
    NSUInteger y = 20;
    CGSize size = CGSizeMake(50, 50);
    for (int i = 0; i < x; ++i) {
        for (int j = 0; j < y; ++j) {
            UIView *v = [[UIView alloc] initWithFrame:CGRectMake(size.width*i, size.height*j, size.width, size.height)];
            CGFloat r = arc4random() % 255 / 255.0;
            CGFloat g = arc4random() % 255 / 255.0;
            CGFloat b = arc4random() % 255 / 255.0;
            v.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
            [self.scrollView addSubview:v];
        }
    }
    NSLog(@"%@", @(UIScrollViewDecelerationRateNormal));
    NSLog(@"%@", @(UIScrollViewDecelerationRateFast));
    self.scrollView.decelerationRate = 0.995;
    self.scrollView.contentSize = CGSizeMake(x*size.width, y*size.height);
    self.scrollView.delegate = self;
    NSLog(@"%@", self.scrollView.panGestureRecognizer);
//    self.scrollView.panGestureRecognizer.enabled = NO;
//    [self.scrollView removeGestureRecognizer:self.scrollView.panGestureRecognizer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"scrollViewDidScroll");
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    NSLog(@"scrollViewWillBeginDragging");
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGFloat x = floor(targetContentOffset->x/50)*50;
    CGFloat y = floor(targetContentOffset->y/50)*50;
    *targetContentOffset = CGPointMake(x, y);
    NSLog(@"scrollViewWillEndDragging velocity %@ target %@", NSStringFromCGPoint(velocity), NSStringFromCGPoint(*targetContentOffset));
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    NSLog(@"scrollViewDidEndDragging %@", decelerate ? @"yes" : @"no");
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
//    NSLog(@"scrollViewWillBeginDecelerating");
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    NSLog(@"scrollViewDidEndDecelerating");
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndScrollingAnimation");
}
@end

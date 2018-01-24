
#import "ViewController.h"

@interface AView : UIView
@end

@interface ViewController ()
@property (nonatomic, assign) BOOL flag;
@property (nonatomic, strong) UIView *v;
@property (nonatomic, strong) UIView *f;
@property (nonatomic, strong) UIView *v2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.v = [[UIView alloc] initWithFrame:CGRectZero];
    self.v.backgroundColor = UIColor.lightGrayColor;
    self.v.bounds = CGRectMake(0, 0, 100, 100);
    self.v.transform = CGAffineTransformMakeRotation(M_PI_4);
    
    self.v2 = [[UIView alloc] initWithFrame:CGRectMake(110, 0, 100, 100)];
    self.v2.backgroundColor = UIColor.darkGrayColor;
//    self.v2.bounds = CGRectMake(0, 0, 100, 100);
    
    self.f = [[UIView alloc] initWithFrame:CGRectZero];
    self.f.backgroundColor = UIColor.blueColor;
    [self.view addSubview:self.f];
    [self.view addSubview:self.v];
    [self.v addSubview:self.v2];
    
    UIView *grid = [[UIView alloc] initWithFrame:self.view.bounds];
    grid.backgroundColor = [UIColor colorWithPatternImage:self.pattern];
    grid.opaque = NO;
    [self.view addSubview:grid];
    
    UIView *axis = [[AView alloc] initWithFrame:self.view.bounds];
    axis.opaque = NO;
    [self.view addSubview:axis];

    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(update:)];
    [self.view addGestureRecognizer:g];
    
    [self move:self.view.center];
}

- (void)move:(CGPoint)point {
//    self.flag = !self.flag;
    CGFloat width = self.flag ? 50 : 100;
//    self.v.bounds = CGRectMake(25, 25, width, width);
    self.v.center = point;
    self.f.frame  = self.v.frame;
    CGRect r = CGRectApplyAffineTransform(self.v.frame, CGAffineTransformMakeTranslation(-CGRectGetMidX(self.view.bounds), -CGRectGetMidY(self.view.bounds)));
    NSLog(@"frame = %@, bounds = %@", NSStringFromCGRect(r), NSStringFromCGRect(self.v.bounds));
}

- (void)update:(UITapGestureRecognizer *)r {
    [self move:[r locationInView:self.view]];
}

- (UIImage *)pattern {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(10, 10), NO, 0.0);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 11, 11)];
    [UIColor.blackColor setStroke];
    [path stroke];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

@implementation AView

- (void)drawRect:(CGRect)rect {
    [UIColor.redColor setStroke];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(CGRectGetMidX(self.bounds), 0)];
    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetHeight(self.bounds))];
    [path moveToPoint:CGPointMake(0, CGRectGetMidY(self.bounds))];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds), CGRectGetMidY(self.bounds))];
    [path stroke];
}
@end



#import "ViewController.h"

@interface Dyn : UIDynamicBehavior

@interface ViewController ()
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIGravityBehavior *gravity;
@property (nonatomic, strong) UICollisionBehavior *collision;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *square = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    square.backgroundColor = UIColor.grayColor;
    [self.view addSubview:square];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.gravity  = [[UIGravityBehavior alloc] initWithItems:@[square]];
    self.collision = [[UICollisionBehavior alloc] initWithItems:@[square]];
    self.collision.translatesReferenceBoundsIntoBoundary = YES;
    self.collision.action = ^{
        NSLog(@"collision");
    };
    self.gravity.action = ^{
        NSLog(@"gravity");
    };
    [self.animator addBehavior:self.gravity];
    [self.animator addBehavior:self.collision];
}

@end

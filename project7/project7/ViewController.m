
#import "ViewController.h"

@interface MyLayout : UICollectionViewFlowLayout
@property (nonatomic, assign) BOOL resetDynamicFlag;
@property (nonatomic, strong) UIDynamicAnimator *dynamicAnimator;
- (void)resetDynamic;
@end

@interface ViewController ()
@end

@implementation ViewController

static NSString * const kCellIdentifier = @"CellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:kCellIdentifier];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.collectionViewLayout performSelector:@selector(resetDynamic)];
    [self.collectionViewLayout invalidateLayout];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 120;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier
                                                                           forIndexPath:indexPath];
    cell.backgroundColor = UIColor.orangeColor;
    return cell;
}

@end

@implementation MyLayout

- (void)awakeFromNib {
    [super awakeFromNib];
    self.minimumInteritemSpacing = 10;
    self.minimumLineSpacing = 10;
    self.itemSize = CGSizeMake(44, 44);
    self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
}

- (void)make {
    CGSize contentSize = self.collectionViewContentSize;
    NSArray *items = [super layoutAttributesForElementsInRect:CGRectMake(0, 0, contentSize.width, contentSize.height)];
    [self.dynamicAnimator removeAllBehaviors];
    for (UICollectionViewLayoutAttributes *item in items) {
        UIAttachmentBehavior *behaviour = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:item.center];
        behaviour.length = 0.0f;
        behaviour.damping = 0.8f;
        behaviour.frequency = 1.0f;
        [self.dynamicAnimator addBehavior:behaviour];
    }
}

- (void)prepareLayout {
    [super prepareLayout];
    if (self.resetDynamicFlag) {
        self.resetDynamicFlag = NO;
        [self make];
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return [self.dynamicAnimator itemsInRect:rect];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dynamicAnimator layoutAttributesForCellAtIndexPath:indexPath];
}

- (void)resetDynamic {
    self.resetDynamicFlag = YES;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    CGRect oldBounds = self.collectionView.bounds;
    if (CGRectGetWidth(oldBounds) != CGRectGetWidth(newBounds)) {
        [self resetDynamic];
        return YES;
    }
    UIScrollView *scrollView = self.collectionView;
    CGFloat delta = newBounds.origin.y - scrollView.bounds.origin.y;
    CGPoint touchLocation = [self.collectionView.panGestureRecognizer locationInView:self.collectionView];
    [self.dynamicAnimator.behaviors enumerateObjectsUsingBlock:^(UIAttachmentBehavior *obj, NSUInteger idx, BOOL *stop) {
        CGFloat yDistanceFromTouch = ABS(touchLocation.y - obj.anchorPoint.y);
        CGFloat xDistanceFromTouch = ABS(touchLocation.x - obj.anchorPoint.x);
        CGFloat scrollResistance = (yDistanceFromTouch + xDistanceFromTouch) / 1500.0f;

        UICollectionViewLayoutAttributes *item = (UICollectionViewLayoutAttributes *) obj.items.firstObject;
        CGPoint center = item.center;
        if (delta < 0) {
            center.y += MAX(delta, delta * scrollResistance);
        } else {
            center.y += MIN(delta, delta * scrollResistance);
        }
        item.center = center;
        [self.dynamicAnimator updateItemUsingCurrentState:item];
    }];
    return NO;
}

@end


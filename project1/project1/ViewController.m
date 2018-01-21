
#import "ViewController.h"
#import "PageCell.h"

@interface MyLayout : UICollectionViewFlowLayout
@end

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<UIColor *> *colors;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:8];
    for (int i = 0; i < 8; ++i) {
        [array addObject:[ViewController randomColor]];
    }
    self.colors = [NSArray arrayWithArray:array];

    CGRect frame = CGRectInset(self.view.bounds, 30, 30);

    MyLayout *layout = [[MyLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = frame.size;

    self.collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;

    [self.collectionView registerClass:[PageCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
    [self.view addSubview:self.collectionView];
}

- (void)click:(UITapGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateRecognized) {
        CGPoint touchPoint = [gestureRecognizer locationInView:self.collectionView];
        CGRect rect = CGRectMake(touchPoint.x, touchPoint.y, 1, 1);
        NSArray<UICollectionViewLayoutAttributes *> *array = [self.collectionView.collectionViewLayout layoutAttributesForElementsInRect:rect];
        for (UICollectionViewLayoutAttributes *attributes in array) {
            if (attributes.representedElementCategory == UICollectionElementCategoryCell) {
                PageCell *pageCell = (PageCell *) [self.collectionView cellForItemAtIndexPath:attributes.indexPath];
                touchPoint = [gestureRecognizer locationInView:pageCell];
                rect = CGRectMake(touchPoint.x, touchPoint.y, 1, 1);
                
                NSArray<UICollectionViewLayoutAttributes *> *array = [pageCell.collectionView.collectionViewLayout layoutAttributesForElementsInRect:rect];
                for (UICollectionViewLayoutAttributes *attributes in array) {
                    if (attributes.representedElementCategory == UICollectionElementCategoryCell) {
                        UICollectionViewCell *cell = [pageCell.collectionView cellForItemAtIndexPath:attributes.indexPath];
                        NSLog(@"cell");
                    }
                }
            }
        }
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.colors.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.color = [self.colors objectAtIndex:indexPath.item];
    cell.index = indexPath.item;
    return cell;
}

+ (UIColor *)randomColor {
    CGFloat r = arc4random() % 255 / 255.0f;
    CGFloat g = arc4random() % 255 / 255.0f;
    CGFloat b = arc4random() % 255 / 255.0f;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0f];
}

@end

@implementation MyLayout

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGFloat minOffset = CGFLOAT_MAX;
    CGRect rect = CGRectMake(proposedContentOffset.x, proposedContentOffset.y, CGRectGetWidth(self.collectionView.bounds), CGRectGetHeight(self.collectionView.bounds));
    CGFloat centerX = CGRectGetMidX(rect);
    NSArray<UICollectionViewLayoutAttributes *> *array = [self.collectionView.collectionViewLayout layoutAttributesForElementsInRect:rect];
    for (UICollectionViewLayoutAttributes *attributes in array) {
        if (attributes.representedElementCategory == UICollectionElementCategoryCell) {
            CGFloat offset = attributes.center.x - centerX;
            if (ABS(offset) < ABS(minOffset)) {
                minOffset = offset;
            }
        }
    }
    return CGPointMake(proposedContentOffset.x + minOffset, proposedContentOffset.y);
}

@end


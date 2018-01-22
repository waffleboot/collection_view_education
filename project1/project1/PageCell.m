
#import "PageCell.h"

@interface PageCellLayout : UICollectionViewFlowLayout
@end

@interface PageCell () <UICollectionViewDataSource,UICollectionViewDelegate>
@end

@implementation PageCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        PageCellLayout *layout = [[PageCellLayout alloc] init];
        layout.itemSize = CGSizeMake(60, 60);

        self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        
        [self.contentView addSubview:self.collectionView];

        self.collectionView.backgroundColor = UIColor.whiteColor;
        
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.count;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.indexPath isEqual:indexPath]) {
        self.indexPath = nil;
        
        CGPoint from = CGPointMake(CGRectGetMidX(self.collectionView.bounds), cell.center.y);
        CGPoint to = cell.center;

        CGPoint m = CGPointMake((from.x+to.x)/2, to.y - 90);
        
        cell.center = to;
        CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        animation1.keyTimes = @[@(0.0),@(0.5),@(1.0)];
        animation1.values = @[@(from),@(m),@(to)];
        
        cell.alpha = 1;
        CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animation2.fromValue = @(0);
        animation2.toValue = @(1);
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.animations = @[animation1,animation2];
        group.duration = 10;
        [cell.layer addAnimation:group forKey:@"group"];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UILabel *label;
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (cell.tag == 1) {
        label = [cell.contentView viewWithTag:1];
    } else {
        label = [[UILabel alloc] initWithFrame:cell.bounds];
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
        label.tag = 1;
        cell.tag = 1;
    }
    label.text = [[NSNumber numberWithUnsignedInteger:indexPath.item] stringValue];
    cell.backgroundColor = self.color;
    return cell;
}

@end

@implementation PageCellLayout

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    NSLog(@"%@", itemIndexPath);
    return [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
}

@end

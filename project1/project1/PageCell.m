
#import "PageCell.h"

@interface PageCellLayout : UICollectionViewFlowLayout
@property (nonatomic, strong) NSSet<NSIndexPath *> *inserts;
@end

//@interface Attrib : UICollectionViewLayoutAttributes
//@property (nonatomic, assign) BOOL inserted;
//@end

//@interface CellItem : UICollectionViewCell
//@property (nonatomic, assign) BOOL flag;
//@end;

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
        
//        NSLog(@"%@ => %@", NSStringFromCGPoint(from), NSStringFromCGPoint(to));
        
//        [CATransaction begin];
//        [CATransaction setDisableActions:YES];
//        cell.center = from;
//        cell.alpha = 0;
//        [CATransaction commit];
        
//        [UIView performWithoutAnimation:^{
//            cell.center = from;
//        }];
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:3];
//        cell.center = to;
//        [UIView commitAnimations];
        
//        [cell.layer removeAllAnimations];

        CGPoint m = CGPointMake((from.x+to.x)/2, to.y - 90);
        
        cell.center = to;
        CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        animation1.keyTimes = @[@(0.0),@(0.5),@(1.0)];
        animation1.values = @[@(from),@(m),@(to)];
        
//        CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"position"];
//        animation1.fromValue = @(from);
//        animation1.toValue = @(to);
//        [cell.layer addAnimation:animation forKey:@"position"];
        
        cell.alpha = 1;
        CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animation2.fromValue = @(0);
        animation2.toValue = @(1);
//        [cell.layer addAnimation:animation forKey:@"opacity"];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.animations = @[animation1,animation2];
        group.duration = 10;
        [cell.layer addAnimation:group forKey:@"group"];

        //        [UIView animateKeyframesWithDuration:3.0 delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        //            [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:1/2.0 animations:^{
        //                cell.transform = CGAffineTransformMakeScale(2, 2);
        //                cell.center = CGPointMake(center.x, center.y - 200);
        //                cell.center = CGPointZero;
        //                cell.alpha = 0.5;
        //            }];
        //            [UIView addKeyframeWithRelativeStartTime:1/2.0 relativeDuration:1/2.0 animations:^{
        //                cell.transform = CGAffineTransformIdentity;
        //                cell.center = center;
        //                cell.alpha = 1;
        //            }];
        //        } completion:^(BOOL finished) {
        //            NSLog(@"done %@", cell);
        //            cell.alpha = 1;
        //            cell.center = center;
        //        }];
//        NSLog(@"keys %@", cell.layer.animationKeys);
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

//+ (Class)layoutAttributesClass {
//    return [Attrib class];
//}

//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
//    return YES;
//}
//
//- (void)prepareForCollectionViewUpdates:(NSArray<UICollectionViewUpdateItem *> *)updateItems {
//    NSMutableSet<NSIndexPath *> *inserts = [NSMutableSet setWithCapacity:updateItems.count];
//    for (UICollectionViewUpdateItem *item in updateItems) {
//        if (item.updateAction == UICollectionUpdateActionInsert) {
//            [inserts addObject:item.indexPathAfterUpdate];
//        }
//    }
//    self.inserts = inserts;
//    [super prepareForCollectionViewUpdates:updateItems];
//}
//
//- (void)finalizeCollectionViewUpdates {
//    self.inserts = nil;
//    [super finalizeCollectionViewUpdates];
//}

//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
//    if ([self.inserts containsObject:indexPath]) {
//        attributes.center = CGPointMake(CGRectGetMidX(self.collectionView.bounds), CGRectGetMaxY(self.collectionView.bounds) - 30);
//        attributes.alpha = 0;
//    }
//    return attributes;
//}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    NSLog(@"%@", itemIndexPath);
    return [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
//    UICollectionViewLayoutAttributes *attributes = [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
//    if ([self.inserts containsObject:itemIndexPath]) {
//        attributes.center = CGPointMake(CGRectGetMidX(self.collectionView.bounds), CGRectGetMaxY(self.collectionView.bounds) - 30);
//        attributes.alpha  = 0;
//    }
//    return attributes;
}

@end

//@interface MyLayer : CALayer
//@property (nonatomic, assign) BOOL inserted;
//@end

//@implementation CellItem

//- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
//    Attrib *attributes = (Attrib *) [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
//    if (attributes.inserted) {
//        NSLog(@"%@", layoutAttributes);
//    }
//    return attributes;
//}

//- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
//    NSLog(@"apply %@ %@", layoutAttributes.indexPath, self);
//    [super applyLayoutAttributes:layoutAttributes];
//    if (self.flag) {
//        NSLog(@"flag");
//        self.flag = NO;
//    }
//    Attrib *attr = (Attrib *)layoutAttributes;
//    ((MyLayer *) self.layer).inserted = NO;
//    if (attr.inserted) {
//        self.alpha = 0;
//        self.hidden = YES;
//        ((MyLayer *) self.layer).inserted = YES;
//        self.layer.speed = 0.1;
//        NSLog(@"%@", attr);
//        NSLog(@"%@", self.layer.class);
//
//        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update:)];
//        [link addToRunLoop:NSRunLoop.mainRunLoop forMode:NSDefaultRunLoopMode];
//    }
//}

//+ (Class)layerClass {
//    return [MyLayer class];
//}

//- (void)update:(CADisplayLink *)link {
//    NSLog(@"%@", self.layer.animationKeys);
//}

//@end

//@implementation MyLayer
//
//- (void)addAnimation:(CAAnimation *)anim forKey:(NSString *)key {
//    if (self.inserted) {
//        NSLog(@"add animation %@ %f", key, anim.duration);
//        anim.duration = 3;
//    }
//    [super addAnimation:anim forKey:key];
//}
//
//@end

//@implementation Attrib
//
//- (id)copyWithZone:(NSZone *)zone {
//    Attrib *copy = (Attrib *) [super copyWithZone:zone];
//    copy.inserted = self.inserted;
//    return copy;
//}
//
//- (BOOL)isEqual:(id)object {
//    Attrib *other = (Attrib *)object;
//    return [super isEqual:object] && self.inserted == other.inserted;
//}
//
//@end


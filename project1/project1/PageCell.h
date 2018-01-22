
#import <UIKit/UIKit.h>

@interface PageCell : UICollectionViewCell
@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

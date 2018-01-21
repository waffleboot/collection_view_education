
#import <UIKit/UIKit.h>

@interface PageCell : UICollectionViewCell
@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

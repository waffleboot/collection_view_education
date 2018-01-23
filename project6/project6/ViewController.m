
#import "ViewController.h"

@interface MyLayout : UICollectionViewFlowLayout
@end

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSUInteger count;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [[MyLayout alloc] init];
    layout.itemSize = CGSizeMake(60, 60);

    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.view addSubview:self.collectionView];
    
    UITapGestureRecognizer *r = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    [self.view addGestureRecognizer:r];
}

- (void)click:(UITapGestureRecognizer *)r {
//    [self.collectionView performBatchUpdates:^{
        self.count += 1;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.count - 1 inSection:0];
        [self.collectionView insertItemsAtIndexPaths:@[indexPath]];
//    } completion:^(BOOL finished) {
    
//    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    NSLog(@"%@", cell.layer.animationKeys);
    cell.backgroundColor = UIColor.whiteColor;
    return cell;
}

@end

@implementation MyLayout

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [super layoutAttributesForItemAtIndexPath:indexPath];
}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    UICollectionViewLayoutAttributes *a = [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
    a.center = self.collectionView.center;
    return a;
}

@end

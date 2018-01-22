
#import "ViewController.h"

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *redView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3, 3)];
    self.redView.backgroundColor = UIColor.redColor;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(60, 60);

    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView addSubview:self.redView];
    
    [self.view addSubview:self.collectionView];
    
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(time:) userInfo:nil repeats:YES];
}

- (void)time:(NSTimer *)timer {
//    NSLog(@"collectionView.bounds = %@", NSStringFromCGRect(self.collectionView.bounds));
//    NSLog(@"collectionView.center %@", NSStringFromCGPoint(self.collectionView.center));
    NSLog(@"%@", NSStringFromCGPoint([self.view convertPoint:self.view.center toView:self.collectionView]));
    self.redView.center = [self.view convertPoint:self.view.center toView:self.collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 80;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = UIColor.whiteColor;
    return cell;
}

@end

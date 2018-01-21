
#import "PageCell.h"

@interface PageCell () <UICollectionViewDataSource,UICollectionViewDelegate>
@end

@implementation PageCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
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
    return 9;
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
    label.text = [[NSNumber numberWithUnsignedInteger:self.index] stringValue];
    cell.backgroundColor = self.color;
    return cell;
}

@end

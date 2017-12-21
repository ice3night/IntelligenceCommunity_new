//
//  TodayCMDCell.m
//  WisdomCommunity
//
//  Created by legend on 2017/10/14.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "TodayCMDCell.h"
#import "ProductCMDCell.h"
@interface TodayCMDCell()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *sourceArr;
@end
@implementation TodayCMDCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.sourceArr = [NSMutableArray array];
        [self createUI];
        self.backgroundColor = CQColorFromRGB(0xf3f2fa);
    }
    return self;
}
- (void)createUI {
    //创建布局类
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.headerReferenceSize = CGSizeMake(0, 0);
    layout.footerReferenceSize = CGSizeMake(0, 0);
    //最小水平间隙
    layout.minimumInteritemSpacing = 0;
    //最小垂直间隙
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置单元格的大小
    layout.itemSize = CGSizeMake((CYScreanH - 64) * 0.21-10,  (CYScreanH - 64) * 0.21-10);
    
    //下面横向滚动collectionView
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(5, 0, CYScreanW-10, (CYScreanH - 64) * 0.21-5) collectionViewLayout:layout];
   
    [self.contentView addSubview:self.collectionView];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = CQColorFromRGB(0xf7fafc);
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = YES;
    self.collectionView.showsVerticalScrollIndicator = YES;
    //xib注册
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductCMDCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ProductCMDCell"];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductCMDCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProductCMDCell" forIndexPath:indexPath];
    [cell setModel:self.sourceArr[indexPath.item]];
    return cell;
}

-(void)setTempArr:(NSArray *)tempArr {
    self.sourceArr = tempArr.mutableCopy;
    [self.collectionView reloadData];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sourceArr.count;
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if ([view isKindOfClass:[UICollectionView class]]) {
        return self;
    }
    return [super hitTest:point withEvent:event];
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
        return CGSizeMake(CYScreanW*4/5,  (CYScreanH - 64) * 0.21);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate gotoDetail:self.sourceArr[indexPath.item]];
}
@end

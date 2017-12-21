//
//  ComMallView.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/7.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "ComMallView.h"

@implementation ComMallView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = CQColor(242, 242, 242, 1);
    }
    [self collectionCM];
    return self;
}
-(void)collectionCM
{
    //初始化图片数组
    _iconMCVArray = [NSArray arrayWithObjects:@"icon_mall_runcaiyuan",@"icon_mall_supermarket",@"icon_mall_shop",@"icon_mall_tuangou",nil];
    self.promptMCVArray = @[@"润菜园",@"超市",@"微店",@"团购"];
    //设置背景颜色
    self.backgroundColor = [UIColor clearColor];
    //1\初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionview滚动方向
    // [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //2\设置headerView的尺寸大小
    layout.headerReferenceSize = CGSizeMake(0, 0);
    
    
    //3\初始化collextionVIewCell
    mainCMallCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
    mainCMallCollectionView.backgroundColor = CQColor(242, 242, 242, 1);
    [self addSubview:mainCMallCollectionView];
    
    //注册collectionViewCell
    //注意，此处的ReuseIdentifier必须和cellForItemAtIndexPath方法中一致，必须为cellId
    [mainCMallCollectionView registerClass:[ComMallCollectionViewCell class] forCellWithReuseIdentifier:@"cellCMId"];
    //注册headerView 此处的ReuseiDentifier必须个cellForItemAtIndexPath方法中一致，均为reusableView
    [mainCMallCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    //设置代理
    mainCMallCollectionView.delegate = self;
    mainCMallCollectionView.dataSource = self;
    
    mainCMallCollectionView.scrollEnabled = NO;
    
}

//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//返回section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}
//设置每个方块的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CYScreanW * 0.16,(CYScreanH - 64) * 0.25);
}
//设置水平间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return CYScreanW * 0.072;
}
//设置每个item四周的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake( 0, CYScreanW * 0.072, 0, CYScreanW * 0.072);
}

//每个cell的数据
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    _cell = (ComMallCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellCMId" forIndexPath:indexPath];
    if (indexPath.section == 0)
    {
        _cell.topMCImage.image = [UIImage imageNamed:_iconMCVArray[indexPath.row]];
        _cell.promtpmcLabel.text = [NSString stringWithFormat:@"%@",self.promptMCVArray[indexPath.row]];
    }
    else
    {
        _cell.topMCImage.image = [UIImage imageNamed:_iconMCVArray[indexPath.row + 3]];
        _cell.promtpmcLabel.text = [NSString stringWithFormat:@"%@",self.promptMCVArray[indexPath.row + 3]];
    }
    
    
    _cell.backgroundColor = [UIColor clearColor];
    return _cell;
}
//点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld,%ld",indexPath.section,indexPath.row);
    
    //    HomeCollectionViewCell *cell = (HomeCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
//            [self.CMallDelegate TakeOutFood];
            //菜篮子
            [self.CMallDelegate foodMarket];
        }
        else if (indexPath.row == 1)
        {
            //超市
            [self.CMallDelegate supermarketFunction];
        }
        else if (indexPath.row == 2)
        {
            //微店
            [self.CMallDelegate microShop];
        }
        else if (indexPath.row == 3)
        {
            //团购
            [self.CMallDelegate groupPurchase];
        }
    }
    else
    {
        if (indexPath.row == 0)
        {
            [self.CMallDelegate groupPurchase];
        }
        
    }
}

@end

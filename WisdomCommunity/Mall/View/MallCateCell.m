//
//  MallCateCell.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/12/18.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "MallCateCell.h"
@interface MallCateCell()
@property (weak, nonatomic) IBOutlet UIView *vegView;
@property (weak, nonatomic) IBOutlet UIView *spView;
@property (weak, nonatomic) IBOutlet UIView *weShopView;
@property (weak, nonatomic) IBOutlet UIView *tuangouView;
@end
@implementation MallCateCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor =CQColor(242, 242, 242, 1);
    self.vegView.backgroundColor =CQColor(242, 242, 242, 1);
    self.spView.backgroundColor =CQColor(242, 242, 242, 1);
    self.weShopView.backgroundColor =CQColor(242, 242, 242, 1);
    self.tuangouView.backgroundColor =CQColor(242, 242, 242, 1);
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"MallCateCell" owner:self options:nil];
        
        // 如果路径不存在，return nil
        if (arrayOfViews.count < 1)
        {
            return nil;
        }
        // 如果xib中view不属于UICollectionViewCell类，return nil
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]])
        {
            return nil;
        }
        // 加载nib
        self = [arrayOfViews objectAtIndex:0];
    }
    return self;
}
- (IBAction)tuangou:(id)sender {
    [self.delegate goToTuangou];
}
- (IBAction)weshop:(id)sender {
    [self.delegate goToWeishop];
}
- (IBAction)runcaiyuan:(id)sender {
    NSLog(@"runcaiyuan");
    [self.delegate goToRuncaiyuan];
}
- (IBAction)superMarket:(id)sender {
    [self.delegate goToSupermarket];
}
@end

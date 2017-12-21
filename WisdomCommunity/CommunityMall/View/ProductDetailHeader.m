//
//  ProductDetailHeader.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/11.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "ProductDetailHeader.h"
#import "JXBAdPageView.h"
#import "RatingBar.h"
#import "HJCAjustNumButton.h"
#import "MerchantsPageViewController.h"
@interface ProductDetailHeader()
@property (nonatomic, weak) JXBAdPageView *imageShow;
@property (nonatomic, weak) UITextView *title;
@property (nonatomic, weak) UITextView *feature;
@property (nonatomic, weak) UILabel *price;
@property (nonatomic, weak) UILabel *salesCount;
@property (nonatomic, weak) HJCAjustNumButton *count;
@property (nonatomic, weak) UILabel *num;
@property (nonatomic, weak) UILabel *scoreLabel;
@property (nonatomic, weak) UIView *shopView;
@property (nonatomic, weak) UIView *shopParentView;

@property (nonatomic, weak) UIImageView *shopImage;
@property (nonatomic, weak) UILabel *shopName;
@property (nonatomic, weak) UILabel *evluateTip;
@property (nonatomic, weak) RatingBar *evluateBar;

@property (nonatomic, weak) UIButton *shopButton;
@property (nonatomic, weak) UITextView *contentTextView;
@property (nonatomic, strong) NSMutableArray *imageArray;
@end
@implementation ProductDetailHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UITextView *titleViewLabel = [[UITextView alloc] init];
        titleViewLabel.showsVerticalScrollIndicator = NO;
        titleViewLabel.showsHorizontalScrollIndicator = NO;
        titleViewLabel.scrollEnabled = NO;
        titleViewLabel.font = [UIFont systemFontOfSize:16];
        titleViewLabel.textContainer.lineFragmentPadding = 0;
        titleViewLabel.textColor = CQColor(51, 51, 51, 1);
        titleViewLabel.textContainerInset = UIEdgeInsetsZero;
        titleViewLabel.editable = NO;
        
        UITextView *featureLabel = [[UITextView alloc] init];
        featureLabel.showsVerticalScrollIndicator = NO;
        featureLabel.showsHorizontalScrollIndicator = NO;
        featureLabel.scrollEnabled = NO;
        featureLabel.font = [UIFont systemFontOfSize:14];
        featureLabel.textContainer.lineFragmentPadding = 0;
        featureLabel.textColor = CQColor(255, 27, 56, 1);
        featureLabel.textContainerInset = UIEdgeInsetsZero;
        featureLabel.editable = NO;
        
        JXBAdPageView *showViewImage = [[JXBAdPageView alloc] init];
        showViewImage.bWebImage = YES;//网络图片
        showViewImage.iDisplayTime = 3;//停留时间
        
        UIButton *shopBtn = [[UIButton alloc] init];
        [shopBtn addTarget:self action:@selector(shopAction) forControlEvents:UIControlEventTouchUpInside];
        UILabel *priceViewLabel = [[UILabel alloc] init];
        priceViewLabel.font = [UIFont systemFontOfSize:14];
        UILabel *salesCountViewLabel = [[UILabel alloc] init];
        priceViewLabel.textColor = CQColor(244,2,18, 1);

        salesCountViewLabel.font = [UIFont systemFontOfSize:14];
        salesCountViewLabel.textColor = CQColor(153,153,153, 1);
        HJCAjustNumButton *countView = [[HJCAjustNumButton alloc] init];
        UILabel *numLabel = [[UILabel alloc] init];
        numLabel.font = [UIFont systemFontOfSize:12];
        numLabel.textColor = CQColor(102, 102, 102, 1);
        
        UILabel *scoreViewlabel = [[UILabel alloc] init];
        scoreViewlabel.font = [UIFont systemFontOfSize:12];
        scoreViewlabel.textAlignment = NSTextAlignmentRight;
        scoreViewlabel.textColor = CQColor(254,139,112, 1);
        UIView *shopBgView = [[UIView alloc] init];
        shopBgView.backgroundColor = [UIColor whiteColor];
        
        UIView *shopParentBgView = [[UIView alloc] init];
        shopParentBgView.backgroundColor = CQColor(240, 240, 240, 1);
        
        UIImageView *shopImage = [[UIImageView alloc] init];
        UILabel *shopName = [[UILabel alloc] init];
        shopName.textColor = CQColor(51,51,51, 1);
    
        UILabel *evluateTipView = [[UILabel alloc] init];
        evluateTipView.font = [UIFont systemFontOfSize:12];
        evluateTipView.textAlignment = NSTextAlignmentRight;
        evluateTipView.textColor = CQColor(153,153,153, 1);
        
        RatingBar *evluateBar = [[RatingBar alloc]init];
        evluateBar.isIndicator = YES;
        [evluateBar setImageDeselected:@"icon_star_blank" halfSelected:nil fullSelected:@"icon_star_selected" andDelegate:nil];
        UITextView *content = [[UITextView alloc] init];
        content.showsVerticalScrollIndicator = NO;
        content.showsHorizontalScrollIndicator = NO;
        content.scrollEnabled = NO;
        content.font = [UIFont systemFontOfSize:14];
        content.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _imageShow = showViewImage;
        _title = titleViewLabel;
        _price = priceViewLabel;
        _salesCount = salesCountViewLabel;
        _count = countView;
        _num = numLabel;
        _scoreLabel = scoreViewlabel;
        _shopView = shopBgView;
        _shopImage = shopImage;
        _shopName = shopName;
        _evluateBar = evluateBar;
        _evluateTip = evluateTipView;
        _shopParentView = shopParentBgView;
        _contentTextView = content;
        _shopButton = shopBtn;
        _shopParentView = shopParentBgView;
        _feature = featureLabel;
        [_shopView addSubview:_shopImage];
        [_shopView addSubview:_shopName];
        [_shopView addSubview:_evluateTip];
        [_shopView addSubview:_evluateBar];
        [_shopParentView addSubview:_shopView];

        [self addSubview:_imageShow];
        [self addSubview:_title];
        [self addSubview:_feature];
        [self addSubview:_price];
        [self addSubview:_salesCount];
        [self addSubview:_count];
        [self addSubview:_num];
        [self addSubview:_scoreLabel];
        [self addSubview:_shopParentView];
        [self addSubview:_shopButton];
        [self addSubview:_contentTextView];
    }
    return self;
}
- (void)shopAction
{
    [self.delegate goMerchant:_shopId];
}
-(void)setDetailProductHeaderFrame:(DetailProductHeaderFrame *)detailProductHeaderFrame
{
    _detailProductHeaderFrame = detailProductHeaderFrame;
    self.imageArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < _detailProductHeaderFrame.frameArray.count; i ++) {
        UIImageView *image = [[UIImageView alloc] init];
        image.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:image];
        [self.imageArray addObject:image];
    }
    //    // 1.给子控件赋值数据
    [self settingData];
    // 2.设置frame
    [self settingFrame];
}
/**
 *  设置子控件的数据
 */
- (void)settingData
{
    _amount = [NSNumber numberWithInt:1];
    DetailProductModel *model = self.detailProductHeaderFrame.detailProductModel;
    self.feature.text = model.content;
    NSLog(@"库存%@",model.surplusNum);
//    [_count setMaxNum:[NSString stringWithFormat:@"%@",model.surplusNum]];
    _count.callBack = ^(NSString *currentNum){
        self.amount = @([currentNum integerValue]);
        double finalPrice = [model.price doubleValue] *[currentNum doubleValue];
        self.price.text = [@"¥" stringByAppendingString:[NSString stringWithFormat:@"%.2f", finalPrice]];
        _finalPrice = [NSString stringWithFormat:@"%.2f", finalPrice];
    };
    _evluateTip.text = @"评价：";
    _count.maxCallBack = ^(NSString *max){
        [MBProgressHUD showError:max ToView:self];
    };
    self.num.text = @"数量";

    NSArray *array = [model.slideshow componentsSeparatedByString:@","];
    [self.imageShow startAdsWithBlock:array block:^(NSInteger clickIndex)
     {
         NSLog(@"第%ld张",(long)clickIndex);
     }];
    ;
    self.title.text = model.name;
    self.price.text = [@"¥" stringByAppendingString:[NSString stringWithFormat:@"%@",model.price]];
    self.salesCount.text = [[@"已售" stringByAppendingString:[NSString stringWithFormat:@"%@",model.successnum]] stringByAppendingString:@"份"];
    
    self.scoreLabel.text = [@"购买此产品可获得" stringByAppendingString:[[NSString stringWithFormat:@"%@",model.score] stringByAppendingString:@"积分"]];
    [_shopImage sd_setImageWithURL:[NSURL URLWithString:model.shopImg]];
    _shopName.text = model.shopName;
    _contentTextView.text = model.intro;
    NSLog(@"啦啦啦啦%f",[model.averageStar floatValue]);
    [_evluateBar displayRating:[model.averageStar floatValue]];
    NSArray *imgArray = [model.imageStr componentsSeparatedByString:@","];
    if (imgArray.count > 0) {// 有配图
        for (int i = 0; i < imgArray.count; i++) {
            NSString *maxStr = imgArray[i];
            NSArray *array = [maxStr componentsSeparatedByString:@"-"];
            UIImageView *image = _imageArray[i];
            [image sd_setImageWithURL:[NSURL URLWithString:array[0]]];
            [image setContentMode:UIViewContentModeScaleToFill];
        }
    }
}
/**
 *  设置子控件的frame
 */
- (void)settingFrame
{
    _imageShow.frame = _detailProductHeaderFrame.slideShowF;
    _title.frame = _detailProductHeaderFrame.titleF;
    _feature.frame = _detailProductHeaderFrame.featureF;
    _price.frame = _detailProductHeaderFrame.priceF;
    _salesCount.frame = _detailProductHeaderFrame.salesCountF;
    _num.frame = _detailProductHeaderFrame.numtipF;
    _count.frame = _detailProductHeaderFrame.salesF;
    _scoreLabel.frame = _detailProductHeaderFrame.scoresF;
    _evluateTip.frame = _detailProductHeaderFrame.evaluateTipF;
    _evluateBar.frame = _detailProductHeaderFrame.evaluateF;
    [_evluateBar setNowF:_detailProductHeaderFrame.evaluateF];
    _shopView.frame = _detailProductHeaderFrame.shaopViewF;
    _shopParentView.frame = _detailProductHeaderFrame.shopParentViewF;
    _shopImage.frame = _detailProductHeaderFrame.shopImageF;
    _shopName.frame = _detailProductHeaderFrame.shopNameF;
    _shopButton.frame = _detailProductHeaderFrame.shaopViewF;
    _contentTextView.frame = _detailProductHeaderFrame.detailF;
    
    NSArray *imgArray = [_detailProductHeaderFrame.detailProductModel.imageStr componentsSeparatedByString:@","];
    if (imgArray.count > 0) {// 有配图
        for (int i = 0;i < imgArray.count;i++) {
            NSValue *value = _detailProductHeaderFrame.frameArray[i];
            CGRect frame = [value CGRectValue];
            UIImageView *image = self.imageArray[i];
            image.frame = frame;
        }
        
    }
}
@end

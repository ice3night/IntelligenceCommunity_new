//
//  SearchResultHeader.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/12/18.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "SearchResultHeader.h"
@interface SearchResultHeader()
@property (weak, nonatomic) IBOutlet UIButton *priceBtn;
@property (weak, nonatomic) IBOutlet UIButton *salesBtn;
@property (weak, nonatomic) IBOutlet UIButton *viewBtn;

@end
@implementation SearchResultHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib
{
    [super awakeFromNib];
    [_priceBtn setTitleColor:CQColor(216,30,6, 1) forState:UIControlStateSelected];
    [_priceBtn setTitleColor:CQColor(102,102,102, 1) forState:UIControlStateNormal];
    
    [_viewBtn setTitleColor:CQColor(216,30,6, 1) forState:UIControlStateSelected];
    [_viewBtn setTitleColor:CQColor(102,102,102, 1) forState:UIControlStateNormal];
    [_salesBtn setTitleColor:CQColor(216,30,6, 1) forState:UIControlStateSelected];
    [_salesBtn setTitleColor:CQColor(102,102,102, 1) forState:UIControlStateNormal];
}
- (IBAction)priceAction:(id)sender {
    if (_priceBtn.selected == NO) {
        _priceBtn.selected = YES;
        _viewBtn.selected = NO;
        _salesBtn.selected = NO;
        [self.delegate priceAction];
    }
}
- (IBAction)salesAction:(id)sender {
    if (_salesBtn.selected == NO) {
        _salesBtn.selected = YES;
        _viewBtn.selected = NO;
        _priceBtn.selected = NO;
        [self.delegate salesAction];
    }
}
- (IBAction)viewAction:(id)sender {
    if (_viewBtn.selected == NO) {
        _viewBtn.selected = YES;
        _salesBtn.selected = NO;
        _priceBtn.selected = NO;
        [self.delegate viewAction];
    }
}

@end

//
//  HomeMsgView.m
//  WisdomCommunity
//
//  Created by xy z on 2017/10/9.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "HomeMsgView.h"

@implementation HomeMsgView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView * view   =   [[[NSBundle mainBundle]loadNibNamed:@"HomeMsgView" owner:self options:nil] firstObject];
        view.frame = frame;
        [self addSubview:view];
    }
    return self;
}
@end

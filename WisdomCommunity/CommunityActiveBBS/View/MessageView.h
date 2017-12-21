//
//  MessageView.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/21.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageView : UIView
@property (weak, nonatomic) IBOutlet UIButton *priseBtn;
@property (weak, nonatomic) IBOutlet UIButton *MessageBtn;
+(MessageView *)instanceView;
@end

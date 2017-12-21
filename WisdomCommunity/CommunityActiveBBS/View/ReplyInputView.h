//
//  ReplyInputView.h
//  MyFamily
//
//  Created by 陆洋 on 15/7/7.
//  Copyright (c) 2015年 maili. All rights reserved.
//

#import <UIKit/UIKit.h>
#define padding 10
@protocol ReplyViewDelegate
//- (void) pop;
- (void) response:(NSString *)content;
@end
//改变根据文字改变TextView的高度
typedef void (^ContentSizeBlock)(CGSize contentSize);
//添加评论
typedef void (^replyAddBlock)(NSString *replyText,NSInteger inputTag);
@interface ReplyInputView : UIView
@property (nonatomic,assign)NSInteger replyTag;
@property (nonatomic,weak) id <ReplyViewDelegate> delegate;
-(void)setContentSizeBlock:(ContentSizeBlock) block;
-(void)setReplyAddBlock:(replyAddBlock)block;
-(id)initWithFrame:(CGRect)frame andAboveView:(UIView *)bgView;
@end

//
//  SeeImagesView.h
//  testFramworkDemo
//
//  Created by GT_MAC_2 on 15/7/16.
//  Copyright (c) 2015年 hyc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeeImageObj.h"
@interface SeeImagesView : UIView<UIActionSheetDelegate>
//是否开启 点击手势
@property (nonatomic,assign) BOOL isOpen;

-(void)singleTap:(UITapGestureRecognizer*)recognizer;
//设置当前图片显示的 图片对象
- (void) setObj :(id) aa  ImageArray:(NSMutableArray *)array;

////外部调用 这只 图片对象数组
//- (void) setImagesArray :(NSMutableArray *)arr;
@end

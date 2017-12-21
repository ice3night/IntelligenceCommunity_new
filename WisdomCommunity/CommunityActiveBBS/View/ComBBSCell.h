//
//  ComBBSCell.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/18.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "TableViewCell.h"
#import "ComBBSCellFrame.h"
#import "comBBSModel.h"
#import "FollowNoteCellFrame.h"
#import "FollowNoteCellTableViewCell.h"
@protocol PopDelegate
- (void) refresh:(FollowNoteCellFrame *)cellFrame;
- (void) responseToNote:(FollowNoteCellFrame *)cellFrame;
- (void) deleteNote:(NSString *)noteId;

@end
typedef void (^ResponseBlock)(FollowNoteCellFrame *cellframe);

@interface ComBBSCell : TableViewCell<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,weak) id <PopDelegate> delegate;
@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *nameView;
@property (nonatomic, weak) UITextView *detailView;
@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, weak) UILabel *timeView;
@property (nonatomic, weak) UIButton *deleteBtn;
@property (nonatomic, weak) UIButton *popView;
@property (nonatomic, weak) UIView *priseBgView;
@property (nonatomic, weak) UIImageView *priseImgView;
@property (nonatomic, weak) UITextView *priseNameView;
@property (nonatomic, weak) UITableView *comView;
@property (nonatomic, strong) ComBBSCellFrame *comBBSCellFrame;
@property (nonatomic, copy) NSMutableArray *comments;
@property (nonatomic, copy) NSMutableArray *imgs;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

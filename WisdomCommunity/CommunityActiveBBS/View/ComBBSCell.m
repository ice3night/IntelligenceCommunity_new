//
//  ComBBSCell.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/18.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "ComBBSCell.h"
#import "PriseDo.h"
#import "FollowNoteDO.h"
#import "MJExtension.h"
#import "CommunityCollectionCell.h"
@interface ComBBSCell()
{
}
@end
@implementation ComBBSCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"ComBBSCell";
    // 1.缓存中取
    ComBBSCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[ComBBSCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *iconView = [[UIImageView alloc] init];
        UILabel *nameView = [[UILabel alloc] init];
        nameView.font = [UIFont systemFontOfSize:14];
        nameView.textColor = CQColor(87,101,85, 1);

        UITextView *detailView = [[UITextView alloc] init];
        detailView.showsVerticalScrollIndicator = NO;
        detailView.showsHorizontalScrollIndicator = NO;
        detailView.scrollEnabled = NO;
        detailView.textContainer.lineFragmentPadding = 0;
        detailView.textContainerInset = UIEdgeInsetsZero;

        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.scrollEnabled = NO;
        collectionView.bounces = NO;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [collectionView registerClass:[CommunityCollectionCell class] forCellWithReuseIdentifier:@"CommunityCollectionCell"];
        
        UILabel *timeView = [[UILabel alloc] init];
        timeView.font = [UIFont systemFontOfSize:12];
        timeView.textColor = CQColor(198,198,198, 1);
        
        UIButton *deleteView = [[UIButton alloc] init];
        [deleteView setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [deleteView setTitle:@"删除" forState:UIControlStateNormal];
        [deleteView addTarget:self action:@selector(deleteNote) forControlEvents:UIControlEventTouchUpInside];
        UIButton *popView = [[UIButton alloc] init];
        [self.popView addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *priseBgView = [[UIView alloc] init];
        priseBgView.backgroundColor = CQColor(243,243,243, 1);
        
        UIImageView *priseImgView = [[UIImageView alloc] init];
        UITextView *priseNameView = [[UITextView alloc] init];
        priseNameView.backgroundColor = CQColor(243,243,243, 1);
        priseNameView.font = [UIFont boldSystemFontOfSize:12.0];
        priseNameView.textColor = CQColor(18,165,255, 1);
        priseNameView.showsVerticalScrollIndicator = NO;
        priseNameView.showsHorizontalScrollIndicator = NO;
        priseNameView.scrollEnabled = NO;
        priseNameView.textContainer.lineFragmentPadding = 0;
        priseNameView.textContainerInset = UIEdgeInsetsZero;
        
        UITableView *comView = [[UITableView alloc] init];
        comView.backgroundColor = [UIColor redColor];
        comView.showsVerticalScrollIndicator = NO;
        comView.showsHorizontalScrollIndicator = NO;
        comView.scrollEnabled = NO;
        comView.bounces = NO;
        comView.backgroundColor = [UIColor redColor];
        comView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _iconView = iconView;
        _nameView = nameView;
        _detailView = detailView;
        _timeView = timeView;
        _deleteBtn = deleteView;
        _popView = popView;
        _priseBgView = priseBgView;
        _priseImgView = priseImgView;
        _priseNameView = priseNameView;
        _collectionView = collectionView;
        _comView = comView;
        [_priseBgView addSubview:_priseImgView];
        [_priseBgView addSubview:_priseNameView];
        [self.contentView addSubview:_iconView];
        [self.contentView addSubview:_nameView];
        [self.contentView addSubview:_detailView];
        [self.contentView addSubview:_collectionView];
        [self.contentView addSubview:_timeView];
        [self.contentView addSubview:_deleteBtn];
        [self.contentView addSubview:_popView];
        [self.contentView addSubview:_comView];
        [self.contentView addSubview:_priseBgView];
    }
    return self;
}
- (void)pop
{
//    [self.delegate pop];
}
- (void)deleteNote
{
    comBBSModel *model = _comBBSCellFrame.comBBSModel;
    NSLog(@"要删除的标题%@",model.id);
//    [self.delegate deleteNote:[NSString stringWithFormat:@"%@",model.id]];
}
-(void)setComBBSCellFrame:(ComBBSCellFrame *)comBBSCellFrame
{
    _comBBSCellFrame = comBBSCellFrame;
    NSArray *commentArray = [FollowNoteDO objectArrayWithKeyValuesArray:_comBBSCellFrame.comBBSModel.followNoteDO];
    _comments = [[NSMutableArray alloc] init];
    for(FollowNoteDO *followNote in commentArray) {
        FollowNoteCellFrame *noteFrame = [[FollowNoteCellFrame alloc] init];
        NSLog(@"cell的state%@",followNote.state);
        [noteFrame setFollowNoteDO:followNote];
        _comView.delegate = self;
        _comView.dataSource = self;
        [_comments addObject:noteFrame];
    }
    [_comView reloadData];
    NSArray *array = [_comBBSCellFrame.comBBSModel.imgAddress componentsSeparatedByString:@","];
    _imgs = [[NSMutableArray alloc] initWithArray:array];
    [self.collectionView reloadData];
    // 1.给子控件赋值数据
    [self settingData];
    // 2.设置frame
    [self settingFrame];
}
/**
 *  设置子控件的数据
 */
- (void)settingData
{
    comBBSModel *model = self.comBBSCellFrame.comBBSModel;
    NSDictionary *account = model.accountDO;
    NSString *headimg = [account objectForKey:@"imgAddress"];
    NSString *nickName = [account objectForKey:@"nickName"];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:headimg]];
    self.nameView.text = [NSString stringWithFormat:@"%@",[ActivityDetailsTools UTFTurnToStr:nickName]];
    NSString *isDel = model.isDel;
    if((!([isDel isEqualToString:@""]))&&(!(isDel == nil))){
        if ([isDel isEqualToString:@"1"]) {
            self.deleteBtn.hidden = NO;
        }else{
            self.deleteBtn.hidden = YES;
        }
    }
    self.deleteBtn.hidden = YES;
    self.detailView.text = [ActivityDetailsTools UTFTurnToStr:model.content];
    self.timeView.text = [CYSmallTools timeWithTimeIntervalString:[NSString stringWithFormat:@"%@",model.gmtCreate]];
    [self.popView setImage:[UIImage imageNamed:@"icon_community_message"] forState:UIControlStateNormal];
    NSArray *priseArray = [PriseDo objectArrayWithKeyValuesArray:_comBBSCellFrame.comBBSModel.notePraiseDo];
    if (priseArray.count == 0) {
        _priseBgView.hidden = YES;
    }else{
        _priseBgView.hidden = NO;
        _priseImgView.image = [UIImage imageNamed:@"icon_community_prise"];
        NSString *priseMixName = @"";
        for (PriseDo *priseDo in priseArray) {
            if ([priseDo isEqual:[priseArray lastObject]]) {
                priseMixName = [priseMixName stringByAppendingString:[ActivityDetailsTools UTFTurnToStr:priseDo.praiserName]];
            }else{
                priseMixName = [[priseMixName stringByAppendingString:[ActivityDetailsTools UTFTurnToStr:priseDo.praiserName]]
                                stringByAppendingString:@","];
            }
        }
        _priseNameView.text = priseMixName;
    }
}
/**
 *  设置子控件的frame
 */
- (void)settingFrame
{
    _iconView.frame = _comBBSCellFrame.iconF;
    _nameView.frame = _comBBSCellFrame.nameF;
    _detailView.frame = _comBBSCellFrame.contentF;
    _collectionView.frame = _comBBSCellFrame.picF;
    _timeView.frame = _comBBSCellFrame.timeF;
    _deleteBtn.frame = _comBBSCellFrame.deleteF;
    _popView.frame = _comBBSCellFrame.popF;
    _priseBgView.frame = _comBBSCellFrame.priseBgF;
    _priseImgView.frame = _comBBSCellFrame.priseIvF;
    _priseNameView.frame = _comBBSCellFrame.priseNameF;
    _comView.frame = _comBBSCellFrame.commentTableF;
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _comments.count;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FollowNoteCellTableViewCell *cell = [FollowNoteCellTableViewCell cellWithTableView:tableView];
    FollowNoteCellFrame *cellFrame = _comments[indexPath.row];
    cell.selectionStyle = UITableViewCellAccessoryNone;
    cell.followNoteCellFrame = cellFrame;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FollowNoteCellFrame *frame = _comments[indexPath.row];
    return frame.cellHeight;
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FollowNoteCellFrame *cellFrame = _comments[indexPath.row];
    [self.delegate responseToNote:cellFrame];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imgs.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CommunityCollectionCell *cell = (CommunityCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CommunityCollectionCell" forIndexPath:indexPath];
    NSString *image = self.imgs[indexPath.row];
    cell.imgAddress = image;
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((CYScreanW-CGRectGetMaxX(_comBBSCellFrame.iconF)-40)/3, (CYScreanW-CGRectGetMaxX(_comBBSCellFrame.iconF)-40)/3);
}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 10.0;
//}
//- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(0, 30, 0, 30); // top, left, bottom, right
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

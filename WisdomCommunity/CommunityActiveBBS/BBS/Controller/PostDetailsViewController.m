//
//  PostDetailsViewController.m
//  WisdomCommunity
// 点击帖子或者点击社区大小事下面tableView每一行的  帖子详情控制器
//  Created by bridge on 16/12/13.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "PostDetailsViewController.h"

@interface PostDetailsViewController ()

@end

@implementation PostDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"self.BBSDetailsDict = %@",self.BBSDetailsDict);
//    [self initBBSDData];
    [self setPostStyle];
    //增加监听，当键盘出现或改变时收出消息
    [self setNotification];
    [self initPostController];
    //帖子详情
    [self GetPostDetails:[self.BBSDetailsDict objectForKey:@"id"]];
    //获取帖子评论
    [self getPostDetailsRequest:[self.BBSDetailsDict objectForKey:@"id"]];
}
//初始化数据
- (void) initPostModel:(NSArray *)array
{
    //数据源
    self.PostDetailsModelarray = [[NSMutableArray alloc] init];
    self.PostDetailsHeight = [[NSMutableArray alloc] init];
    for (int i = 0; i < array.count; i ++)
    {
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:array[i]];
        NSString *content = [ActivityDetailsTools UTFTurnToStr:[dict objectForKey:@"content"]];
        CGSize size = [ActivityDetailsTools getSizeWithText:content font:[UIFont systemFontOfSize:15.0f]];
        //记录评论高度
        [self.PostDetailsHeight addObject:[NSString stringWithFormat:@"%.f",size.height]];
        NSString *fromDo = [NSString stringWithFormat:@"%@",[dict objectForKey:@"accountDO"]];
        if (fromDo.length > 6)
        {
            NSDictionary *fromDict = [NSDictionary dictionaryWithDictionary:[dict objectForKey:@"accountDO"]];
            [self.PostDetailsModelarray addObject:[self dataTurnModel:[fromDict objectForKey:@"nickName"] withPost:content withTime:[dict objectForKey:@"gmtCreate"] withHead:[fromDict objectForKey:@"imgAddress"]]];
        }
        else
        {
            [self.PostDetailsModelarray addObject:[self dataTurnModel:@"未获取" withPost:content withTime:@"未获取时间信息" withHead:@""]];
        }
    }
    //刷新评论
    [self.PostDetailsTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
//    if (self.postHeight > 0) {
//        [self.PostDetailsTableView reloadData];
//    }
}
//数据转模型
- (PostDetailsModel *) dataTurnModel:(NSString *)name withPost:(NSString *)post withTime:(NSString *)time withHead:(NSString *)head
{
    NSDictionary *dict = @{
                           @"headImageString":head,
                           @"nameString":name,
                           @"timeString":time,
                           @"postString":post
                           };
    PostDetailsModel *model = [PostDetailsModel bodyWithDict:dict];
    return model;
}
//设置样式
- (void) setPostStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"帖子详情";
}
//初始化数据源
- (void) initBBSDData
{
    //数据源
    self.postPictureArray = [[NSArray alloc] init];
    //官方帖子
    if ([[self.BBSDetailsDict objectForKey:@"flag"] isEqual:@"2"])
    {
        self.postHeight = (CYScreanH - 64) * 0.21;
    }
    else
    {
        NSString *post = [ActivityDetailsTools UTFTurnToStr:[self.BBSDetailsDict objectForKey:@"content"]];
        CGSize size =  [ActivityDetailsTools getSizeWithText:post font:[UIFont systemFontOfSize:17.0f]];
        //图片信息
        NSString *pictureString = [NSString stringWithFormat:@"%@",[self.BBSDetailsDict objectForKey:@"imgAddress"]];
        self.postPictureArray = [pictureString componentsSeparatedByString:@","];
        NSLog(@"self.postPictureArray = %@",self.postPictureArray);
        NSInteger number = 0;
        for (NSString *content in self.postPictureArray)
        {
            if (content.length >  6)
            {
                number += 1;
            }
        }
        if (pictureString.length <= 6)
        {
            self.postHeight = size.height + (CYScreanH - 64) * 0.01;
        }
        else if (number >= 1 && number <= 3)
        {
            self.postHeight = size.height + (CYScreanH - 64) * 0.23;
        }
        else
            self.postHeight = size.height + (CYScreanH - 64) * 0.45;
    }
    //一个cell刷新
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:0];  //你需要更新的组数中的cell
    
    [self.PostDetailsTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone]; //collection 相同
//    [self.PostDetailsTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
//    if (self.PostDetailsModelarray != nil) {
//        [self.PostDetailsTableView reloadData];
//    }
}
- (void) viewWillAppear:(BOOL)animated
{
    //记录进入帖子详情页
    [CYSmallTools saveDataString:@"YES" withKey:@"InputPostDetailsView"];
    
    [self.tabBarController.tabBar setHidden:YES];
}
- (void) viewWillDisappear:(BOOL)animated
{
    [self.backView removeFromSuperview];
}
- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.inputMessageTextView resignFirstResponder];
}
//初始化控件
- (void) initPostController
{
    //显示
    self.PostDetailsTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, (CYScreanH - 64) * 0.9)];
    self.PostDetailsTableView.delegate = self;
    self.PostDetailsTableView.dataSource = self;
    self.PostDetailsTableView.showsVerticalScrollIndicator = NO;
    self.PostDetailsTableView.backgroundColor = [UIColor whiteColor];
    self.PostDetailsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.PostDetailsTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //背景
    self.backView = [[UIView alloc] initWithFrame:CGRectMake( 0, (CYScreanH - 64) * 0.9 + 64, CYScreanW, (CYScreanH - 64) * 0.1)];
    self.backView.backgroundColor = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1.0];
    [self.navigationController.view addSubview:self.backView];
    //输入框
    _inputMessageTextView = [[UITextView alloc] initWithFrame:CGRectMake( CYScreanW * 0.05, (CYScreanH - 64) * 0.02, CYScreanW * 0.8, (CYScreanH - 64) * 0.06)];
    _inputMessageTextView.layer.borderColor = [UIColor whiteColor].CGColor;
    _inputMessageTextView.layer.borderWidth = 1;
    _inputMessageTextView.layer.cornerRadius = 5;
    _inputMessageTextView.delegate = self;
    _inputMessageTextView.textColor = [UIColor colorWithRed:0.769 green:0.769 blue:0.769 alpha:1.00];
    _inputMessageTextView.font = [UIFont fontWithName:@"Arial" size:17];
    [self.backView addSubview:_inputMessageTextView];
    //发送按钮
    CGSize sizeT = [@"发送" sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]}];
    CGSize sizeI = [UIImage imageNamed:@"Paper_plane"].size;
    self.sendButtonInfor = [[UIButton alloc] initWithFrame:CGRectMake( CYScreanW * 0.85, (CYScreanH - 64) * 0.02, CYScreanW * 0.15, (CYScreanH - 64) * 0.06)];
    self.sendButtonInfor.backgroundColor = [UIColor clearColor];
    [self.sendButtonInfor addTarget:self action:@selector(followPostRequest) forControlEvents:UIControlEventTouchUpInside];
    [self.sendButtonInfor setTitle:@"发送" forState:UIControlStateNormal];
    self.sendButtonInfor.titleLabel.font = [UIFont fontWithName:@"Arial" size:13];
    [self.sendButtonInfor setTitleColor:[UIColor colorWithRed:0.769 green:0.769 blue:0.769 alpha:1.00] forState:UIControlStateNormal];
    [self.sendButtonInfor setImage:[UIImage imageNamed:@"Paper_plane"] forState:UIControlStateNormal];
    self.sendButtonInfor.imageEdgeInsets = UIEdgeInsetsMake( 0, sizeT.width / 2, (CYScreanH - 64) * 0.03, -sizeT.width / 2);
    self.sendButtonInfor.titleEdgeInsets = UIEdgeInsetsMake( (CYScreanH - 64) * 0.03, -sizeI.width / 2, 0, sizeI.width / 2);
    [self.backView addSubview:self.sendButtonInfor];
}
//发送按钮
- (void) sendButtonPost
{
    if (self.inputMessageTextView.text.length > 0)
    {
        NSDictionary *dictT = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:ACCOUNTDATA]];
        NSString *headUrl;
        NSString *name;
        if ([[dictT objectForKey:@"success"] integerValue] == 1)
        {
            NSDictionary *dict = [NSDictionary dictionaryWithDictionary:[dictT objectForKey:@"returnValue"]];
            headUrl = [NSString stringWithFormat:@"%@",[dict objectForKey:@"imgAddress"]];
            name = [NSString stringWithFormat:@"%@",[dict objectForKey:@"nickName"]];
        }
        else
        {
            dictT = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:PERSONALDATA]];
            headUrl = [NSString stringWithFormat:@"%@",[dictT objectForKey:@"imgAddress"]];
            name = [NSString stringWithFormat:@"%@",[dictT objectForKey:@"nickName"]];
        }
        //记录评论高度
        CGSize size =  [ActivityDetailsTools getSizeWithText:self.inputMessageTextView.text.length ? self.inputMessageTextView.text : @"未获取" font:[UIFont systemFontOfSize:15.0f]];
        [self.PostDetailsHeight insertObject:[NSString stringWithFormat:@"%.f",size.height] atIndex:0];
        //发送
        [self.PostDetailsModelarray insertObject:[self dataTurnModel:name withPost:self.inputMessageTextView.text withTime:[CYSmallTools getTimeStamp] withHead:headUrl] atIndex:0];
        [self.PostDetailsTableView reloadData];
        //把最后一行滚动到最上面
        NSIndexPath *FirstIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        [self.PostDetailsTableView scrollToRowAtIndexPath:FirstIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        self.inputMessageTextView.text = nil;
        //放弃第一响应身份
        [self.inputMessageTextView resignFirstResponder];
        //设置frame
        self.backView.frame = CGRectMake( 0, (CYScreanH - 64) * 0.9 + 64, CYScreanW, (CYScreanH - 64) * 0.1);
        self.inputMessageTextView.frame = CGRectMake( CYScreanW * 0.05, (CYScreanH - 64) * 0.02, CYScreanW * 0.8, (CYScreanH - 64) * 0.06);
        self.sendButtonInfor.frame = CGRectMake( CYScreanW * 0.85, (CYScreanH - 64) * 0.02, CYScreanW * 0.15, (CYScreanH - 64) * 0.06);
        //改变评论数量
        [self.CommentButton setTitle:[NSString stringWithFormat:@"%d",[self.CommentButton.titleLabel.text integerValue] + 1] forState:UIControlStateNormal];
    }
    else
        [MBProgressHUD showError:@"评论不可为空" ToView:self.view];
}
//  - - - - -- - - -- - - - -- - - - - - - - - - - - textview代理 - - - - - - - -- - - - -- - - -- - - - - -- - - -
//内容将要发生改变编辑,编辑完使用return退出
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
//内容发生改变编辑
- (void)textViewDidChange:(UITextView *)textView
{
    [self setSendButtonAndTextView];
}
//根据输入设置文本框和发送按钮
- (void) setSendButtonAndTextView
{
    CGSize sizeP = CGSizeMake(CYScreanW * 0.8, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:sizeP text:[CYSmallTools textEditing:self.inputMessageTextView.text.length > 0 ? self.inputMessageTextView.text : @""]];
    if (layout.textBoundingSize.height > (CYScreanH - 64) * 0.06 && layout.textBoundingSize.height < (CYScreanH - 64) * 0.3)
    {
        self.backView.frame = CGRectMake( 0, (CYScreanH - 64) * 0.96 + 64 - self.keyBoardHeight - layout.textBoundingSize.height, CYScreanW, (CYScreanH - 64) * 0.04 + layout.textBoundingSize.height);
        self.inputMessageTextView.frame = CGRectMake( CYScreanW * 0.05, (CYScreanH - 64) * 0.02, CYScreanW * 0.8, layout.textBoundingSize.height);
        self.sendButtonInfor.frame = CGRectMake( CYScreanW * 0.85, (layout.textBoundingSize.height - (CYScreanH - 64) * 0.02) / 2, CYScreanW * 0.15, (CYScreanH - 64) * 0.06);
    }
    else
    {
        self.backView.frame = CGRectMake( 0, (CYScreanH - 64) * 0.9 + 64 - self.keyBoardHeight, CYScreanW, (CYScreanH - 64) * 0.1);
        self.inputMessageTextView.frame = CGRectMake( CYScreanW * 0.05, (CYScreanH - 64) * 0.02, CYScreanW * 0.8, (CYScreanH - 64) * 0.06);
        self.sendButtonInfor.frame = CGRectMake( CYScreanW * 0.85, (CYScreanH - 64) * 0.02, CYScreanW * 0.15, (CYScreanH - 64) * 0.06);
    }
}
//增加监听，当键盘出现或改变时收出消息
- (void) setNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

//自定义键盘高度
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    self.keyBoardHeight = keyboardRect.size.height;
//    int width = keyboardRect.size.width;
    if (self.PostDetailsModelarray.count >= 2)
    {
        self.view.frame = CGRectMake(0.0f, -self.keyBoardHeight + 64, self.view.frame.size.width, self.view.frame.size.height);
    }
    self.backView.frame = CGRectMake( 0, (CYScreanH - 64) * 0.9 + 64 - self.keyBoardHeight, CYScreanW, (CYScreanH - 64) * 0.1);
}
//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    if (self.PostDetailsModelarray.count >= 2)
    {
        self.view.frame = CGRectMake( 0, 64, self.view.frame.size.width, self.view.frame.size.height);
    }
    self.backView.frame = CGRectMake( 0, (CYScreanH - 64) * 0.9 + 64, CYScreanW, (CYScreanH - 64) * 0.1);
}
//点赞
- (void) thumbUpClick:(UIButton *)sender
{
    [self BBSThumbRequest];

}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            return (CYScreanH - 64) * 0.11;
        }
        else if (indexPath.row == 1)
        {
            return self.postHeight;
        }
        else
        {
            return (CYScreanH - 64) * 0.16;
        }
    }
    else
    {
        return ((CYScreanH - 64) * 0.15 + [self.PostDetailsHeight[indexPath.row] floatValue]);
    }
    
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 3;
    }
    else
        return self.PostDetailsModelarray.count;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        UIFont *font = [UIFont fontWithName:@"Arial" size:17];
        static NSString *ID = @"cellPPCId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0)
        {
            [self.RowOneView removeFromSuperview];
            self.RowOneView = nil;
            if (self.RowOneView == nil)
            {
                self.RowOneView = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, (CYScreanH - 64) * 0.11)];
                self.RowOneView.backgroundColor = [UIColor whiteColor];
                [cell.contentView addSubview:self.RowOneView];
                NSString *accountDoString = [NSString stringWithFormat:@"%@",[self.BBSDetailsDict objectForKey:@"accountDO"]];
                NSString *head = DefaultHeadImage;
                NSString *name = @"未获取";
                if (accountDoString.length > 6)
                {
                    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:[self.BBSDetailsDict objectForKey:@"accountDO"]];
                    head = [CYSmallTools isValidUrl:[dict objectForKey:@"imgAddress"]] ? [dict objectForKey:@"imgAddress"] : DefaultHeadImage;
                    name = [NSString stringWithFormat:@"%@",[ActivityDetailsTools UTFTurnToStr:[dict objectForKey:@"nickName"]]];
                }
                
                //头像
                UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(CYScreanW * 0.03, (CYScreanH - 64) * 0.02, CYScreanW * 0.12, (CYScreanH - 64) * 0.08)];
                [headImage sd_setImageWithURL:[NSURL URLWithString:head] placeholderImage:nil];
                [self.RowOneView addSubview:headImage];
                //圆角
                headImage.layer.cornerRadius = headImage.frame.size.width / 2;
                headImage.clipsToBounds = YES;
                //用户名
                UILabel *nameLabel = [[UILabel alloc] init];
                nameLabel.text = name;
                nameLabel.textColor = ShallowGrayColor;
                nameLabel.font = font;
                [self.RowOneView addSubview:nameLabel];
                [nameLabel mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.left.equalTo(headImage.mas_right).offset(CYScreanW * 0.02);
                     make.top.equalTo(self.RowOneView.mas_top).offset((CYScreanH - 64) * 0.02);
                     make.height.mas_equalTo((CYScreanH - 64) * 0.04);
                     make.width.mas_equalTo(CYScreanW * 0.5);
                 }];
                //时间
                UILabel *timeLabel = [[UILabel alloc] init];
                timeLabel.text = [NSString stringWithFormat:@"%@",[CYSmallTools timeWithTimeIntervalString:[self.BBSDetailsDict objectForKey:@"gmtCreate"]]];
                timeLabel.textColor = ShallowGrayColor;
                timeLabel.font = [UIFont fontWithName:@"Arial" size:11];
                [self.RowOneView addSubview:timeLabel];
                [timeLabel mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.left.equalTo(headImage.mas_right).offset(CYScreanW * 0.02);
                     make.top.equalTo(nameLabel.mas_bottom).offset(0);
                     make.height.mas_equalTo((CYScreanH - 64) * 0.04);
                     make.width.mas_equalTo(CYScreanW * 0.5);
                 }];
                //来自
                UILabel *postLabel = [[UILabel alloc] init];
                postLabel.text = [NSString stringWithFormat:@"来自%@",[self.BBSDetailsDict objectForKey:@"communityName"]];
                postLabel.textAlignment = NSTextAlignmentRight;
                postLabel.textColor = ShallowBrownColoe;
                postLabel.font = font;
                [self.RowOneView addSubview:postLabel];
                [postLabel mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.right.equalTo(self.RowOneView.mas_right).offset(-CYScreanW * 0.02);
                     make.top.equalTo(nameLabel.mas_bottom).offset(0);
                     make.height.mas_equalTo((CYScreanH - 64) * 0.04);
                     make.width.mas_equalTo(CYScreanW * 0.5);
                 }];
                NSMutableAttributedString *sendMessageString = [[NSMutableAttributedString alloc] initWithString:postLabel.text];
                [sendMessageString addAttribute:NSForegroundColorAttributeName value:ShallowGrayColor range:NSMakeRange(0,2)];
                postLabel.attributedText = sendMessageString;
            }
        }
        else if (indexPath.row == 1)
        {
            
            if ([[self.BBSDetailsDict objectForKey:@"flag"] isEqual:@"2"] && self.postHeight > 0)//官方帖子
            {
                self.PostShowWebViewHtml = [[UIWebView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, 0)];
                self.PostShowWebViewHtml.scalesPageToFit = NO;//自动对页面进行缩放以适应屏幕
                self.PostShowWebViewHtml.delegate = self;
                //self.ShowWebViewHtml.detectsPhoneNumbers = YES;//自动检测网页上的电话号码，单击可以拨打
                self.PostShowWebViewHtml.scrollView.bounces = NO;//防止滑动页面使UIWebView也滑动
                NSString *content = [NSString stringWithFormat:@"%@",[self.BBSDetailsDict objectForKey:@"content"]];
                if (content.length > 6){
                    [self.PostShowWebViewHtml loadHTMLString:[self.BBSDetailsDict objectForKey:@"content"]  baseURL:nil];
                }
                else
                    [self.PostShowWebViewHtml loadHTMLString:@"<p>帖子编辑图片仅在列表页显示，不会出现在帖子详情页</p>"  baseURL:nil];
                [cell.contentView addSubview:self.PostShowWebViewHtml];
            }
            else if (self.RowTwoView == nil && self.postHeight > 0)
            {
//                if (self.RowTwoView == nil){}
                self.RowTwoView = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, self.postHeight)];
                self.RowTwoView.backgroundColor = [UIColor whiteColor];
                [cell.contentView addSubview:self.RowTwoView];
                //帖子内容
                UILabel *postLabel = [[UILabel alloc] init];
                postLabel.textColor = [UIColor colorWithRed:0.282 green:0.282 blue:0.282 alpha:1.00];
                NSString *content = [NSString stringWithFormat:@"%@",[ActivityDetailsTools UTFTurnToStr:[self.BBSDetailsDict objectForKey:@"content"]]];
                if (![content isEqualToString:@"<null>"])
                {
                    postLabel.text = [NSString stringWithFormat:@"%@",content];
                }
                postLabel.font = font;
                postLabel.numberOfLines = 0;
                [postLabel sizeToFit];
                [self.RowTwoView addSubview:postLabel];
                [postLabel mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.left.equalTo(self.RowTwoView.mas_left).offset(CYScreanW * 0.03);
                     make.top.equalTo(self.RowTwoView.mas_top).offset((CYScreanH - 64) * 0.01);
                     make.right.equalTo(self.RowTwoView.mas_right).offset(-CYScreanW * 0.03);
                 }];
                //                异步加载
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    CGSize size =  [ActivityDetailsTools getSizeWithText:content font:[UIFont systemFontOfSize:17.0f]];
                    //处理数据
                    NSMutableArray *SeeImageObjArray = [[NSMutableArray alloc] init];
                    for (NSInteger i = 0; i < self.postPictureArray.count; i ++)
                    {
                        SeeImageObj *z = [[SeeImageObj alloc]init];
                        z.name = [NSString stringWithFormat:@"%@",self.postPictureArray[i]];
                        UIImage *image = [[UIImage alloc] init];
                        NSData *_decodedImageData   = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:z.name]];
                        image = [UIImage imageWithData:_decodedImageData];
                        //如果图片过大需要缩放:非必须
                        NSLog(@"前image.size.width = %f,image.size.height = %f",image.size.width,image.size.height);
                        CGSize size;
                        if (image.size.width > CYScreanW)
                        {
                            size = [self imageCompressWithSimple:image scale:(CYScreanW / image.size.width)];
                        }
                        else
                            size = image.size;
                        NSLog(@"后image.size.width = %f,image.size.height = %f",image.size.width,image.size.height);
                        z.whidth = [NSString stringWithFormat:@"%f",size.width];
                        z.height = [NSString stringWithFormat:@"%f",size.height];
                        z.imgTitle = @"";
                        z.imgContent = @"";
                        [SeeImageObjArray addObject:z];
                    }
                    //主线程
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //显示图片
                        for (NSInteger i = 0; i < SeeImageObjArray.count; i ++)
                        {
                            SeeImageObj *z = SeeImageObjArray[i];
                            SeeImagesView *_Img = [[SeeImagesView alloc]initWithFrame:CGRectMake(CYScreanW * 0.03 + (i % 3) * CYScreanW * 0.94 / 3,(size.height + (CYScreanH - 64) * 0.02) + (i > 2 ? (CYScreanH - 64) * 0.23 : (CYScreanH - 64) * 0.01), CYScreanW * 0.3, (CYScreanH - 64) * 0.2)];
                            _Img.layer.cornerRadius = 5;
                            _Img.userInteractionEnabled = YES;
                            _Img.clipsToBounds = YES;
                            [_Img setObj:z ImageArray:SeeImageObjArray];
                            _Img.isOpen = YES;
                            [self.RowTwoView addSubview:_Img];
                        }
                    });
                });
            }
        }
        else if (indexPath.row == 2)
        {
            [self.RowThreeView removeFromSuperview];
            self.RowThreeView = nil;
            if (self.RowThreeView == nil)
            {
                self.RowThreeView = [[UIView alloc] init];
                self.RowThreeView.backgroundColor = [UIColor whiteColor];
                [cell.contentView addSubview:self.RowThreeView];
                [self.RowThreeView mas_makeConstraints:^(MASConstraintMaker *make)
                {
                    make.left.equalTo(cell.mas_left).offset(0);
                    make.right.equalTo(cell.mas_right).offset(0);
                    make.top.equalTo(cell.mas_top).offset(0);
                    make.height.mas_equalTo((CYScreanH - 64) * 0.16);
                }];
                //分割线
                UIImageView *segmentationImmage = [[UIImageView alloc] init];
                segmentationImmage.backgroundColor = [UIColor colorWithRed:0.576 green:0.576 blue:0.576 alpha:1.00];
                [self.RowThreeView addSubview:segmentationImmage];
                [segmentationImmage mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.left.equalTo(self.RowThreeView.mas_left).offset(0);
                     make.right.equalTo(self.RowThreeView.mas_right).offset(0);
                     make.top.equalTo(self.RowThreeView.mas_top).offset((CYScreanH - 64) * 0.08);
                     make.height.mas_equalTo(1);
                 }];
                //点赞
                self.thumbUpButton = [[CYEmitterButton alloc] init];
                self.thumbUpButton.titleLabel.font = font;
                [self.thumbUpButton setTitle:[NSString stringWithFormat:@"%@",[self.BBSDetailsDict objectForKey:@"praiseCount"]] forState:UIControlStateNormal];
                [self.thumbUpButton setTitleColor:ShallowGrayColor forState:UIControlStateNormal];
                [self.thumbUpButton setImage:[UIImage imageNamed:@"icon_zan"] forState:UIControlStateNormal];
                [self.thumbUpButton setImage:[UIImage imageNamed:@"icon_zan_done"] forState:UIControlStateSelected];
                self.thumbUpButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 3);
                self.thumbUpButton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
                [self.thumbUpButton addTarget:self action:@selector(thumbUpClick:) forControlEvents:UIControlEventTouchUpInside];
                [self.RowThreeView addSubview:self.thumbUpButton];
                [self.thumbUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(segmentationImmage.mas_bottom).offset(-(CYScreanH - 64) * 0.02);
                    make.right.equalTo(self.RowThreeView.mas_right).offset(-CYScreanW * 0.03);
                    make.width.mas_equalTo(CYScreanW * 0.2);
                    make.height.mas_equalTo((CYScreanH - 64) * 0.04);
                }];
                self.thumbUpButton.selected = NO;
                //查看次数
                UIButton *toViewButton = [[UIButton alloc] init];
                toViewButton.titleLabel.font = font;
                [toViewButton setTitle:[NSString stringWithFormat:@"%@",[self.BBSDetailsDict objectForKey:@"viewCount"]] forState:UIControlStateNormal];
                [toViewButton setTitleColor:ShallowGrayColor forState:UIControlStateNormal];
                [toViewButton setImage:[UIImage imageNamed:@"icon_view"] forState:UIControlStateNormal];
                toViewButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 3);
                toViewButton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
                [self.RowThreeView addSubview:toViewButton];
                [toViewButton mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.bottom.equalTo(segmentationImmage.mas_bottom).offset(-(CYScreanH - 64) * 0.02);
                     make.right.equalTo(self.thumbUpButton.mas_left).offset(-CYScreanW * 0.06);
                     make.width.mas_equalTo(CYScreanW * 0.2);
                     make.height.mas_equalTo((CYScreanH - 64) * 0.04);
                 }];
                self.toViewButton = toViewButton;
                //评论
                UIButton *btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(CYScreanW * 0.04, (CYScreanH - 64) * 0.266 + 1, CYScreanW * 0.4, (CYScreanH - 64) * 0.08)];
                btnLeft.backgroundColor = [UIColor clearColor];
                [btnLeft setTitle:[NSString stringWithFormat:@"全部评论(%@)",[self.BBSDetailsDict objectForKey:@"replyCount"]] forState:UIControlStateNormal];
                [btnLeft setTitleColor:ShallowGrayColor forState:UIControlStateNormal];
                [btnLeft setImage:[UIImage imageNamed:@"2icon_comments"] forState:UIControlStateNormal];
                btnLeft.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
                btnLeft.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
                btnLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [self.RowThreeView addSubview:btnLeft];
                [btnLeft mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(segmentationImmage.mas_bottom).offset((CYScreanH - 64) * 0.02);
                    make.left.equalTo(self.RowThreeView.mas_left).offset(CYScreanW * 0.03);
                    make.width.mas_equalTo(CYScreanW * 0.7);
                    make.height.mas_equalTo((CYScreanH - 64) * 0.04);
                }];
                self.CommentButton = btnLeft;
                
                [self.toViewButton setTitle:[NSString stringWithFormat:@"%@",[self.BBSDetailsDict objectForKey:@"viewCount"]] forState:UIControlStateNormal];
                [self.thumbUpButton setTitle:[NSString stringWithFormat:@"%@",[self.BBSDetailsDict objectForKey:@"praiseCount"]] forState:UIControlStateNormal];
                [self.CommentButton setTitle:[NSString stringWithFormat:@"%@",[self.BBSDetailsDict objectForKey:@"replyCount"]] forState:UIControlStateNormal];
            }
        }
        return cell;
    }
    else
    {
        static NSString *ID = @"bbsCellId";
        self.postCell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (self.postCell == nil)
        {
            self.postCell = [[PostDetailsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        NSLog(@"self.dataModelBBSArray[indexPath.row] = %@",self.PostDetailsModelarray[indexPath.row]);
        self.postCell.model = self.PostDetailsModelarray[indexPath.row];
        self.postCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return self.postCell;
    }
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //放弃第一响应身份
    [self.inputMessageTextView resignFirstResponder];
}
//图片缩放
- (CGSize)imageCompressWithSimple:(UIImage*)image scale:(float)scale
{
    CGSize size = image.size;
    CGFloat width = size.width;
    CGFloat height = size.height;
    size.width = width * scale;
    size.height = height * scale;
    return size;
}
// ---- -- - - -- - - --- - - -- - - -- - -- - - -- - - -- - - - -- -webview使用- - -- - - - - - - - - - - -- - - --- - - - - - --  -- -
//自定义通知，点击webview之后对使用页面发送通知
#pragma mark - UIWebViewDelegate实现
#pragma mark 开始加载网页
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}
#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"加载结束");
    CGRect frame = webView.frame;
    frame.size.height = 1;
    frame.size.width = CYScreanW;
    webView.frame = frame;
    frame = webView.frame;
    frame.size = [webView sizeThatFits:CGSizeZero];
    webView.frame = frame;
    if (frame.size.height > self.postHeight)
    {
        self.postHeight = frame.size.height;
        self.PostShowWebViewHtml.frame = CGRectMake( 0, 0, CYScreanW, self.postHeight);
        //刷新某一组
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:0];  //你需要更新的组数中的cell
        [self.PostDetailsTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
    //配置图片点击
    [self.PostShowWebViewHtml stringByEvaluatingJavaScriptFromString:@"function assignImageClickAction(){var imgs=document.getElementsByTagName('img');var length=imgs.length;for(var i=0;i<length;i++){img=imgs[i];img.onclick=function(){window.location.href='image-preview:'+this.src}}}"];
    [self.PostShowWebViewHtml stringByEvaluatingJavaScriptFromString:@"assignImageClickAction();"];
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    NSLog(@"request.URL.scheme = %@",request.URL.scheme);
//    //预览图片
//    if ([request.URL.scheme isEqualToString:@"image-preview"]) {
//        NSString* path = [request.URL.absoluteString substringFromIndex:[@"image-preview:" length]];
//        self.saveImageString = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        
//        
//        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.saveImageString]]];
//        //显示图片
//        self.WebShowImageView.image = image;
//        [self showClickPicture:self.WebShowImageView withImage:image.size];
//        //        [UIView animateWithDuration:0.3f animations:^{
//        //            self.WebShowImageView.frame = CGRectMake( 0, 0, CYScreanW, CYScreanH);
//        //            self.WebShowImageView.alpha = 1.0f;
//        //        }];
//        
//        return NO;
//    }
    return YES;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"加载出错***********error:%@,errorcode=%ld,errormessage:%@",error.domain,(long)error.code,error.description);
    if (!([error.domain isEqualToString:@"WebKitErrorDomain"] && error.code ==102)) {
    }
}

// ---- -- - - -- - - --- - - -- - - -- - -- - - -- - - -- - - - -- - 数据请求 - - -- - - - - - - - - - - -- - - --- - - - - - --  -- -
//获取帖子评论列表
- (void) getPostDetailsRequest:(NSString *)postId
{
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"noteId"]  =  [NSString stringWithFormat:@"%@",postId];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/note/followNoteList",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"评论请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
         NSArray *array = [JSON objectForKey:@"returnValue"];
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             [self initPostModel:array];
         }
         else
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         NSLog(@"请求失败:%@", error.description);
     }];
}
//发表评论
- (void) followPostRequest
{
    //发送内容不为空
    if (_inputMessageTextView.text.length > 0)
    {
        [MBProgressHUD showLoadToView:self.view];
        self.sendButtonInfor.userInteractionEnabled = NO;
        //数据请求   设置请求管理者
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // 拼接请求参数
        NSMutableDictionary *parames = [NSMutableDictionary dictionary];
        parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
        parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
        parames[@"noteId"]  =  [NSString stringWithFormat:@"%@",[self.BBSDetailsDict objectForKey:@"id"]];
        parames[@"content"]  =  [NSString stringWithFormat:@"%@",[ActivityDetailsTools StrTurnToUTF:self.inputMessageTextView.text]];
        NSLog(@"parames = %@",parames);
        //url
        NSString *requestUrl = [NSString stringWithFormat:@"%@/api/note/followNote",POSTREQUESTURL];
        NSLog(@"requestUrl = %@",requestUrl);
        [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             [MBProgressHUD hideHUDForView:self.view];
             self.sendButtonInfor.userInteractionEnabled = YES;
             NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
             if ([[JSON objectForKey:@"success"] integerValue] == 1)
             {
                 [self sendButtonPost];
             }
             else
                 [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             self.sendButtonInfor.userInteractionEnabled = YES;
             [MBProgressHUD hideHUDForView:self.view];
             [MBProgressHUD showError:@"加载出错" ToView:self.view];
             NSLog(@"请求失败:%@", error.description);
         }];
        
    }
    else
        [MBProgressHUD showError:@"评论不可为空" ToView:self.view];
}
//获取帖子详情数据
- (void) GetPostDetails:(NSString *) PostId
{
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
    parames[@"noteId"]    =  PostId;
    parames[@"maxWidth"] =  [NSString stringWithFormat:@"%.0f",CYScreanW - 15];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/note/viewNote",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [CYRequestData postWithURLString:requestUrl parameters:parames success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"JSON = %@,error = %@",JSON,[JSON objectForKey:@"error"]);
        if ([[JSON objectForKey:@"success"] integerValue] == 1  && ([JSON objectForKey:@"returnValue"] != [NSNull null]))
        {
            //请求到的新数据
            self.BBSDetailsDict = [JSON objectForKey:@"returnValue"];
        }
        else
            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
        //处理数据
        [self initBBSDData];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"加载出错" ToView:self.view];
        NSLog(@"请求失败:%@", error.description);
    }];
}

//获取评论详情及点赞
- (void) BBSThumbRequest
{
    [MBProgressHUD showLoadToView:self.view];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
    parames[@"noteId"]  =  [NSString stringWithFormat:@"%@",[self.BBSDetailsDict objectForKey:@"id"]];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/note/praiseNote",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             NSLog(@"点赞请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
             [self.thumbUpButton setTitle:[NSString stringWithFormat:@"%ld",[self.thumbUpButton.titleLabel.text integerValue] + 1]  forState:UIControlStateNormal];
             self.thumbUpButton.selected = YES;
             self.thumbUpButton.userInteractionEnabled = NO;
         }
         else
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         NSLog(@"点赞请求失败:%@", error.description);
     }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end

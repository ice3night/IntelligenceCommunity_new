//
//  SeeImagesView.m
//  testFramworkDemo
//
//  Created by GT_MAC_2 on 15/7/16.
//  Copyright (c) 2015年 hyc. All rights reserved.
//
#define BWidth [[UIScreen mainScreen]bounds].size.width
#define BHeight [[UIScreen mainScreen]bounds].size.height


#import "SeeImagesView.h"

@interface SeeImagesView()<UIScrollViewDelegate,UIScrollViewAccessibilityDelegate>

//这个图片类的图片
@property (nonatomic,strong) UIImageView *MyImageView;

//图片显示需要的 图片对象数组
@property (nonatomic,strong) NSMutableArray *arr_Imgs;

//手势状态  999为特殊设置打开图片就显示上下遮盖（999只走一次）， 0有上下黑色半透明遮盖   1，没有遮盖
@property (nonatomic,assign) int ShouShitype;

//图片滚动scr
@property (nonatomic,strong) UIScrollView *img_Scroll;

//接收传过来的图片对象
@property (nonatomic,strong) SeeImageObj *imgOb;

//winsdow 添加的最外层view
@property (nonatomic,strong) UIView *windowView;

//topView  顶遮盖
@property (nonatomic,strong) UIView *topView;

//下方遮盖
@property (nonatomic ,strong) UIView *bottomView;

//scroller 显示的当前页数
@property (nonatomic,assign) int currentPage;

//当前页数lab
@property (nonatomic,strong) UILabel *currentLabel;

//scroller 显示当前页的图片文字
@property (nonatomic,strong) NSString *imgString;

//图片文字lab
@property (nonatomic,strong) UILabel *imgContentLabel;

//scroller 显示当前图的标题
@property (nonatomic,strong) NSString *imgNameSt;

//图片标题lab
@property (nonatomic,strong)  UILabel * imgNameLabel;

//获取的window 的最外层view
//@property (nonatomic,strong)  UIView *outView;

//scroll里面的图片view 数组
@property (nonatomic,strong) NSMutableArray *arr_viewImg;

//scroller里面的scroller   数组
@property (nonatomic,strong) NSMutableArray *arr_scro;

//未缩放的 view的Img 的frame 的数组
@property (nonatomic,strong) NSMutableArray *arr_imgF;
//返回按钮
@property (nonatomic,strong) UIButton *btn_back;

//第一次缩放 判断
//@property (nonatomic,assign) BOOL isOne;

@end

@implementation SeeImagesView


- (void) awakeFromNib
{
    [super awakeFromNib];

}


//- (BOOL) isOpen
//{
//    if (!_isOpen) {
//        _isOpen = NO;
//    }
//    return _isOpen;
//}

//- (void)setIsOpen:(BOOL)isOpen
//{
//    _isOpen = isOpen;
//    self.userInteractionEnabled = _isOpen;
//    self.MyImageView.userInteractionEnabled = _isOpen;
//}
- (UIImageView*) MyImageView
{
    if (!_MyImageView) {
        _MyImageView = [[UIImageView alloc]init];
    }
    return _MyImageView;
}


- (NSMutableArray *) arr_imgF
{
    if (!_arr_imgF) {
        _arr_imgF = [NSMutableArray array];
    }
    return _arr_imgF;
}

- (NSMutableArray *) arr_scro
{
    if (!_arr_scro) {
        _arr_scro = [NSMutableArray array];
    }
    return _arr_scro;
}

- (UIView*) windowView
{
    if (!_windowView) {
        _windowView = [[UIView alloc]init];
    }
    return _windowView;
}


- (NSMutableArray *)arr_viewImg
{
    if (!_arr_viewImg) {
        _arr_viewImg = [NSMutableArray array];
    }
    return _arr_viewImg;
}

- (NSString *)imgNameSt
{
    if (!_imgNameSt) {
        _imgNameSt = @"";
    }
    return _imgNameSt;
}

- (NSString *)imgString
{
    if (!_imgString) {
        _imgString = @"";
    }
    return _imgString;
}

- (int) currentPage
{
    if (!_currentPage) {
        _currentPage = 1;
    }
    return _currentPage;
}

- (NSMutableArray *) arr_Imgs
{
    if (!_arr_Imgs) {
        _arr_Imgs = [NSMutableArray array];
    }
    return _arr_Imgs;
}

- (int) ShouShitype
{
    if (!_ShouShitype) {
        _ShouShitype = 0;
    }
    return _ShouShitype;
}

- (UILabel *) currentLabel
{
    if (!_currentLabel) {
        _currentLabel = [[UILabel alloc]init];
        _currentLabel.textColor = [UIColor whiteColor];
        _currentLabel.textAlignment = NSTextAlignmentRight;
        _currentLabel.font = [UIFont systemFontOfSize:22];
        _currentLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _currentLabel.text = [NSString stringWithFormat:@"%i",self.currentPage];
    }
    return _currentLabel;
}

- (UILabel *) imgNameLabel
{
    if (!_imgNameLabel) {
        _imgNameLabel = [[UILabel alloc]init];
        _imgNameLabel.textColor = [UIColor whiteColor];
        _imgNameLabel.textAlignment = NSTextAlignmentLeft;
        _imgNameLabel.font = [UIFont boldSystemFontOfSize:20];
        _imgNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    
    return _imgNameLabel;
}

- (UILabel *) imgContentLabel
{
    if (!_imgContentLabel) {
        _imgContentLabel = [[UILabel alloc]init];
        _imgContentLabel.numberOfLines = 0;
        _imgContentLabel.textColor = [UIColor whiteColor];
        _imgContentLabel.textAlignment = NSTextAlignmentLeft;
        _imgContentLabel.font = [UIFont systemFontOfSize:16];
        _imgContentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _imgContentLabel;
}

//设置 图片对象
- (void) setObj:(id)aa ImageArray:(NSMutableArray *)array
{
    //当前图片
    self.imgOb = aa;
    NSLog(@"self.isOpen = %d",self.isOpen);
    self.userInteractionEnabled = YES;
    self.MyImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.MyImageView.userInteractionEnabled = YES;
    
    [self.MyImageView sd_setImageWithURL:[NSURL URLWithString:self.imgOb.name] placeholderImage:nil];//网络图片
//    self.MyImageView.image = [UIImage imageNamed:self.imgOb.name];//本地图片
    [self addSubview:self.MyImageView];
    //定义 单击手势
    UITapGestureRecognizer*singleTap;//单击手势
    singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];//初始化
    singleTap.numberOfTapsRequired = 1;//轻敲次数
    [self.MyImageView addGestureRecognizer:singleTap];//给视图添加手势
    
    //多图
    self.arr_Imgs = array;
    if(self.arr_Imgs.count == 0 || self.arr_Imgs == nil){
        [self.arr_Imgs addObject:self.imgOb];
    }
}
//使用
//首先布局scroll
//接着布局scroller里面每张图的组成结构
//组成结构分为
/*1,背景黑色
 *2,图片位置
 *3,上部分遮盖
 *4,下部分显示图片张数以及文字信息
 */
-(void)singleTap:(UITapGestureRecognizer*)recognizer
{   //参数轻敲类型的
    self.ShouShitype = 999;
    self.img_Scroll.backgroundColor = [UIColor blackColor];
    for (int i = 0; i< self.arr_Imgs.count; i++) {
        SeeImageObj *jj = (SeeImageObj *)[self.arr_Imgs objectAtIndex:i];
        double w = [jj.whidth doubleValue];
        double h = [jj.height doubleValue];
        UIScrollView * scro = [[UIScrollView alloc]initWithFrame:CGRectMake(i*BWidth, 0, BWidth, BHeight)];
        [scro setExclusiveTouch:YES];
        scro.showsHorizontalScrollIndicator = NO;
        scro.showsVerticalScrollIndicator = NO;
        scro.backgroundColor = [UIColor blackColor];
        scro.delegate = self;
        scro.minimumZoomScale = 0.9f;
        scro.maximumZoomScale = 3.0f;
        //scro.zoomScale = 0;
        scro.tag = i+1;
        scro.contentSize =  CGSizeMake(BWidth, BHeight);
        
        UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (CGFloat)w, (CGFloat)h)];
        imgv.tag = 1000 + i ;
        imgv.center = CGPointMake(BWidth/2, BHeight/2);
//        imgv.image = [UIImage imageNamed:jj.name];//本地图片
        NSData *imageData = [CYSmallTools GetCashUrl:jj.name];
        if (imageData)
        {
            imgv.image = [UIImage imageWithData:imageData];
        }
        else
            [imgv sd_setImageWithURL:[NSURL URLWithString:jj.name] placeholderImage:nil];//网络图片
        [scro addSubview:imgv];
        [self.img_Scroll addSubview:scro];
        [self.arr_viewImg addObject:imgv];
        [self.arr_scro addObject:scro];
        //UIView *view = [[UIView alloc]initWithFrame:seeimg.frame];
        UIImageView *viewimg = [[UIImageView alloc]initWithFrame:imgv.frame];
        //[self.arr_viewF addObject:view];
        [self.arr_imgF addObject:viewimg];
    }
    self.windowView = [[UIView alloc]initWithFrame:self.img_Scroll.frame];
    
    [self.windowView addSubview:self.img_Scroll];
    
    [self.window addSubview:self.windowView];
    
    //判断 当前显示那一页数据
    int page = [self PanDuanPage];
    self.img_Scroll.contentOffset = CGPointMake(page * BWidth, 0);
    
//    self.outView = [self GetWindowView];
//    [self.windowView addSubview:self.outView];
    //默认添加遮盖层
    if (self.ShouShitype == 999) {
        
    }
//    NSLog(@"self.outView = %@,[self GetWindowView]; = %@",self.outView,[self GetWindowView]);
    [self addTopAndBottomView];
    //添加返回按钮
    self.btn_back = [self BackButton];
    [self.windowView addSubview:self.btn_back];
    //状态栏颜色白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];

}
//添加返回视图
- (void) addTopAndBottomView
{
    //先移除
    [self.topView removeFromSuperview];
    [self.bottomView removeFromSuperview];
    //
    self.topView = nil;
    self.bottomView = nil;
    self.topView = [self setTopView];
    self.bottomView = [self setBottomView];
    //添加
    [self.windowView addSubview:self.topView];
    [self.windowView addSubview:self.bottomView];
    self.ShouShitype = 1;
}
//返回按钮
- (UIButton *) BackButton
{
    //返回按钮
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake( 0, 24, 30, 30)];
    [button setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];//未标题-1_06.png
    [button addTarget:self action:@selector(click_back) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

//scro初始
- (UIScrollView*) img_Scroll
{
    if(!_img_Scroll){
        _img_Scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, BWidth, BHeight)];
        _img_Scroll.pagingEnabled = YES;
        [_img_Scroll setExclusiveTouch:YES];
        NSInteger num = self.arr_Imgs.count;
        _img_Scroll.contentSize =  CGSizeMake(num*BWidth, BHeight);
        _img_Scroll.delegate = self;
        
        //self.ScContentSize = CGSizeMake(num*BWidth, BHeight);
        
        //定义 单击手势
        UITapGestureRecognizer*SCsingleTap;//单击手势
        SCsingleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SCsingleTap:)];//初始化
        SCsingleTap.numberOfTapsRequired = 1;//轻敲次数
        [_img_Scroll addGestureRecognizer:SCsingleTap];//给视图添加手势
        
    }
    return _img_Scroll;
}
//scroller  的单击手势
-(void)SCsingleTap:(UITapGestureRecognizer*)recognizer{//参数轻敲类型的
    //为0,加上上下遮盖
//    self.outView = [self GetWindowView];
    if (self.ShouShitype == 0) {
        NSLog(@"self.topView = %@",self.topView);
        [self.bottomView setHidden:NO];
        [self.topView setHidden:NO];
        [self.btn_back setHidden:NO];
        self.ShouShitype = 1;
    }
    else
    {
        //取消上下遮盖层
        if (self.ShouShitype == 1) {
            [self.bottomView setHidden:YES];
            [self.topView setHidden:YES];
            [self.btn_back setHidden:YES];
            self.ShouShitype = 0;
        }
    }
}
//获取 window的 最外层的视图
- (UIView *) GetWindowView
{
    UIView *_parentView = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CYScreanH)];
    _parentView.userInteractionEnabled = NO;
//    NSArray* windows = [UIApplication sharedApplication].windows;
//    UIWindow * _window = [windows lastObject];
//    //keep the first subview
//    if(_window.subviews.count > 0){
//        _parentView = [_window.subviews lastObject];
//        //[_parentView removeFromSuperview];
//    }
    return _parentView;
}
- (void) click_back
{
//    [self.outView removeFromSuperview];
    
    [self.windowView removeFromSuperview];
    [self.arr_viewImg removeAllObjects];
    [self.arr_scro removeAllObjects];
    [self.arr_imgF removeAllObjects];
    [self.topView removeFromSuperview];
    [self.bottomView removeFromSuperview];
    [self.img_Scroll removeFromSuperview];
    [self.btn_back removeFromSuperview];
    
//    self.outView = nil;
    self.windowView = nil;
    self.arr_viewImg = nil;
    self.arr_scro = nil;
    self.arr_imgF = nil;
    self.topView =nil;
    self.bottomView =nil;
    self.img_Scroll = nil;
    self.btn_back = nil;

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    self.ShouShitype = 999;
    //self.isOne = NO;
   // self.ScContentSize = CGSizeMake(num*BWidth, BHeight);
}


#pragma seeimg Scroller is  delegete
- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
    NSLog(@"缩放的tag=======%li",(long)scrollView.tag);
    UIImageView *imgView  = [self.arr_viewImg objectAtIndex:self.currentPage-1];
   
    
    if (imgView.frame.size.width>BWidth  && imgView.frame.size.height>BHeight) {
        scrollView.contentSize = CGSizeMake(imgView.frame.size.width, imgView.frame.size.height);
    }
    else if (imgView.frame.size.width>BWidth && imgView.frame.size.height<=BHeight){
        scrollView.contentSize = CGSizeMake(imgView.frame.size.width, BHeight);
    }
    else if (imgView.frame.size.width<=BWidth && imgView.frame.size.height>BHeight){
        scrollView.contentSize = CGSizeMake(BWidth, imgView.frame.size.height);
    }
    else if (imgView.frame.size.width<=BWidth && imgView.frame.size.height<=BHeight){
        scrollView.contentSize = CGSizeMake(BWidth, BHeight);
    }
    else{
        NSArray *arr1 = [scrollView subviews];
        UIScrollView *scro = [arr1 objectAtIndex:self.currentPage-1];
        scro.contentSize = CGSizeMake(BWidth, BHeight);
        //NSArray *arr = [scro subviews];
        //UIImageView *imgView = [arr firstObject];
        //imgView.frame = noscaView.frame;
        
    }
    
    
    imgView.center = CGPointMake(scrollView.contentSize.width/2, scrollView.contentSize.height/2);
    //scrollView.contentOffset = CGPointMake(scrollView.contentSize.width/2-BWidth/2, scrollView.contentSize.height/2-BHeight/2);
    NSLog(@"图的宽=======%f",imgView.frame.size.width);
    NSLog(@"图的高=======%f",imgView.frame.size.height);
    NSLog(@"sc的宽=======%f",scrollView.contentSize.width);
    NSLog(@"sc的搞=======%f",scrollView.contentSize.height);
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.tag >0 == NO) {
        
    NSInteger numOfPage = ABS(self.img_Scroll.contentOffset.x/scrollView.frame.size.width);
    
    if (numOfPage != self.currentPage-1) {

        UIScrollView *scro = [self.arr_scro objectAtIndex:self.currentPage-1];
        scro.contentSize = CGSizeMake(BWidth, BHeight);
        
        UIImageView *imgView = [self.arr_viewImg objectAtIndex:self.currentPage-1];

        //这里 把这个scroll的缩放比例设为1，其实就是给它里面图片大小还原，scroll初始的默认是1，给放大了滑动过来了，但这个scroller缩放的程度还是3，这里设为1，就是还原了scroller，它里面的图片自然也就还原了
        scro.zoomScale = 1;
        NSLog(@"图的宽=======%f",imgView.frame.size.width);
        NSLog(@"图的高=======%f",imgView.frame.size.height);
        NSLog(@"sc的宽=======%f",scro.contentSize.width);
        NSLog(@"sc的搞=======%f",scro.contentSize.height);
       // self.isOne = NO;
        
    }
    
    self.currentPage = (int)(numOfPage + 1);
    self.currentLabel.text = [NSString stringWithFormat:@"%i",self.currentPage];
    
    SeeImageObj *obj = (SeeImageObj*)[self.arr_Imgs objectAtIndex:numOfPage];
    self.imgNameLabel.text = obj.imgTitle;
    self.imgContentLabel.text = obj.imgContent;
    
    
    }
    
    
}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    UIImageView *imgView  = [self.arr_viewImg objectAtIndex:self.currentPage-1];
    UIImageView *noscaView = [self.arr_imgF objectAtIndex:self.currentPage-1];
    if (imgView.frame.size.width<=BWidth && imgView.frame.size.height<=BHeight){
        scrollView.contentSize = CGSizeMake(BWidth, BHeight);
        imgView.frame = noscaView.frame;
    }
    
    
    NSLog(@"缩放比例-----%f",scale);
    
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    if(scrollView.tag == self.currentPage){
        
        //取出 当前缩放图 的 未缩放的frame
        UIImageView *imgView  = [self.arr_viewImg objectAtIndex:self.currentPage-1];
      
        if (imgView.frame.size.width>330) {
            
        }

        return imgView;

    }
    return nil;
}
//滚动动画停止时执行,代码改变时出发,也就是setContentOffset改变时
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;
{
    NSLog(@"scrollViewDidEndScrollingAnimation");
}
//返回999说明我逻辑错误
- (int) PanDuanPage
{
    for (int i = 0 ;i<self.arr_Imgs.count;i++) {
        SeeImageObj *obj = [self.arr_Imgs objectAtIndex:i];
        if (self.imgOb == obj) {
            NSLog(@"%i个相同",i);
            self.currentPage = i+1;
            self.imgNameSt = obj.imgTitle;
            self.imgString = obj.imgContent;
            return i;
        }
    }
    return 999;
}

//顶部视图
- (UIView *) setTopView
{
//    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BWidth, 64)];
        _topView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        //保存按钮
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake( CYScreanW - 80, 30, 80, 20)];
        [btn setImage:[UIImage imageNamed:@"rounds"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(savePictureInLocal:) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:btn];
//    }
    return _topView;
}
//保存图片到本地
- (void) savePictureInLocal:(UIButton *)sender
{
    UIActionSheet*actionSheet = [[UIActionSheet alloc]initWithTitle:@"保存图片"delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:@"保存图片到手机",nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    [actionSheet showInView:self.bottomView];
}
//保存提示
- (void)actionSheet:(UIActionSheet*)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0 && (self.currentPage - 1) < self.arr_Imgs.count)
    {
        SeeImageObj *obj = self.arr_Imgs[self.currentPage - 1];
        [self SavePictureSuccess:obj.name];
    }
}
//判断是否存在
- (void) SavePictureSuccess:(NSString *)imageUrl
{
    NSURL *url = [NSURL URLWithString:imageUrl];
//    1.获得文件路径
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileName = [path stringByAppendingPathComponent:@"PictureSave.plist" ];
//    3.读取
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:fileName];
    NSLog(@"dict = %@",dict);
    NSString *value = [dict objectForKey:imageUrl];
    if (value)
    {
        //成功后取相册中的图片对象
        PHFetchResult *result = [PHAsset fetchAssetsWithLocalIdentifiers:@[value] options:nil];
        NSLog(@"result = %@",result);
        //
        if (result.count)
        {
            [self showMessage:@"已存在"];
        }
        else
            [self SavePicture:url withString:imageUrl];
    }
    else
    {
        [self SavePicture:url withString:imageUrl];
    }
}
//保存图片
- (void) SavePicture:(NSURL *)url withString:(NSString *)imageUrl
{
    NSMutableArray *imageIds = [NSMutableArray array];
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        //写入图片到相册
        PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:url]]];
        //记录本地标识，等待完成后取到相册中的图片对象
        [imageIds addObject:req.placeholderForCreatedAsset.localIdentifier];
        NSLog(@"req.placeholderForCreatedAsset.localIdentifier = %@",req.placeholderForCreatedAsset.localIdentifier);
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        NSLog(@"success = %d, error = %@", success, error);
        if (success)
        {
            NSLog(@"imageIds = %@",imageIds);
            //    1.获得文件路径
            NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
            NSString *fileName = [path stringByAppendingPathComponent:@"PictureSave.plist" ];
            //    2.存储
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:fileName];
            if (!dict) {
                dict = [NSMutableDictionary dictionary];
            }
            [dict setObject:imageIds.firstObject forKey:imageUrl];
            [dict writeToFile:fileName atomically:YES];//执行此行代码时默认新创建一个plist文件
            NSLog(@"dict = %@",dict);
            [self showMessage:@"保存成功"];
        }
        else
        {
            [self showMessage:[NSString stringWithFormat:@"%@",error]];
        }
    }];
}
//弹框
- (void) showMessage:(NSString *)prompt
{
    //主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        //初始化提示框；
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示"
                                                      message:prompt delegate:nil
                                            cancelButtonTitle:@"确定"
                                            otherButtonTitles:nil, nil];
        [alert show];
    });
}
//底部视图
- (UIView *) setBottomView
{
//    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, BHeight-150, BWidth, 150)];
        _bottomView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        
        //当前页/总页数lab
        UILabel *countPageLabel = [[UILabel alloc]init];
        countPageLabel.textColor = [UIColor whiteColor];
        countPageLabel.translatesAutoresizingMaskIntoConstraints = NO;
        countPageLabel.text = [NSString stringWithFormat:@"/%lu",(unsigned long)self.arr_Imgs.count];
        
        [_bottomView addSubview:countPageLabel];
        //约束
        //右
        [_bottomView addConstraint:[NSLayoutConstraint constraintWithItem:countPageLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_bottomView attribute:NSLayoutAttributeRight multiplier:1.0f constant:-10]];
        //上
        [_bottomView addConstraint:[NSLayoutConstraint constraintWithItem:countPageLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_bottomView attribute:NSLayoutAttributeTop multiplier:1.0f constant:14]];
        //宽
        [_bottomView addConstraint:[NSLayoutConstraint constraintWithItem:countPageLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:30]];
        //高
        [_bottomView addConstraint:[NSLayoutConstraint constraintWithItem:countPageLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:20]];
        
        //当前页
        [_bottomView addSubview:self.currentLabel];
        //约束
        //右
        [_bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.currentLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:countPageLabel attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0]];
        //下
        [_bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.currentLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:countPageLabel attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-1.5f]];
        //宽
        [_bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.currentLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:50]];
        
        //高
        [_bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.currentLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:20]];
        self.currentLabel.text = [NSString stringWithFormat:@"%i",self.currentPage];
        
        
        //图片标题
        
        [_bottomView addSubview:self.imgNameLabel];
        //约束
        //右
        [_bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.imgNameLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_bottomView attribute:NSLayoutAttributeRight multiplier:1.0f constant:-100]];
        //上
        [_bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.imgNameLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_bottomView attribute:NSLayoutAttributeTop multiplier:1.0f constant:11]];
        //左
        [_bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.imgNameLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_bottomView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:15]];
        //高
        [_bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.imgNameLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:20]];
        SeeImageObj *obj = (SeeImageObj *)[self.arr_Imgs objectAtIndex:self.currentPage-1 ];
        self.imgNameLabel.text = [NSString stringWithFormat:@"%@",obj.imgTitle];
        
        
        
        //图片文字内容
        
        [_bottomView addSubview:self.imgContentLabel];
        //约束
        //左
        [_bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.imgContentLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_bottomView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0]];
        //右
        [_bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.imgContentLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_bottomView attribute:NSLayoutAttributeRight multiplier:1.0f constant:0]];
        //上
        [_bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.imgContentLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.currentLabel attribute:NSLayoutAttributeBottom multiplier:1.0f constant:5]];
        NSString *labelText = [NSString stringWithFormat:@"%@",obj.imgContent];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        [paragraphStyle setLineSpacing:1.6f];//调整行间距
        
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
        self.imgContentLabel.attributedText = attributedString;
        
        
        
//    }
    return _bottomView;
}
@end









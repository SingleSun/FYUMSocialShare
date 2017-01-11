//
//  FYMainViewController.m
//  FYUMSocialShareDemo
//
//  Created by 樊杨 on 2017/1/11.
//  Copyright © 2017年 FY. All rights reserved.
//

#import "FYMainViewController.h"
#import <UShareUI/UShareUI.h>


#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface FYMainViewController ()

@end

@implementation FYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //分享
    UIButton * ushareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    ushareBtn.frame = CGRectMake(ScreenWidth/2.0-50, ScreenHeight/2.0-40, 100, 40);
    
    [ushareBtn setTitle:@"友盟分享" forState:UIControlStateNormal];
    [ushareBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [ushareBtn addTarget:self action:@selector(UShareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ushareBtn];
    
}

-(void)UShareButtonClick:(UIButton *)sender{
    //显示分享面板
    
    [self customShareUI];
    
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_Qzone),@(UMSocialPlatformType_DingDing),@(UMSocialPlatformType_AlipaySession),@(UMSocialPlatformType_Douban),@(UMSocialPlatformType_Renren),@(UMSocialPlatformType_TencentWb),@(UMSocialPlatformType_Facebook),@(UMSocialPlatformType_YixinSession),@(UMSocialPlatformType_Twitter),@(UMSocialPlatformType_Sms)]];
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        //创建分享消息对象
        UMSocialMessageObject * socialMessageObject = [UMSocialMessageObject messageObject];
        
        //设置文本
        socialMessageObject.text = @"我在测试";
        
        //创建图片内容对象
        UMShareImageObject * imageObject = [[UMShareImageObject alloc]init];
        
        //如果有缩略图，则设置缩略图
//        if (platformType == UMSocialPlatformType_QQ) {
//            imageObject.thumbImage = [UIImage imageNamed:@"icon"];
//            [imageObject setShareImage:[UIImage imageNamed:@"logo"]];
//        }
        socialMessageObject.shareObject = imageObject;
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:socialMessageObject currentViewController:self completion:^(id result, NSError *error) {
            
            if (error) {
                NSLog(@"error--%@",error.description);
            }else{
                if ([result isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = result;
                    //分享结果消息
                    NSLog(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    NSLog(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    NSLog(@"response data is %@",result);
                }

            }
            
            
        }];
        
    }];
}

#pragma mark 自定义分享界面
-(void)customShareUI{
    //标题
    [UMSocialShareUIConfig shareInstance].shareTitleViewConfig.isShow = YES;
    [UMSocialShareUIConfig shareInstance].shareTitleViewConfig.shareTitleViewTitleString = @"分享";
    [UMSocialShareUIConfig shareInstance].shareTitleViewConfig.shareTitleViewTitleColor = [UIColor blueColor];
    //分页控制
    //每个items的最大高度和宽度
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxItemHeight = 60.0f;
    
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxItemWidth = 60.0f;
    
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxRowCountForLandscapeAndMid = 2;//行
    
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxColumnCountForPortraitAndMid = 4;//列
    
    //指示器颜色
    [UMSocialShareUIConfig shareInstance].sharePageControlConfig.sharePageControlBackgroundColor = [UIColor orangeColor];
    
    [UMSocialShareUIConfig shareInstance].sharePageControlConfig.sharePageControlCurrentPageIndicatorTintColor = [UIColor redColor];//当前页颜色
    
    //item类型
    /*
     UMSocialPlatformItemViewBackgroudType_None,//有图片，没有圆背景，
     UMSocialPlatformItemViewBackgroudType_IconAndBGRadius,//有图片，圆背景，
     UMSocialPlatformItemViewBackgroudType_IconAndBGRoundAndSuperRadius,//有图片，圆角背景，
     */
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_None;
    //面板显示位置
    /*
     UMSocialSharePageGroupViewPositionType_Bottom,//显示在底部
     UMSocialSharePageGroupViewPositionType_Middle,//显示在中间
     */
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
    
    //是否显示取消按钮
    [UMSocialShareUIConfig shareInstance].shareCancelControlConfig.isShow = YES;
    //设置取消按钮
    [UMSocialShareUIConfig shareInstance].shareCancelControlConfig.shareCancelControlText = @"取消";
    
    [UMSocialShareUIConfig shareInstance].shareCancelControlConfig.shareCancelControlTextColor = [UIColor redColor];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  AppDelegate.m
//  越野e族
//
//  Created by soulnear on 13-12-16.
//  Copyright (c) 2013年 soulnear. All rights reserved.
//ifaiqingshenai

#import "AppDelegate.h"
#import "LogInViewController.h"
#import "bbsdetailViewController.h"
#import "FbFeed.h"
#import "UMSocialSnsService.h"
#import "WXApi.h"
#import "UMSocialData.h"
#import "UMSocialSnsService.h"
#import "MessageViewController.h"
#import "PersonalmoreViewController.h"
@implementation AppDelegate
@synthesize rootVC;
@synthesize bbsVC;
@synthesize mineVC;
@synthesize moreVC;
@synthesize weiboVC;
@synthesize mallVC;
@synthesize fansVC;
@synthesize _center;
@synthesize shadowView = _shadowView;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

#pragma mark-友盟分享

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self judgeversionandclean];
        
    //友盟分享平台
    
    if (launchOptions) {
        
 
        NSDictionary* pushNotificationKey = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (pushNotificationKey) {
            
           // [alert show];
            dic_push =[[NSDictionary alloc]initWithDictionary:pushNotificationKey];
        }
    }
    
    
    flagofpage=0;
    
    

    
    
    
//    UIDevice *device_=[[UIDevice alloc] init];
//    NSLog(@"设备所有者的名称－－%@",device_.name);
//    NSLog(@"设备的类别－－－－－%@",device_.model);
//    NSLog(@"设备的的本地化版本－%@",device_.localizedModel);
//    NSLog(@"设备运行的系统－－－%@",device_.systemName);
//    NSLog(@"当前系统的版本－－－%@",device_.systemVersion);
//    NSLog(@"设备识别码－－－－－%@",device_.identifierForVendor.UUIDString);
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
    
    [UMSocialData setAppKey:@"5153e5e456240b79e20006b9"];
    [WXApi registerApp:@"wx4fb411c415f89047"];
    
    [ WeiboSDK registerApp:@"2335514239"];
    [ WeiboSDK enableDebugMode:YES ];
    
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"newsid"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"version"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"content"];
    
    
    
    
    [MobClick startWithAppkey:@"5153e5e456240b79e20006b9" reportPolicy:BATCH channelId:nil];
    
    [MobClick setLogEnabled:YES];
    
    self.window = [[[UIWindow alloc] initWithFrame:CGRectMake(0,MY_MACRO_NAME?0:0,320,MY_MACRO_NAME? [[UIScreen mainScreen] bounds].size.height:iPhone5?568+20:480+20)] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    
    
//    if (IOS_VERSION<7.0)
//    {
//        self.window.frame = CGRectMake(0,-20,320,[[UIScreen mainScreen] bounds].size.height+20);
//    }
    
    
    if (!bigimageview) {
        bigimageview=[[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        
    }
    bigimageview.backgroundColor=[UIColor colorWithRed:245/255.f green:244/255.f blue:242/255.f alpha:1];
    [self.window addSubview:bigimageview];
    
    if (!iMagelogo) {
        iMagelogo=[[UIImageView alloc]init];
        
    }
    iMagelogo.frame=CGRectMake(0,iPhone5? 568-217/2:480-217/2, 320, 217/2);
    
    iMagelogo.image=[UIImage imageNamed:@"ios7_fengmianlogo2.png"];
    
    if (!guanggao_image) {
        guanggao_image=[[AsyncImageView alloc]init];
        
    }
    // guanggao_image.frame=CGRectMake(0, 0, 320,iPhone5? 936/2:936/2);
    
    guanggao_image.alpha=0;
    NSString *string_img=[[NSUserDefaults standardUserDefaults]objectForKey:@"img"];
    
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapFrom)];
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [guanggao_image addGestureRecognizer:singleRecognizer];
    guanggao_image.delegate = self;
    NSLog(@"defaimg======%@",string_img);
    NSLog(@"dangqian===%@",[Reachability checkNetWork]);

    
    if (string_img.length!=0) {
        NSLog(@"长度不等于0");

        
    }else{
        
    }
    [bigimageview addSubview:guanggao_image];
    [bigimageview addSubview:iMagelogo];
    
    
    
    
    UIView *redview=[[UIView alloc]initWithFrame:CGRectMake(0, iPhone5?568/2-40:480/2-40, 320, 12)];
    redview.backgroundColor=[UIColor clearColor];
    [bigimageview addSubview:redview];
    img_TEST=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ios7_loading61_12_4.png"]];
    img_TEST.center=CGPointMake(160, 6);
    [redview addSubview:img_TEST];
    NSTimer *theTimer;
    theTimer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(changepic) userInfo:nil repeats:YES];
    
    [self usenewguanggao];

    
    [self.window makeKeyAndVisible];
    
    
    
    // Required
    
    return YES;
}
//-(void)showguanggao{
//    
//    
//    downloadtool *tool_=[[downloadtool alloc]init];
//    tool_.tag=99;
//    [tool_ setUrl_string:@"http://cast.aim.yoyi.com.cn/afp/door/;ap=x17117be4be6c5150001;ct=js;pu=n1428243fc09e7230001;/?"];
//    tool_.delegate=self;
//    [tool_ start];
//    
//    
////    timer=[NSTimer scheduledTimerWithTimeInterval:15
////                                           target:self
////                                         selector:@selector(showzhuview)
////                                         userInfo:nil
////                                          repeats:NO];
//    
//}
-(void)changepic{
    
    
    
    
    flagofpage++;
    
    switch (flagofpage) {
        case 1:
        {
            img_TEST.image=[UIImage imageNamed:@"ios7_loading61_12_4.png"];
        }
            break;
        case 2:
        {
            img_TEST.image=[UIImage imageNamed:@"ios7_loading61_12_3.png"];
            
        }
            break;
        case 3:
        {
            img_TEST.image=[UIImage imageNamed:@"ios7_loading61_12_2.png"];
            
        }
            break;
        case 4:
        {
            img_TEST.image=[UIImage imageNamed:@"ios7_loading61_12_1.png"];
            
        }
            break;
            
        default:
            break;
    }
    
    if (flagofpage==4) {
        flagofpage=0;
    }
}


-(void)usenewguanggao{
    
    downloadtool *tool_=[[downloadtool alloc]init];
    tool_.tag=100;
    [tool_ setUrl_string:@"http://cmsweb.fblife.com/data/app.ad.txt"];
    tool_.delegate=self;
    [tool_ start];
    
    timer=[NSTimer scheduledTimerWithTimeInterval:15
                                           target:self
                                         selector:@selector(showzhuview)
                                         userInfo:nil
                                          repeats:NO];
    
    
    
}

-(void)handleImageLayout:(AsyncImageView *)tag
{
    

    NSLog(@"asyim====%@",tag);
    
    if (tag==nil) {

        
      //  [self performSelector:@selector(showzhuview) withObject:nil afterDelay:3];
        
        [self usenewguanggao];
        
    }else
    {
        [img_TEST removeFromSuperview];
        guanggao_image.image=iPhone5?guanggao_image.image:[self getSubImage:CGRectMake(0, (568-480)*2, 640,guanggao_image.image.size.height)];
        
        guanggao_image.frame=CGRectMake(0, 0, guanggao_image.image.size.width/2, guanggao_image.image.size.height/2+2);
        
        NSLog(@"appdelegate===仔仔到了图片");
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.0];
        guanggao_image.alpha=1;
        // iMagelogo.frame=CGRectMake(43/2,iPhone5? 413+44+40:413, 566/2, 85/2);
        [UIView commitAnimations];
        [self performSelector:@selector(showzhuview) withObject:nil afterDelay:3];
    }
}

-(void)downloadtool:(downloadtool *)tool didfinishdownloadwithdata:(NSData *)data{
    if (tool.tag==99) {
        
        
        @try {
            //  NSDictionary * dic = [data objectFromJSONData];
            
            NSArray *array_test=[data objectFromJSONData];
            NSLog(@"dic== %@",array_test);
            
            if (array_test.count==0) {
                [self showzhuview];
                [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"img"];
                
                NSLog(@"没有找到图片");
                
            }else{
                NSDictionary *dic=[array_test objectAtIndex:0];
                NSLog(@"dic== %@",dic);
                
                NSString *string_src=[NSString stringWithFormat:@"%@",[dic objectForKey:@"imgsrc"]];
                
                NSLog(@"src==%@",string_src);
                [guanggao_image loadImageFromURL:string_src withPlaceholdImage:nil];
                
                
                [[NSUserDefaults standardUserDefaults] setObject:string_src forKey:@"img"];
                
                
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }
    
    if (tool.tag==100) {
        
        @try {
            //  NSDictionary * dic = [data objectFromJSONData];
            
            NSDictionary *array_test=[data objectFromJSONData];
            NSLog(@"======dic== %@",array_test);
            
            
            if (array_test.count==0) {
                
                
                
                [self showzhuview];
                [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"img"];
                
                NSLog(@"没有找到图片");
                
            }else{
                
               NSDictionary *dic=[array_test objectForKey:@""];
                NSLog(@"dic== %@",dic);
                
                NSString *string_src=[NSString stringWithFormat:@"%@",[array_test objectForKey:@"imgsrc"]];
                
                NSLog(@"src==%@",string_src);
                [guanggao_image loadImageFromURL:string_src withPlaceholdImage:nil];
                
              //  [self getImgDatawithstring:string_src];
                
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }
    
    //这个是回来之后看看有没有新消息
    
    
    @try {
        NSDictionary *dic=[data objectFromJSONData];
        if (tool==allnotificationtool)
        {
            NewsMessageNumber = 0;
            
            NSDictionary * alertnum_dic = [dic objectForKey:@"alertnum"];
            
            //  NSLog(@"未读消息 ------  %@",alertnum_dic);
            
            for (int i = 0;i <= 16;i++)
            {
                if (i == 6)
                {
                    if ([[alertnum_dic objectForKey:[NSString stringWithFormat:@"%d",i]] intValue]>0)
                    {
                        _leveyTabBarController.tabBar.tixing_imageView.hidden = NO;

                        [[NSNotificationCenter defaultCenter]postNotificationName:@"fbnotification" object:[NSDictionary dictionary]];
                        
                    }
                }else
                {
                    if ([[alertnum_dic objectForKey:[NSString stringWithFormat:@"%d",i]] intValue]>0)
                    {
                        _leveyTabBarController.tabBar.tixing_imageView.hidden = NO;
                        
                        //                        self.leveyTabBarController.tabBar.tixing_label.hidden = NO;
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"fbnotification" object:[NSDictionary dictionary]];
                        
                    }
 
                    
                }
            }
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}


#pragma mark-使用普通的请求广告，不用asyimg

-(void)getImgDatawithstring:(NSString *)strimg{
    
   
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:strimg]];
    
    __block ASIHTTPRequest * _requset = request;
    
    _requset.delegate = self;
    
    [_requset setCompletionBlock:^{
        
        @try {
            NSDictionary * dic = [request.responseData objectFromJSONData];
            
            if ([[dic objectForKey:@"errcode"] intValue] !=1)
            {
                guanggao_image.image=[UIImage imageWithData:request.responseData];

                
                [img_TEST removeFromSuperview];
                guanggao_image.image=iPhone5?guanggao_image.image:[self getSubImage:CGRectMake(0, (568-480)*2, 640,guanggao_image.image.size.height)];
                
                guanggao_image.frame=CGRectMake(0, MY_MACRO_NAME?0:0, guanggao_image.image.size.width/2, guanggao_image.image.size.height/2);
                
                NSLog(@"appdelegate===仔仔到了图片");
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1.0];
                guanggao_image.alpha=1;
                // iMagelogo.frame=CGRectMake(43/2,iPhone5? 413+44+40:413, 566/2, 85/2);
                [UIView commitAnimations];
                [self performSelector:@selector(showzhuview) withObject:nil afterDelay:3];
                
                
                
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
            
        }
        
        
        
        
    }];
    
    
    [_requset setFailedBlock:^{
        
        [request cancel];
        
        
        //        [self initHttpRequestInfomation];
    }];
    
    [_requset startAsynchronous];

    
    
    
    
}


//- (void)update:(PRTweenPeriod*)period {
//
//    if ([period isKindOfClass:[PRTweenCGPointLerpPeriod class]]) {
//        guanggao_image.center = [(PRTweenCGPointLerpPeriod*)period tweenedCGPoint];
//    } else {
//        guanggao_image.frame = CGRectMake(0, period.tweenedValue, 320,iPhone5? 772/2:772/2);
//    }
//
//}


-(UIImage*)getSubImage:(CGRect)rect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(guanggao_image.image.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}

-(void)downloadtoolError{
    
    NSLog(@"网络链接异常");
    [self showzhuview];
    
}

-(void)showzhuview{
    [guanggao_image cancelDownload];
    guanggao_image.delegate=nil;
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    if (!rootVC || !bbsVC || !weiboVC || !mineVC || !moreVC || !_leveyTabBarController)
    {
        rootVC = [[RootViewController alloc] init];
        UINavigationController * naVC1 = [[UINavigationController alloc] initWithRootViewController:rootVC];
        
        bbsVC = [[BBSViewController alloc] init];
        UINavigationController * naVC2 = [[UINavigationController alloc] initWithRootViewController:bbsVC];
        
        weiboVC = [[NewWeiBoViewController alloc] init];
        UINavigationController * naVC3 = [[UINavigationController alloc] initWithRootViewController:weiboVC];
        
        mineVC = [[CarPortViewController alloc] init];
        UINavigationController * naVC4 = [[UINavigationController alloc] initWithRootViewController:mineVC];
        
        //
        mallVC = [[MallViewController alloc] init];
        UINavigationController * naVC5 = [[UINavigationController alloc] initWithRootViewController:mallVC];
    
        
        naVC1.delegate = (id)self;
        naVC2.delegate = (id)self;
        naVC3.delegate = (id)self;
        naVC4.delegate = (id)self;
        naVC5.delegate = (id)self;
        
        
        NSArray * array = [[NSArray alloc] initWithObjects:naVC1,naVC2,naVC5,naVC4,naVC3,nil];
        
        NSMutableDictionary *imgDic = [NSMutableDictionary dictionaryWithCapacity:3];
        [imgDic setObject:[UIImage imageNamed:@"newsselected.png"] forKey:@"Default"];
        [imgDic setObject:[UIImage imageNamed:@"newsselected.png"] forKey:@"Highlighted"];
        [imgDic setObject:[UIImage imageNamed:@"newsselected.png"] forKey:@"Seleted"];
        NSMutableDictionary *imgDic2 = [NSMutableDictionary dictionaryWithCapacity:3];
        [imgDic2 setObject:[UIImage imageNamed:@"bbsselected.png"] forKey:@"Default"];
        [imgDic2 setObject:[UIImage imageNamed:@"bbsselected.png"] forKey:@"Highlighted"];
        [imgDic2 setObject:[UIImage imageNamed:@"bbsselected.png"] forKey:@"Seleted"];
        NSMutableDictionary *imgDic3 = [NSMutableDictionary dictionaryWithCapacity:3];
        
        [imgDic3 setObject:[UIImage imageNamed:@"personalselected.png"] forKey:@"Default"];
        [imgDic3 setObject:[UIImage imageNamed:@"personalselected.png"] forKey:@"Highlighted"];
        [imgDic3 setObject:[UIImage imageNamed:@"personalselected.png"] forKey:@"Seleted"];
        
        NSMutableDictionary *imgDic4 = [NSMutableDictionary dictionaryWithCapacity:3];
        [imgDic4 setObject:[UIImage imageNamed:@"carportselected.png"] forKey:@"Default"];
        [imgDic4 setObject:[UIImage imageNamed:@"carportselected.png"] forKey:@"Highlighted"];
        [imgDic4 setObject:[UIImage imageNamed:@"carportselected.png"] forKey:@"Seleted"];
        NSMutableDictionary *imgDic5 = [NSMutableDictionary dictionaryWithCapacity:3];
        
        
        [imgDic5 setObject:[UIImage imageNamed:@"fbselectios7.png"] forKey:@"Default"];
        [imgDic5 setObject:[UIImage imageNamed:@"fbselectios7.png"] forKey:@"Highlighted"];
        [imgDic5 setObject:[UIImage imageNamed:@"fbselectios7.png"] forKey:@"Seleted"];
        
        NSArray *imgArr = [NSArray arrayWithObjects:imgDic,imgDic2,imgDic3,imgDic4,imgDic5,nil];
        
        _leveyTabBarController = [[LeveyTabBarController alloc] initWithViewControllers:array imageArray:imgArr];
        [_leveyTabBarController setTabBarTransparent:YES];
        [_leveyTabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"ios7tabbar@2x.png"]];
        _leveyTabBarController.delegate = self;
        
        
        [guanggao_image removeFromSuperview];
        [iMagelogo removeFromSuperview];
        [bigimageview removeFromSuperview];
        
        guanggao_image=nil;
        iMagelogo=nil;
        bigimageview=nil;
        
//        _leveyTabBarController.view.layer.shadowColor = [RGBCOLOR(60,44,45) CGColor];
//        
//        _leveyTabBarController.view.layer.shadowOffset = CGSizeMake(10,0);
//        
//        _leveyTabBarController.view.layer.shadowOpacity = 0.8;
//        
//        _leveyTabBarController.view.layer.shadowRadius = 0.8;
//        
//        _leveyTabBarController.view.layer.masksToBounds = NO;
        
        self.window.rootViewController=_leveyTabBarController;
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"testpush" object:dic_push];
        
        
        moreVC = [[PersonalmoreViewController alloc] init];

        moreVC.view.frame = CGRectMake(320,0,320,iPhone5?568:480);
        
        [self.window addSubview:moreVC.view];
        
        [self.window addSubview:_leveyTabBarController.view];
        
        
        fansVC = [[FansViewController alloc] init];
        
        UINavigationController * fansNav = [[UINavigationController alloc] initWithRootViewController:fansVC];
        
        fansNav.view.frame = CGRectMake(0,0,320,iPhone5?568:480);
        
        fansNav.view.alpha = 0;
        
        fansNav.view.userInteractionEnabled = NO;
        
        [self.window addSubview:fansNav.view];
        
        
        
        
        
        
        _shadowView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        _shadowView.userInteractionEnabled = NO;
        
        _shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        _shadowView.hidden = YES;
        
        [self.window addSubview:_shadowView];
        
        
        
        
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        
        BOOL nightMode = [user boolForKey:@"nightMode"];
        
        if (nightMode)
        {
            _shadowView.hidden = NO;
        }else
        {
            _shadowView.hidden = YES;
        }
    }
}

-(void)setPersonalState:(PersonalStateType)type
{
    if (type == PersonalStateTypeShow)
    {
        [self moveToLeftSide];
    }
}

// move view to left side
- (void)moveToLeftSide
{
    [self animateHomeViewToSide:CGRectMake(-320+42.5,
                                           self.window.frame.origin.y,
                                           self.window.frame.size.width,
                                           self.window.frame.size.height)];
}

// animate home view to side rect
- (void)animateHomeViewToSide:(CGRect)newViewRect
{
    [UIView animateWithDuration:0.2
                     animations:^{
                         
         [[[(AppDelegate *)[[UIApplication sharedApplication] delegate] moreVC]view]setFrame:CGRectMake(0,0,320,568)];
         
         _leveyTabBarController.view.frame = newViewRect;
     }
     completion:^(BOOL finished){
         UIControl *overView = [[UIControl alloc] init];
         overView.tag = 10086;
         overView.backgroundColor = [UIColor clearColor];
         overView.frame = self.window.frame;
         [overView addTarget:self action:@selector(restoreViewLocation) forControlEvents:UIControlEventTouchDown];
         [_leveyTabBarController.view addSubview:overView];
     }];
}


- (void)restoreViewLocation
{
    //    [(AppDelegate *)[[UIApplication sharedApplication] delegate] setLeftViewHidden:NO];
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         
                         [[[(AppDelegate *)[[UIApplication sharedApplication] delegate] moreVC]view]setFrame:CGRectMake(320,0,320,568)];
                         
                         _leveyTabBarController.view.frame = CGRectMake(0,
                                                                            _leveyTabBarController.view.frame.origin.y,
                                                                            _leveyTabBarController.view.frame.size.width,
                                                                            _leveyTabBarController.view.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         UIControl *overView = (UIControl *)[[[UIApplication sharedApplication] keyWindow] viewWithTag:10086];
                         [overView removeFromSuperview];
                         
                     }];
    
    [_leveyTabBarController hidesTabBar:NO animated:YES];
}




- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	if ([viewController isKindOfClass:[RootViewController class]]||[viewController isKindOfClass:[BBSViewController class]]||[viewController isKindOfClass:[NewWeiBoViewController class]]||[viewController isKindOfClass:[CarPortViewController class]]||[viewController isKindOfClass:[MallViewController class]])
	{
        [_leveyTabBarController hidesTabBar:NO animated:YES];
	}else{
        [_leveyTabBarController hidesTabBar:YES animated:NO];
        NSLog(@"1viewController=%@",viewController);
        
    }
    
    //[_leveyTabBarController hidesTabBar:YES animated:YES];
}


- (BOOL)tabBarController:(LeveyTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    static UIViewController *lastController = nil;
    //若上个view不为空
    if (lastController != nil)
    {
        //若该实例实现了viewWillDisappear方法，则调用
        if ([lastController respondsToSelector:@selector(viewWillDisappear:)])
        {
            [lastController viewWillDisappear:NO];
        }
    }
    //将当前要显示的view设置为lastController，在下次view切换调用本方法时，会执行viewWillDisappear
    lastController = viewController;
    
    [viewController viewWillAppear:NO];
    index = tabBarController.selectedIndex;
    return YES;
}
- (void)tabBarController:(LeveyTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    //    NSLog(@"aaaaadddddd ---  %d",tabBarController.selectedIndex);
    //    if (tabBarController.selectedIndex == 3)
    //    {
    //        BOOL authkey = [[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
    //
    //        if (!authkey)
    //        {
    //            if (!logIn)
    //            {
    //                logIn = [[LogInViewController alloc] init];
    //
    //            }
    //            logIn.delegate = self;
    //            [_leveyTabBarController hidesTabBar:YES animated:YES];
    //            [viewController presentModalViewController:logIn animated:YES];
    //        }
    //    }
}


#pragma mark-广告image

-(void)handleSingleTapFrom{
    //    NSURL *url =[NSURL URLWithString:@"www.fblife.com"];
    //    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    //    UIWebView *awebview=[[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //    [awebview loadRequest:request];
    //    [self.window addSubview:awebview];
}
-(void)failToLogIn
{
    NSLog(@"这个方法没走么");
    [_leveyTabBarController hidesTabBar:NO animated:NO];
    //    _leveyTabBarController.selectedIndex = index;
    [_leveyTabBarController displayViewAtIndex:index];
}

-(void)successToLogIn
{
    [_leveyTabBarController hidesTabBar:NO animated:YES];
    _leveyTabBarController.selectedIndex = 3;
}

-(void)seccesDownLoad:(UIImage *)image{
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    
    
    
    
    
    
    
    NSLog(@"===token===%@======",deviceToken);
    
    NSString *string_pushtoken=[NSString stringWithFormat:@"%@",deviceToken];
    
    while ([string_pushtoken rangeOfString:@"<"].length||[string_pushtoken rangeOfString:@">"].length||[string_pushtoken rangeOfString:@" "].length) {
        string_pushtoken=[string_pushtoken stringByReplacingOccurrencesOfString:@"<" withString:@""];
        string_pushtoken=[string_pushtoken stringByReplacingOccurrencesOfString:@">" withString:@""];
        string_pushtoken=[string_pushtoken stringByReplacingOccurrencesOfString:@" " withString:@""];

    }
    
    [[NSUserDefaults standardUserDefaults]setObject:string_pushtoken forKey:DEVICETOKEN];
    
    NSLog(@"mystring_token==%@",string_pushtoken);
    
//更新token
    
    
    
    
    NSString *string_authcode=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:USER_AUTHOD]];
    if (string_authcode.length!=0) {
        NSString *string_updatetoken=[NSString stringWithFormat:@"http://bbs2.fblife.com/localapi/user_app_token.php?action=updatetoken&authcode=%@&token=%@&datatype=json",string_authcode,string_pushtoken ];
        
        NSLog(@"???????????????????????????=string_updatepushtoken==%@",string_pushtoken);
        ASIHTTPRequest *   request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:string_updatetoken]];
        
        __block ASIHTTPRequest * _requset = request;
        
        _requset.delegate = self;
        
        [_requset setCompletionBlock:^{
            NSDictionary * dic = [request.responseData objectFromJSONData];
            
            
            @try {
                if ([[dic objectForKey:@"errcode"] intValue] ==0)
                {
                    
                    NSLog(@"说明绑定成功了");
                }
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
        }];
        
        [_requset setFailedBlock:^{
            
            
            [request cancel];
            
        }];
        
        [_requset startAsynchronous];

    }

    
    
    NSLog(@"__");
    
    
    
    
    // Required
    
    
}




- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    
    
    
    
//    pushinfo===={
//        aps =     {
//            alert = "\U60a8\U6709[1]\U6761\U5f15\U7528\U56de\U590d\U901a\U77e5";
//            badge = 2;
//            sound = default;
//            tid = 3004018;
//            type = 21;
//        };
//    }
    
    NSDictionary *dic_pushinfo=userInfo;

    
    int type=[[[dic_pushinfo objectForKey:@"aps"] objectForKey:@"type"] integerValue];

    if (type<20&&[[NSUserDefaults standardUserDefaults] boolForKey:USER_IN]) {
        
        
        

        
        _leveyTabBarController.tabBar.tixing_imageView.hidden = NO;
        
        
        NSLog(@"pushinfo====%@",userInfo);
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"fbnotification" object:userInfo];
    }
}

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    //    userinfo=={
    //        content = "\U5317\U4eac\U73b0\U4ee3ix35\U660e\U5e74\U5c06\U4e2d\U671f\U6539\U6b3e \U642d2.4L\U76f4\U55b7\U53d1\U52a8\U673a
    //        \n";
    //        extras =     {
    //            newsid = "36016 ";
    //        };
    //    }
    
    
    
    
    
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"newsid"];
    
    NSDictionary * userInfo = [notification userInfo];
    NSLog(@"userinfo==%@",userInfo);
    
    
    NSString *string_newsid=[[userInfo objectForKey:@"extras"] objectForKey:@"newsid"];
    NSUserDefaults *standarduser=[NSUserDefaults standardUserDefaults];
    
    if (string_newsid.length!=0&&![string_newsid isEqualToString:@"(null)"]) {
        [standarduser setObject:string_newsid forKey:@"newsid"];
        [standarduser synchronize];
        
    }
    [standarduser setObject:string_newsid forKey:@"version"];
    
    NSString *string_update=[[userInfo objectForKey:@"extras"] objectForKey:@"version"];
    
    [standarduser setObject:string_update forKey:@"version"];
    NSLog(@"stringupdate===%@",string_update);
    if (string_update.length>0) {
        NSString *content = [userInfo valueForKey:@"content"];
        [standarduser setObject:content forKey:@"content"];
    }
    [standarduser synchronize];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    
    //    [_infoLabel setText:[NSString stringWithFormat:@"收到消息\ndate:%@\ntitle:%@\ncontent:%@", [dateFormatter stringFromDate:[NSDate date]],title,content]];
    //    UIAlertView *alert_=[[UIAlertView alloc]initWithTitle:@"推送的消息" message:[NSString stringWithFormat:@"收到消息\ndate:%@\ncontent:%@", [dateFormatter stringFromDate:[NSDate date]],content] delegate:nil cancelButtonTitle:@"去看看" otherButtonTitles:@"正在忙", nil];
    //    [alert_ show];
}


#pragma mark-强制刷新
#pragma mark-判断是否更新版本，以及是否更新缓存里面的数据
-(void)judgeversionandclean{
    
    NSUserDefaults *standuser=[NSUserDefaults standardUserDefaults];
    int i=10;
    [standuser setInteger:i forKey:@"judgeversionandclean"];
    [standuser synchronize];
    
    
    NSURL * fullUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/version.php?appversion=%@",NOW_VERSION]];
    
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:fullUrl];
    
    __block ASIHTTPRequest * _request = request;
    
    request.delegate = self;
    
    [_request setCompletionBlock:^{
        
        @try {
            NSDictionary * dic__ = [request.responseData objectFromJSONData];
            
            NSString * bbsInfo = [NSString stringWithFormat:@"%@",[dic__ objectForKey:@"bbsinfo"]];
            NSString *string_refresh=[NSString stringWithFormat:@"%@",[dic__ objectForKey:@"isrefresh"]];
            if ([string_refresh isEqualToString:@"0"]) {
                NSLog(@"判断了，走的是进行缓存");
                int i=10;
                [standuser setInteger:i forKey:@"judgeversionandclean"];
                [standuser synchronize];
                
            }else{
                
                int i=11;
                [standuser setInteger:i forKey:@"judgeversionandclean"];
                [standuser synchronize];
                for (int i=0;i < 6;i++)
                {
                    [FbFeed deleteAllByType:i+1];
                }
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"bbsSelect"];
                
            }
            NSLog(@"dic===%@",dic__);
            if (![bbsInfo isEqualToString:NOW_VERSION])
            {
                int i=12;
                [standuser setInteger:i forKey:@"judgeversionandclean"];
                [standuser synchronize];
            }else
            {
                
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }];

    
    [_request setFailedBlock:^{
        //        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"检测失败,请检查您当前网络是否正常" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        //        [alert show];
    }];
    
    [request startAsynchronous];
    
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"chuqu le ?");
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"十分钟了");
    UIBackgroundTaskIdentifier taskID = 0;
    
    taskID = [application beginBackgroundTaskWithExpirationHandler:^{
        //如果系统觉得我们还是运行了太久，将执行这个程序块，并停止运行应用程序
        [application endBackgroundTask:taskID];
    }];
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
//    
    center = [[CTCallCenter alloc ] init ];
//    
//    self._center=center;
    
    
    
   center.callEventHandler = ^(CTCall *call )
    {
 
        NSLog (@"call:%@" , call .callState);
    };

    
    
    NSLog(@"ssss=====application====%@",application);
    
    NSLog(@"huilaile ");
     [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    
    
    [MobClick setDelegate:self];
    
    [MobClick appLaunched];
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


#pragma mark-获取通知总数
//-(void)AllNumberofNotification{
//    [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(checkallmynotification) userInfo:nil repeats:YES];
//
//
//}
-(void)checkallmynotification
{
    NSString *string_code=[[NSUserDefaults standardUserDefaults]objectForKey:USER_AUTHOD];
    
    //    NSLog(@"steing_code ----   %@",string_code);
    
    if (string_code.length !=0 && ![string_code isEqual:[NSNull null]])
    {
        if (!allnotificationtool)
        {
            allnotificationtool=[[downloadtool alloc]init];
        }
        
        [allnotificationtool setUrl_string:[NSString stringWithFormat:@"http://fb.fblife.com/openapi/index.php?mod=alert&code=alertnumbytype&fromtype=b5eeec0b&authkey=%@&fbtype=json",string_code ]];
        
        //  NSLog(@"未读消息接口 ----   %@",[NSString stringWithFormat:@"http://fb.fblife.com/openapi/index.php?mod=alert&code=alertnumbytype&fromtype=b5eeec0b&authkey=%@&fbtype=json",string_code ]);
        
        allnotificationtool.delegate=self;
        [allnotificationtool start];
    }
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:sourceApplication message:[url absoluteString] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [alert show];
    
    
    NSLog(@"------%@",sourceApplication);
    
    
    
    return  [WXApi handleOpenURL:url delegate:self];
    
    // return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}
#pragma mark-这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UMSocialSnsService  applicationDidBecomeActive];
    
    
 
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    
  
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//-(void)application:(UIApplication *)application didChangeStatusBarFrame:(CGRect)oldStatusBarFrame{
//    NSLog(@"statubar.....=========%f",oldStatusBarFrame.origin.y);
//    
//    NSLog(@"stat=====ubar.....=========%f", _leveyTabBarController.view.frame.origin.y);
//    NSLog(@"ssssss=====%f",_leveyTabBarController.tabBar.frame.origin.y);
//    
////    if (MY_MACRO_NAME) {
//        if (_leveyTabBarController.view.frame.origin.y>0) {
//            
////            _leveyTabBarController.tabBar.frame=CGRectMake(_leveyTabBarController.tabBar.frame.origin.x, _leveyTabBarController.tabBar.frame.origin.y-20, _leveyTabBarController.tabBar.frame.size.width, _leveyTabBarController.tabBar.frame.size.height);
//            _leveyTabBarController.view.frame=CGRectMake(0, 0, _leveyTabBarController.view.frame.size.width, _leveyTabBarController.view.frame.size.height);
//            
//        }else{
//            
////            _leveyTabBarController.tabBar.frame=CGRectMake(_leveyTabBarController.tabBar.frame.origin.x,iPhone5?431+88: 431, _leveyTabBarController.tabBar.frame.size.width, _leveyTabBarController.tabBar.frame.size.height);
////            
//        }
//
//        
////    }else{
////        
////        
////        
////    }
//
//    
//}


@end

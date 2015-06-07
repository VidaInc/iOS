//
//  ApplicationStyle.m
//  Vida
//
//  Created by Wenqi Zhou on 2014-10-28.
//  Copyright (c) 2014 Vida. All rights reserved.
//

#import "ApplicationStyle.h"

static int temperature = 0;
static NSString *ip=@"192.168.0.25";
static NSString *userId = @"0";

@implementation ApplicationStyle

+(void)initializeApplicationStyle{
    [UIFont setBaseFontFamilyName:@"Avenir"];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageFromColor:[ApplicationStyle navigationBarBackgroundColor]] forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setTintColor:[ApplicationStyle navigationBarTitleColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSAttributes attributesWithFont:[ApplicationStyle navigationBarTitleFont] textColor:[ApplicationStyle navigationBarTitleColor]]];
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"navigation-button-back"]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"navigation-button-back"]];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSAttributes attributesWithFont:[ApplicationStyle navigationBarRightButtonFont] textColor:[ApplicationStyle navigationBarTitleColor]]
                                                forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSAttributes attributesWithFont:[ApplicationStyle navigationBarRightButtonFont] textColor:[ApplicationStyle navigationBarButtonDisabledColor]]
                                                forState:UIControlStateDisabled];
    return;
}

+(void)setPreferTemp:(int)temp {
    temperature = temp;
}

+(int)getPreferTemp {
    return temperature;
}

@end

@implementation ApplicationStyle (String)

+(void)setUser:(NSString *)user {
    userId = user;
}

+(NSString *)getUserId {
    return userId;
}

+(void)setIP:(NSString *)IP {
    ip = IP;
}

+(NSString *)baseURLString {
    return [NSString stringWithFormat:@"http://%@:8000/api/", ip];
}

@end

@implementation ApplicationStyle (Sizes)

+ (CGFloat)extraLargeTextSize{return 19.0f;}
+ (CGFloat)largeTextSize{return 17.0f;}
+ (CGFloat)mediumTextSize{return 14.0f;}
+ (CGFloat)regularTextSize{return 12.0f;}
+ (CGFloat)smallTextSize{return 10.0f;}

+ (CGFloat)sidebarWidth{return 178.0f;}

+ (CGFloat)spaceInset{return 15.0f;}
+ (CGFloat)buttonWidth{return 145.0f;}
+ (CGFloat)buttonHeight{return 45.0f;}

+ (CGFloat)horizontalInset{return 15.0f;}

@end

@implementation ApplicationStyle (Colors)

+ (UIColor *)backgroundColor{return [UIColor colorWithRed:RGBValue(240) green:RGBValue(240) blue:RGBValue(244) alpha:1];}

+ (UIColor *)backgroundDarkColor{return [UIColor colorWithWhite:RGBValue(200) alpha:1];}

+ (UIColor *)cellOffTextColor{return [UIColor colorWithRed:RGBValue(125) green:RGBValue(124) blue:RGBValue(130) alpha:1];}

+ (UIColor *)cellBlurColor{return [UIColor colorWithRed:RGBValue(0) green:RGBValue(133) blue:RGBValue(246) alpha:1];}

@end

@implementation ApplicationStyle (Fonts)

+ (UIFont *)cellTextFont {
    return [UIFont fontWithName:@"HelveticaNeue" size:22];
}

+ (UIFont *)cellsecondTitleFont {
    return [UIFont fontWithName:@"HelveticaNeue" size:12];
}

+ (UIFont *)cellTempFont {
    return [UIFont fontWithName:@"HelveticaNeue" size:30];
}

@end

@implementation ApplicationStyle (NavigationBar)

+ (UIColor *)navigationBarBackgroundColor{return [UIColor colorWithWhite:RGBValue(247.0f) alpha:0.80f];}
+ (UIColor *)navigationBarTitleColor{return [UIColor blackColor];}
+ (UIFont *)navigationBarTitleFont{return [UIFont fontWithType:FontTypeMedium andSize:[ApplicationStyle largeTextSize]];}
+ (UIFont *)navigationBarRightButtonFont{return [UIFont fontWithName:@"Avenir-Heavy" size:[self largeTextSize]];}
+ (UIColor *)navigationBarButtonDisabledColor{return [UIColor colorWithRed:RGBValue(64) green:RGBValue(64) blue:RGBValue(64) alpha:1];}

+ (CGFloat)navigationBarHeight{return 64.0f;}

+(void)customizeLeftButton:(UIViewController *)target hander:(SEL) handler withImage: (UIImage *)image
{
    UIButton *tempView = [UIButton buttonWithType:UIButtonTypeCustom];
    
    tempView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    [tempView setImage:image forState:UIControlStateNormal];
    [tempView setImage:image forState:UIControlStateDisabled];
    [tempView addTarget:target action:handler forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithCustomView:tempView ];
    target.navigationItem.leftBarButtonItem = btn;
}

+(void)customizeRightButton:(UIViewController *)target hander:(SEL) handler withImage: (UIImage *)image
{
    UIButton *tempView = [UIButton buttonWithType:UIButtonTypeCustom];
    
    tempView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    [tempView setImage:image forState:UIControlStateNormal];
    [tempView setImage:image forState:UIControlStateDisabled];
    [tempView addTarget:target action:handler forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithCustomView:tempView ];
    target.navigationItem.rightBarButtonItem = btn;
}

+(void)customizeTitle:(UIViewController *)target withImage: (UIImage *)image
{
    UIImageView *tempView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [tempView setImage:image];
    target.navigationItem.titleView = tempView;
}
    
@end
//
//  ApplicationStyle.h
//  Vida
//
//  Created by Wenqi Zhou on 2014-10-28.
//  Copyright (c) 2014 Vida. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApplicationStyle : NSObject

+(void)initializeApplicationStyle;

+(void)setPreferTemp:(int)temp;
+(int)getPreferTemp;

@end

@interface ApplicationStyle (String)

+(void)setIP:(NSString *)IP;
+(void)setUser:(NSString *)user;
+(NSString *)getUserId;
+(NSString *)baseURLString;

@end

@interface ApplicationStyle (Sizes)

+ (CGFloat)extraLargeTextSize;
+ (CGFloat)largeTextSize;
+ (CGFloat)mediumTextSize;
+ (CGFloat)regularTextSize;
+ (CGFloat)smallTextSize;

+ (CGFloat)sidebarWidth;

+ (CGFloat)spaceInset;
+ (CGFloat)buttonWidth;
+ (CGFloat)buttonHeight;

+ (CGFloat)horizontalInset;
@end

@interface ApplicationStyle (Colors)

+ (UIColor *)backgroundColor;
+ (UIColor *)backgroundDarkColor;
+ (UIColor *)cellOffTextColor;
+ (UIColor *)cellBlurColor;
@end

@interface ApplicationStyle (Fonts)

+ (UIFont *)cellTextFont;
+ (UIFont *)cellsecondTitleFont;
+ (UIFont *)cellTempFont;
@end

@interface ApplicationStyle (NavigationBar)

+ (UIColor *)navigationBarBackgroundColor;
+ (UIColor *)navigationBarTitleColor;
+ (UIFont *)navigationBarTitleFont;
+ (UIFont *)navigationBarRightButtonFont;
+ (UIColor *)navigationBarButtonDisabledColor;
+ (CGFloat)navigationBarHeight;
+(void)customizeLeftButton:(UIViewController *)target hander:(SEL) handler withImage: (UIImage *)image;
+(void)customizeRightButton:(UIViewController *)target hander:(SEL) handler withImage: (UIImage *)image;
+(void)customizeTitle:(UIViewController *)target withImage: (UIImage *)image;

@end
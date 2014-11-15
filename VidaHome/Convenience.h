//
//  Convenience.h
//  Vida
//
//  Created by Wenqi Zhou on 2014-11-14.
//  Copyright (c) 2014 Vida. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    FontTypeRegular = 0,
    FontTypeLight,
    FontTypeUltraLight,
    FontTypeMedium,
    FontTypeBold,
    FontTypeLightOblique,
    FontTypeBook,
    FontTypeBookOblique,
    FontTypeRoman,
    FontTypeOblique,
    FontTypeMediumOblique,
    FontTypeBlack,
    FontTypeBlackOblique,
    FontTypeHeavy,
    FontTypeHeavyOblique
} FontType;

@interface UIFont (Convenience)

+ (NSString *)baseFontFamilyName;
+ (void)setBaseFontFamilyName:(NSString *)baseFontFamilyName;

+ (NSString *)fontNameWithType:(FontType)fontType;
+ (UIFont *)fontWithType:(FontType)fontType andSize:(CGFloat)fontSize;

@end

@interface UIImage (Convenience)

+ (UIImage *)imageFromColor:(UIColor *)color;

@end

#define COLOR_VALUE_MAX 255.0f
#define RGBValue(x) (x/COLOR_VALUE_MAX)

@interface UIColor (Convenience)

- (NSString *)hexStringFromColor;

@end

@interface UIView (Convenience)

- (CGFloat)viewHeight;
- (CGFloat)leftSidePosition;
- (CGFloat)topPosition;
- (CGFloat)rightSideOffset;
- (CGFloat)bottomOffset;
- (CGFloat)viewWidth;

- (void)setXPosition:(CGFloat)xPosition;
- (void)setYPosition:(CGFloat)yPosition;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;

- (void)offsetXPosition:(CGFloat)xOffset;
- (void)offsetYPosition:(CGFloat)yOffset;

- (void)centerInWidth:(CGFloat)width;
- (void)centerInWidth:(CGFloat)width forXOffset:(CGFloat)xOffset;
- (void)centerInHeight:(CGFloat)height;
- (void)centerInHeight:(CGFloat)height forYOffset:(CGFloat)yOffset;
- (void)centerInSize:(CGSize)size;
- (void)centerHorizontallyToView:(UIView *)view;
- (void)centerVerticallyToView:(UIView *)view;

@end

#pragma mark - NSDictionary Convenience -

@interface NSAttributes : NSDictionary
@end

@interface NSDictionary (AttributesConvenience)

+ (instancetype)attributesWithFontType:(FontType)fontType pointSize:(CGFloat)pointSize andColor:(UIColor *)color;
+ (instancetype)attributesWithFont:(UIFont *)font textColor:(UIColor *)textColor;
+ (instancetype)attributesWithFont:(UIFont *)font textColor:(UIColor *)textColor lineSpacing:(CGFloat)lineSpacing;

@end

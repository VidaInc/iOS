//
//  Convenience.m
//  Vida
//
//  Created by Wenqi Zhou on 2014-11-14.
//  Copyright (c) 2014 Vida. All rights reserved.
//

#import "Convenience.h"

#pragma mark - UIFont Convenience -

static NSString *baseFontFamilyName = @"HelveticaNeue";

@implementation UIFont (Convenience)

+ (NSString *)baseFontFamilyName{return baseFontFamilyName;}
+ (void)setBaseFontFamilyName:(NSString *)_baseFontFamilyName{baseFontFamilyName = _baseFontFamilyName;}

+ (NSString *)fontNameWithType:(FontType)fontType
{
    NSString *fontExtension = nil;
    switch(fontType)
    {
        case FontTypeLight:
        {
            fontExtension = @"Light";
            break;
        }
        case FontTypeUltraLight:
        {
            fontExtension = @"UltraLight";
            break;
        }
        case FontTypeMedium:
        {
            fontExtension = @"Medium";
            break;
        }
        case FontTypeBold:
        {
            fontExtension = @"Bold";
            break;
        }
        case FontTypeLightOblique:
        {
            fontExtension = @"Light Oblique";
            break;
        }
        case FontTypeBook:
        {
            fontExtension = @"Book";
            break;
        }
        case FontTypeBookOblique:
        {
            fontExtension = @"Book Oblique";
            break;
        }
        case FontTypeRoman:
        {
            fontExtension = @"Roman";
            break;
        }
        case FontTypeOblique:
        {
            fontExtension = @"Oblique";
            break;
        }
        case FontTypeMediumOblique:
        {
            fontExtension = @"Medium Oblique";
            break;
        }
        case FontTypeBlack:
        {
            fontExtension = @"Black";
            break;
        }
        case FontTypeBlackOblique:
        {
            fontExtension = @"Black Oblique";
            break;
        }
        case FontTypeHeavy:
        {
            fontExtension = @"Heavy";
            break;
        }
        case FontTypeHeavyOblique:
        {
            fontExtension = @"Heavy Oblique";
            break;
        }
        default:
        {
            fontExtension = @"";
            break;
        }
    }
    return [NSString stringWithFormat:@"%@%@%@", [self baseFontFamilyName], (fontExtension.length ? @"-" : @""), fontExtension];
}

+ (UIFont *)fontWithType:(FontType)fontType andSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:[self fontNameWithType:fontType] size:fontSize];
}

@end

@implementation UIImage (Convenience)

+ (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

@implementation UIColor (Convenience)

- (NSString *)hexStringFromColor
{
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    
    return [NSString stringWithFormat:@"%02lX%02lX%02lX",
            lroundf(r * 255),
            lroundf(g * 255),
            lroundf(b * 255)];
}

@end

@implementation UIView (Convenience)

- (CGFloat)viewHeight{return self.frame.size.height;}
- (CGFloat)leftSidePosition{return self.frame.origin.x;}
- (CGFloat)topPosition{return self.frame.origin.y;}
- (CGFloat)rightSideOffset{return self.frame.origin.x + self.frame.size.width;}
- (CGFloat)bottomOffset{return self.frame.origin.y + self.frame.size.height;}
- (CGFloat)viewWidth{return self.frame.size.width;}

- (void)setXPosition:(CGFloat)xPosition
{
    CGRect newFrame = self.frame;
    newFrame.origin.x = xPosition;
    [self setFrame:newFrame];
}

- (void)setYPosition:(CGFloat)yPosition
{
    CGRect newFrame = self.frame;
    newFrame.origin.y = yPosition;
    [self setFrame:newFrame];
}

- (void)setWidth:(CGFloat)width
{
    CGRect newFrame = self.frame;
    newFrame.size.width = width;
    [self setFrame:newFrame];
}

- (void)setHeight:(CGFloat)height
{
    CGRect newFrame = self.frame;
    newFrame.size.height = height;
    [self setFrame:newFrame];
}

- (void)offsetXPosition:(CGFloat)xOffset
{
    [self setXPosition:self.leftSidePosition + xOffset];
}

- (void)offsetYPosition:(CGFloat)yOffset
{
    [self setYPosition:self.topPosition + yOffset];
}

- (void)centerInWidth:(CGFloat)width
{
    [self centerInWidth:width forXOffset:0.0f];
}

- (void)centerInWidth:(CGFloat)width forXOffset:(CGFloat)xOffset
{
    [self setXPosition:(width - self.frame.size.width)/2.0f + xOffset];
}

- (void)centerInHeight:(CGFloat)height
{
    [self centerInHeight:height forYOffset:0.0f];
}

- (void)centerInHeight:(CGFloat)height forYOffset:(CGFloat)yOffset
{
    [self setYPosition:(height - self.frame.size.height)/2.0f + yOffset];
}

- (void)centerInSize:(CGSize)size
{
    CGRect newFrame = self.frame;
    newFrame.origin.x = (size.width - newFrame.size.width)/2;
    newFrame.origin.y = (size.height - newFrame.size.height)/2;
    [self setFrame:newFrame];
}

- (void)centerHorizontallyToView:(UIView *)view
{
    [self centerInWidth:view.viewWidth forXOffset:view.leftSidePosition];
}

- (void)centerVerticallyToView:(UIView *)view
{
    [self centerInHeight:view.viewHeight forYOffset:view.topPosition];
}

@end

#pragma mark - NSDictionary Convenience -

@implementation NSAttributes
@end

@implementation NSDictionary (AttributesConvenience)

+ (instancetype)attributesWithFontType:(FontType)fontType pointSize:(CGFloat)pointSize andColor:(UIColor *)color
{
    return [self attributesWithFont:[UIFont fontWithType:fontType andSize:pointSize] textColor:color];
}

+ (instancetype)attributesWithFont:(UIFont *)font textColor:(UIColor *)textColor
{
    return [self attributesWithFont:font textColor:textColor lineSpacing:-1.0f];
}

+ (instancetype)attributesWithFont:(UIFont *)font textColor:(UIColor *)textColor lineSpacing:(CGFloat)lineSpacing
{
    NSMutableDictionary *attributesDictionary = @{NSFontAttributeName: font,
                                                  NSForegroundColorAttributeName: textColor}.mutableCopy;
    if(lineSpacing >= 0.0f)
    {
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        [paragraphStyle setLineSpacing:lineSpacing];
        [attributesDictionary setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    }
    
    return attributesDictionary.copy;
}

@end
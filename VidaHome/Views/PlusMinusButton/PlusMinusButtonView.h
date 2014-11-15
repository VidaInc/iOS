//
//  PlusMinusButtonView.h
//  Alfred
//
//  Created by Nabiilah Rajabalee on 2014-03-18.
//  Copyright (c) 2014 Halogen Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PlusMinusButtonDelegate;

@interface PlusMinusButtonView : UIView

+ (PlusMinusButtonView*)initPlusMinusButtonViewWithCurrentValue:(NSInteger)currValue minValue:(NSInteger)minValue maxValue:(NSInteger)maxValue;

@property (nonatomic, weak) id<PlusMinusButtonDelegate> delegate;

-(void)setEnabled:(BOOL)enabled;
@property (nonatomic) NSInteger currentValue;

@end

@protocol PlusMinusButtonDelegate

- (void)plusMinusButtonUpdated:(NSInteger)value;

@end

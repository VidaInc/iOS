//
//  PlusMinusButtonView.m
//  Alfred
//
//  Created by Nabiilah Rajabalee on 2014-03-18.
//  Copyright (c) 2014 Halogen Mobile. All rights reserved.
//

#import "PlusMinusButtonView.h"
#import "ApplicationStyle.h"
#import "PlusMinusButton.h"

#define HEIGHT 34.0f
#define NUM_VIEW_LENGTH 32.0f

@interface PlusMinusButtonView() {
    CGFloat width;
    CGFloat height;
    
    UIButton *plusButton;
    UILabel *numberLabel;
    UIButton *minusButton;
}

@property (nonatomic) NSInteger maxValue;
@property (nonatomic) NSInteger minValue;

@end

@implementation PlusMinusButtonView

+ (PlusMinusButtonView*)initPlusMinusButtonViewWithCurrentValue:(NSInteger)currValue minValue:(NSInteger)minValue maxValue:(NSInteger)maxValue {
    PlusMinusButtonView *view = [[PlusMinusButtonView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, [ApplicationStyle buttonHeight])];
    view.currentValue = currValue;
    view.maxValue = maxValue;
    view.minValue = minValue;
    [view buildUI];
    return view;
}

- (id)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        width = frame.size.width;
        height = frame.size.height;
    }
    return self;
}

- (void)buildUI {
    CGFloat currentOffset = 0.0f;
    
    /* Minus button */
    minusButton = [PlusMinusButton initMinusButton];
    [minusButton centerInHeight:self.viewHeight forYOffset:0.0f];
    [minusButton addTarget:self action:@selector(plusMinusButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect minusButtonFrame = minusButton.frame;
    minusButtonFrame.origin.x = currentOffset;
    minusButton.frame = minusButtonFrame;
    [self addSubview:minusButton];
    
    currentOffset += minusButton.viewWidth;
    
    numberLabel = [[UILabel alloc]init];
    [numberLabel setText:[NSString stringWithFormat:@"%ld", (long)self.currentValue]];
    CGSize labelSize = [[NSString stringWithFormat:@"%ld", (long)self.currentValue] sizeWithAttributes:[NSAttributes attributesWithFont:numberLabel.font textColor:numberLabel.textColor]];
    
    CGRect frame = numberLabel.frame;
    frame.size = labelSize;
    numberLabel.frame = frame;
    [numberLabel centerInWidth:NUM_VIEW_LENGTH forXOffset:minusButton.rightSideOffset];
    [numberLabel centerInHeight:height];
    [self addSubview:numberLabel];
    
    currentOffset += NUM_VIEW_LENGTH;
    
    /* Plus button */
    plusButton = [PlusMinusButton initPlusButton];
    [plusButton centerInHeight:self.viewHeight forYOffset:0.0f];
    [plusButton addTarget:self action:@selector(plusMinusButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect plusButtonFrame = plusButton.frame;
    plusButtonFrame.origin.x = currentOffset;
    plusButton.frame = plusButtonFrame;
    [self addSubview:plusButton];
    
    currentOffset += plusButton.viewWidth;
    
    /* Adjust Width */
    CGRect newFrame = self.frame;
    newFrame.size.width = currentOffset;
    self.frame = newFrame;
}

-(void)setEnabled:(BOOL)enabled {
    [plusButton setEnabled:enabled];
    [minusButton setEnabled:enabled];
}

- (void)plusMinusButtonPressed:(UIButton*)button{
    if (button == plusButton){
        if (self.currentValue < self.maxValue){
            self.currentValue++;
        }
    } else if (button == minusButton){
        if (self.currentValue > self.minValue){
            self.currentValue--;
        }
    }
    
    NSString *numberLabelText = [NSString stringWithFormat:@"%ld", (long)self.currentValue];
    CGSize labelSize = [numberLabelText sizeWithAttributes:[NSAttributes attributesWithFont:numberLabel.font textColor:numberLabel.textColor]];
    numberLabel.text = numberLabelText;
    
    CGRect newFrame = numberLabel.frame;
    newFrame.size = labelSize;
    numberLabel.frame = newFrame;
    [numberLabel centerInHeight:height];
    [numberLabel centerInWidth:NUM_VIEW_LENGTH forXOffset:minusButton.rightSideOffset];
    
    [self.delegate plusMinusButtonUpdated:self.currentValue];
}

- (void)setCurrentValue:(NSInteger)currentValue
{
    _currentValue = currentValue;
    [numberLabel setText:[NSString stringWithFormat:@"%ld", (long)self.currentValue]];
}
@end

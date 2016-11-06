//
//  CRUnderLineTextField.m
//  CroAddress
//
//  Created by Departures on 04/11/2016.
//  Copyright © 2016 Crownor.com. All rights reserved.
//

#import "CRUnderLineTextField.h"

@implementation CRUnderLineTextField

- (void)drawRect:(CGRect)rect {
    self.tintColor = [UIColor lightGrayColor];
    [self setBackgroundColor:[UIColor clearColor]];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextFillRect(context, CGRectMake(3, CGRectGetHeight(self.frame) -1, CGRectGetWidth(self.frame), 1));
    self.borderStyle = UITextBorderStyleNone;
    
}

@end

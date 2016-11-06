//
//  newContactViewController.h
//  CroAddress
//
//  Created by Departures on 04/11/2016.
//  Copyright © 2016 Crownor.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRUnderLineTextField.h"
@interface newContactViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet CRUnderLineTextField *nameTextField;
@property (weak, nonatomic) IBOutlet CRUnderLineTextField *telTextField;
- (IBAction)signUpButtonDidPress:(id)sender;
- (IBAction)goBackButtonDidPress:(id)sender;

@property  UIVisualEffectView *blurView;


@end

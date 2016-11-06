//
//  ResultViewController.h
//  CroAddress
//
//  Created by Departures on 04/11/2016.
//  Copyright © 2016 Crownor.com. All rights reserved.
//
#import "CRUnderLineTextField.h"
#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController
- (IBAction)searchByNameButtonDidPress:(id)sender;

- (IBAction)searchByTelButtonDidPress:(id)sender;
- (IBAction)goBackButtonDidPress:(id)sender;
- (IBAction)alterButtonDidPress:(id)sender;
- (IBAction)backButtonDidpress:(id)sender;
@property (weak, nonatomic) IBOutlet CRUnderLineTextField *nameTextField;
@property (weak, nonatomic) IBOutlet CRUnderLineTextField *targetTextField;
@property (weak, nonatomic) IBOutlet CRUnderLineTextField *telTextField;
@property (weak, nonatomic) IBOutlet UIView *resultView;
@property  UIVisualEffectView *blurView;
@property BOOL isName;
@end

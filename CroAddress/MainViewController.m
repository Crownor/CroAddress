//
//  MainViewController.m
//  CroAddress
//
//  Created by Departures on 03/11/2016.
//  Copyright © 2016 Crownor.com. All rights reserved.
//

#import "VMButtonCircleFun.h"
#import "MainViewController.h"

#define rgb(r, g, b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addCircleView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)padButtonDidPress{
    [self performSegueWithIdentifier:@"MainToSearch" sender:self ];
}

-(void)contactsButtonDidPress{
    [self performSegueWithIdentifier:@"GoContacts" sender:self];
}

-(void)newContactButtonDidPress{
    [self performSegueWithIdentifier:@"GoNew" sender:self];
}

- (void)addCircleView{
    
    
    VMButtonCircleFun *circleView1 = [[VMButtonCircleFun alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [circleView1 addCirclrLayerWithType:VMMakeLocationTop];
    circleView1.strokeColor =rgb(74, 220, 239);
    circleView1.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2 - 100, CGRectGetHeight(self.view.bounds)/2);
    [circleView1 setIconButton:[UIImage imageNamed:@"newContact.png"] withType:VMMakeLocationTop withColor:rgb(127, 140, 141)];
    [circleView1 setLineWidthValue:1];
    [self.view addSubview:circleView1];
    [circleView1 addAction:@selector(contactsButtonDidPress)];
    [circleView1 buildButton];
        
    
    
    VMButtonCircleFun *circleView2 = [[VMButtonCircleFun alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [circleView2 addCirclrLayerWithType:VMMakeLocationBotom];
    circleView2.strokeColor = rgb(243, 106, 106);
    circleView2.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2, CGRectGetHeight(self.view.bounds)/2);
    [circleView2 setIconButton:[UIImage imageNamed:@"Keypad.png"] withType:VMMakeLocationBotom withColor:rgb(127, 140, 141)];
    [circleView2 setLineWidthValue:1];
    [self.view addSubview:circleView2];
    [circleView2 buildButton];
    
    VMButtonCircleFun *circleView3 = [[VMButtonCircleFun alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [circleView3 addCirclrLayerWithType:VMMakeLocationTop];
    circleView3.strokeColor = rgb(255, 195, 45);
    circleView3.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2 + 100, CGRectGetHeight(self.view.bounds)/2);
    [circleView3 setIconButton:[UIImage imageNamed:@"Contacts.png"] withType:VMMakeLocationTop withColor:rgb(127, 140, 141)];
    [circleView3 setLineWidthValue:1];
    [self.view addSubview:circleView3];
    [circleView3 buildButton];
    
    
    UIButton *padButton = [[UIButton alloc] initWithFrame:[circleView1 getImageIconFrame]];
    [padButton addTarget:self action:@selector(padButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *newContactButton =[[UIButton alloc]initWithFrame:[circleView2 getImageIconFrame]];
    [newContactButton addTarget:self action:@selector(newContactButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *contactsButton =[[UIButton alloc]initWithFrame:[circleView3 getImageIconFrame]];
    [contactsButton addTarget:self action:@selector(contactsButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
    
//    
    [circleView1 addSubview:newContactButton];
//
    [circleView2 addSubview:padButton];

    [circleView3 addSubview:contactsButton];

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

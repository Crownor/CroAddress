//
//  ResultViewController.m
//  CroAddress
//
//  Created by Departures on 04/11/2016.
//  Copyright © 2016 Crownor.com. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()
@property int countNum;
@end

@implementation ResultViewController
@synthesize resultMutableArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setBackgroundImageBlur{
    //添加毛玻璃效果，所有的之后元素要加到blurView上
    UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    self.blurView = [[UIVisualEffectView alloc]initWithEffect:beffect];
    self.blurView.frame = self.view.bounds;
    [self.view addSubview:self.blurView];
    [_blurView addSubview:self.resultView];
    [self.resultView setHidden:FALSE];
}
-(NSMutableDictionary *)getNameFile{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    // plist 路径
    NSString *plistPathForName = [documentsDirectory stringByAppendingPathComponent:@"contactsByName.plist"];
    NSMutableDictionary *contactsDictByName = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPathForName];
    return contactsDictByName;
}

-(NSMutableDictionary *)getTelFile{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    // plist 路径
    NSString *plistPathForTel = [documentsDirectory stringByAppendingPathComponent:@"contactsByTel.plist"];
    NSMutableDictionary *contactsDictByTel = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPathForTel];
    return contactsDictByTel;
}

-(NSArray *)getDictSorted:(NSMutableDictionary *)dict{
    NSArray *array = [dict allKeys];
    NSArray *resulyArray = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return [obj1 compare:obj2 options:NSNumericSearch];}];
    NSLog(@"%@",resulyArray);
    return resulyArray;
    
}



- (IBAction)searchByNameButtonDidPress:(id)sender {
    resultMutableArray = [NSMutableArray array];
    [resultMutableArray removeAllObjects];
    NSMutableDictionary *resultDict =  [self getNameFile];
    NSMutableString *targetString = [[NSMutableString alloc]initWithString:[NSString stringWithFormat:@"%lu",[self.targetTextField.text hash]]];
    
    
    while ([[resultDict allKeys]containsObject:targetString]) {
        _countNum = 0;
        if ([[[resultDict objectForKey:targetString]objectForKey:@"nameString"] isEqualToString:self.targetTextField.text]) {
            NSDictionary *resultDic = [NSDictionary dictionaryWithObjectsAndKeys:self.targetTextField.text,@"name",[[resultDict objectForKey:targetString]objectForKey:@"telString"],@"tel", nil];
            [resultMutableArray addObject:resultDic];
        }
       double targetNum = [targetString doubleValue];

        [targetString setString:[NSString stringWithFormat:@"%lu",(unsigned long)(targetNum+1)]];
    }
    if (!([resultMutableArray count] ==0)) {
        [self setBackgroundImageBlur];
        self.nameTextField.text = self.targetTextField.text;
        self.telTextField.text = [[resultMutableArray objectAtIndex:0]objectForKey:@"tel"];
        self.beforeName = self.nameTextField.text;
        self.beforeTel = self.telTextField.text;
        if ([self.resultMutableArray count] > 0) {
            [self.nextButton setHidden:FALSE];
        }else{
            [self.nextButton setHidden:YES];
        }
    }
    
}


- (IBAction)searchByTelButtonDidPress:(id)sender {
    resultMutableArray = [NSMutableArray array];
    [resultMutableArray removeAllObjects];
    NSMutableDictionary *resultDict =  [self getTelFile];
    NSMutableString *targetString = [[NSMutableString alloc]initWithString:[NSString stringWithFormat:@"%lu",[self.targetTextField.text hash]]];
    
    
    while ([[resultDict allKeys]containsObject:targetString]) {
        _countNum = 0;
        if ([[[resultDict objectForKey:targetString]objectForKey:@"telString"] isEqualToString:self.targetTextField.text]) {
            NSDictionary *resultDic = [NSDictionary dictionaryWithObjectsAndKeys:self.targetTextField.text,@"tel",[[resultDict objectForKey:targetString]objectForKey:@"nameString"],@"name", nil];
            [resultMutableArray addObject:resultDic];
        }
        double targetNum = [targetString doubleValue];
        
        [targetString setString:[NSString stringWithFormat:@"%lu",(unsigned long)(targetNum+1)]];
    }
    if (!([resultMutableArray count] ==0)) {
        [self setBackgroundImageBlur];
        self.telTextField.text = self.targetTextField.text;
        self.nameTextField.text = [[resultMutableArray objectAtIndex:0]objectForKey:@"name"];
        self.beforeName = self.nameTextField.text;
        self.beforeTel = self.telTextField.text;
        if ([self.resultMutableArray count] > 0) {
            [self.nextButton setHidden:FALSE];
        }else{
            [self.nextButton setHidden:YES];
        }
    }
}

-(void)removeBackgroundImageBlur{
    
    UIViewPropertyAnimator *animation = [[UIViewPropertyAnimator alloc]initWithDuration:1.5 curve:UIViewAnimationCurveEaseInOut animations:^{
        //把透明度提高，最后完全透明，然后删掉
        self.blurView.alpha = 0;
    }];
    [animation startAnimation];
    
    
    //    //一行代码删除掉所有的subview挺有意思的，可惜在这里用不上
    //    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
}

- (IBAction)goBackButtonDidPress:(id)sender {
    [self removeBackgroundImageBlur];
    [self performSegueWithIdentifier:@"searchToMain" sender:self];
}

-(NSUInteger)hashWithInput:(NSString *)inputString{
    NSUInteger result = [inputString hash];
    NSLog(@"hash之后的结果是%lu ", (unsigned long)result);
    return result;
}


- (IBAction)alterButtonDidPress:(id)sender {
    
    
    //获取沙盒路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    // plist 路径
    NSString *plistPathForName = [documentsDirectory stringByAppendingPathComponent:@"contactsByName.plist"];
    NSString *plistPathForTel = [documentsDirectory stringByAppendingPathComponent:@"contactsByTel.plist"];
    
    NSFileManager *fileManager = [[NSFileManager  alloc]init];
    
    NSDictionary *contentDict = [NSDictionary dictionaryWithObjectsAndKeys:self.nameTextField.text ,@"nameString",self.telTextField.text,@"telString", nil];
    
    //hash姓名
    NSUInteger keyIntByName = [self hashWithInput:self.nameTextField.text];
    NSString *keyByName = [NSString stringWithFormat:@"%lu",keyIntByName];
    //hash电话号码
    NSUInteger keyIntByTel = [self hashWithInput:self.telTextField.text];
    NSString *keyByTel = [NSString stringWithFormat:@"%lu",keyIntByTel];
    
    
    
    //写入Name文件，同时注意碰撞
    NSMutableDictionary *contactsDictByName = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPathForName];
    
    NSMutableString *targetString = [[NSMutableString alloc]initWithString:[NSString stringWithFormat:@"%lu",[self.beforeName hash]]];
    
    
    while ([[contactsDictByName allKeys]containsObject:targetString]) {
        _countNum = 0;
        if ([[[contactsDictByName objectForKey:targetString]objectForKey:@"nameString"] isEqualToString:self.beforeName] &&[[[contactsDictByName objectForKey:targetString]objectForKey:@"telString"] isEqualToString:self.beforeTel]) {
            [contactsDictByName removeObjectForKey:targetString];

        }
        double targetNum = [targetString doubleValue];
        
        [targetString setString:[NSString stringWithFormat:@"%lu",(unsigned long)(targetNum+1)]];
    }
    [contactsDictByName setObject:contentDict forKey:keyByName];
    [contactsDictByName writeToFile:plistPathForName atomically:YES];
        
    //写入Tel文件，同时注意碰撞
    NSMutableDictionary *contactsDictByTel = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPathForTel];
    
    NSMutableString *targetStringByTel = [[NSMutableString alloc]initWithString:[NSString stringWithFormat:@"%lu",[self.beforeTel hash]]];
    
    
    while ([[contactsDictByTel allKeys]containsObject:targetStringByTel]) {
        _countNum = 0;
        if ([[[contactsDictByTel objectForKey:targetStringByTel]objectForKey:@"nameString"] isEqualToString:self.beforeName] &&[[[contactsDictByTel objectForKey:targetStringByTel]objectForKey:@"telString"] isEqualToString:self.beforeTel]) {
            [contactsDictByTel removeObjectForKey:targetStringByTel];
            
        }
        double targetNum = [targetStringByTel doubleValue];
        
        [targetStringByTel setString:[NSString stringWithFormat:@"%lu",(unsigned long)(targetNum+1)]];
    }
    [contactsDictByTel setObject:contentDict forKey:keyByTel];
    [contactsDictByTel writeToFile:plistPathForTel atomically:YES];
    
}

- (IBAction)backButtonDidpress:(id)sender {
    [self removeBackgroundImageBlur];
    [self performSegueWithIdentifier:@"searchToMain" sender:self];

}
- (IBAction)nextButtonDidPress:(id)sender {
    

    if ((([self.resultMutableArray count]-self.countNum)>1)) {
        self.nameTextField.text = [[self.resultMutableArray objectAtIndex:(_countNum+1)] objectForKey:@"name"];
        self.telTextField.text = [[self.resultMutableArray objectAtIndex:(_countNum+1)] objectForKey:@"tel"];
        self.beforeName = self.nameTextField.text;
        self.beforeTel = self.telTextField.text;
            [self.nextButton setHidden:FALSE];
    }else{
        
        [self.nextButton setHidden:YES];
    }

    self.countNum++;
}
@end

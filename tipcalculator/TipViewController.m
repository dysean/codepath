//
//  TipViewController.m
//  tipcalculator
//
//  Created by Sean Dy on 1/27/15.
//  Copyright (c) 2015 Sean Dy. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()
{
    NSUserDefaults *defaults;
}
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;



- (IBAction)onTap:(id)sender;
-(void)updateValues;

@end

@implementation TipViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self) {
        self.title = @"Tip Calculator";
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //UI Settings Button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    
    [self updateValues];
    
}
- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"view will appear");
    [self updateValues];
}

//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  //  NSString *tipArray = [defaults objectForKey:@"tipArray"];

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}
- (IBAction)textBox:(id)sender {
    [self updateValues];
}

- (void)updateValues{
    defaults = [NSUserDefaults standardUserDefaults];
    for (int i = 0; i<=2; i++) {
        @try{
            [self.tipControl setTitle:[NSString stringWithFormat:@"%00.f%%",[defaults floatForKey:[NSString stringWithFormat:@"tipValue%d",i]]*100] forSegmentAtIndex:i];
        }
        @catch (NSException *e) {
            //set default value
            if (i ==0) {
                [self.tipControl setTitle:@"10%" forSegmentAtIndex:i];
            } else if (i ==1){
                [self.tipControl setTitle:@"15%" forSegmentAtIndex:i];
            } else if (i==2){
                [self.tipControl setTitle:@"20%" forSegmentAtIndex:i];
            }
        }
    };
    float billAmount = [self.billTextField.text floatValue];
    long tipIndex = self.tipControl.selectedSegmentIndex;
    float tipValue = [defaults floatForKey:[NSString stringWithFormat:@"tipValue%ld", tipIndex]];
    float tipAmount = billAmount * tipValue;
    float totalAmount = tipAmount + billAmount;
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}
- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}
@end


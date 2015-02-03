//
//  SettingsViewController.m
//  tipcalculator
//
//  Created by Sean Dy on 1/30/15.
//  Copyright (c) 2015 Sean Dy. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
{
    NSArray *_pickerData;
    NSUserDefaults *defaults;
}

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    //initialize picker data
    _pickerData = @[@[@(0.05),@(0.06),@(0.07),@(0.08),@(0.09),@(0.10),@(0.11),@(0.12),@(0.13),@(0.14),@(0.15)],
                    @[@(0.10),@(0.11),@(0.12),@(0.13),@(0.14),@(0.15),@(0.16),@(0.17),@(0.18),@(0.19),@(0.20)],
                    @[@(0.15),@(0.16),@(0.17),@(0.18),@(0.19),@(0.20),@(0.21),@(0.22),@(0.23),@(0.24),@(0.25)]];
    
    self.picker.dataSource=self;
    self.picker.delegate=self;
    
    //load defaults
    defaults = [NSUserDefaults standardUserDefaults];
    
    NSInteger pickerRow0 = [defaults integerForKey:@"component0row"];
    NSInteger pickerRow1 = [defaults integerForKey:@"component1row"];
    NSInteger pickerRow2 = [defaults integerForKey:@"component2row"];
    
    [self.picker selectRow:pickerRow0 inComponent:0 animated:YES];
    [self.picker selectRow:pickerRow1 inComponent:1 animated:YES];
    [self.picker selectRow:pickerRow2 inComponent:2 animated:YES];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (long)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (long)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //_pickerData.count, but it returns the number of arrays
    return 11;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    float result = [_pickerData[component][row] floatValue] *100;
    return [NSString stringWithFormat:@"%00.f%%", result];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
    
    [defaults setFloat:[_pickerData[component][row] floatValue] forKey:[NSString stringWithFormat:@"tipValue%ld", component]];
    if (component == 0) {
        [defaults setInteger:row forKey:@"component0row"];
    } else if (component ==1) {
        [defaults setInteger:row forKey:@"component1row"];
    } else if (component ==2) {
        [defaults setInteger:row forKey:@"component2row"];
    }
    [defaults synchronize];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"view will appear");
}



- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"view will disappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"view did disappear");
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

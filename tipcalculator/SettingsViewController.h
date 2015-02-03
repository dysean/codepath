//
//  SettingsViewController.h
//  tipcalculator
//
//  Created by Sean Dy on 1/30/15.
//  Copyright (c) 2015 Sean Dy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *picker;

@end

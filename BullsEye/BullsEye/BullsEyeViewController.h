//
//  BullsEyeViewController.h
//  BullsEye
//
//  Created by Claus on 14-1-2.
//  Copyright (c) 2014年 self.edu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BullsEyeViewController : UIViewController<UIAlertViewDelegate>

@property(nonatomic,weak) IBOutlet UISlider *slider;
@property(nonatomic,weak) IBOutlet UILabel *targetLabel;
@property(nonatomic,weak) IBOutlet UILabel *scoreLabel;
@property(nonatomic,weak) IBOutlet UILabel *roundLabel;

- (IBAction)showAlert;
- (IBAction)sliderMoved:(UISlider *)slider;
- (IBAction)startOver;

@end

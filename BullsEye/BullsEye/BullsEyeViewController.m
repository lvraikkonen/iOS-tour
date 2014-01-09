//
//  BullsEyeViewController.m
//  BullsEye
//
//  Created by Claus on 14-1-2.
//  Copyright (c) 2014年 self.edu. All rights reserved.
//

#import "BullsEyeViewController.h"

@interface BullsEyeViewController ()

@end

@implementation BullsEyeViewController
{
    int _currentValue;
    int _targetValue;
    int _score;
    int _round;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self startNewRound];
    [self updateLabels];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self startNewRound];
    [self updateLabels];
}

- (IBAction)showAlert
{
    int difference = abs(_currentValue - _targetValue);
    int points = 100 - difference;
    NSString *title = @"";
    
    NSString *message = [NSString stringWithFormat:@"The current value is %d\nYou Score is %d",_currentValue,points];
    if (difference==0)
    {
        title=@"Perfect!";
        points+=100;
    }
    else if (difference < 5)
    {
        title=@"You almost had it!";
        points+=50;
    }
    else if (difference < 10)
    {
        title=@"Pretty good!";
    }
    else
        title=@"Not even close.";
    
    _score+=points;
    
    
    UIAlertView *alertView=[[UIAlertView alloc]
                            initWithTitle:title
                            message:message
                            delegate:self
                            cancelButtonTitle:@"Awsome"
                            otherButtonTitles:nil];
    [alertView show];
}

- (IBAction)sliderMoved:(UISlider *)slider
{
    _currentValue = lroundf(slider.value);
    //NSLog(@"the current value is %f",slider.value);
    
}

- (IBAction)startOver
{
    _score=0;
    _round=0;
    [self startNewRound];
    [self updateLabels];
}

- (void)startNewRound
{
    _currentValue = 50;
    _targetValue= 1 + arc4random_uniform(100);
    self.slider.value=_currentValue;
}

- (void)updateLabels
{
    self.targetLabel.text = [NSString stringWithFormat:@"%d",_targetValue];
    self.scoreLabel.text=[NSString stringWithFormat:@"%d",_score];
    self.roundLabel.text=[NSString stringWithFormat:@"%d",_round];
    
    _round++;
}

@end

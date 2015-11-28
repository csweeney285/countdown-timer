//
//  ViewController.h
//  countdown timer test
//
//  Created by Conor Sweeney on 11/28/15.
//  Copyright © 2015 Conor Sweeney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController
{
    long hour;
    long minute;
    long seconds;
    NSTimer *myTimer;
    NSTimer *alarmTimer;
    AVAudioPlayer *_audioPlayer;
}

@property (weak, nonatomic) IBOutlet UITextField *hourTextField;
@property (weak, nonatomic) IBOutlet UITextField *minuteTextField;
@property (weak, nonatomic) IBOutlet UITextField *secondTextField;

@property (weak, nonatomic) IBOutlet UILabel *timeLeftLabel;

@property (weak,nonatomic) NSString *timeString;


-(void)getOriginalTime;

-(void)timeTicker;

-(void)stopTimer;

- (IBAction)setTimeButton:(id)sender;

- (IBAction)pauseTimeButton:(id)sender;

- (IBAction)resetTimeButton:(id)sender;

@end


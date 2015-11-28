//
//  ViewController.m
//  countdown timer test
//
//  Created by Conor Sweeney on 11/28/15.
//  Copyright © 2015 Conor Sweeney. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *path = [NSString stringWithFormat:@"%@/Old-clock-ringing-short.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    // Create audio player object and initialize with URL to sound
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)timeTicker
{
    if (seconds != 0){
        seconds --;
    }
    else if (seconds == 0) {
        minute --;
        seconds = 59;
    }
    else if(minute == 0 && seconds == 0) {
        hour --;
        minute = 59;
        seconds = 59;
    }
    self.timeString = [NSString stringWithFormat: @"%02ld:%02ld:%02ld",hour,minute,seconds];
    self.timeLeftLabel.text = self.timeString;
    [self stopTimer];
}

-(void) soundAlarm{
    [_audioPlayer play];
}

-(void)stopTimer{
    if (hour == 0 && minute == 0 && seconds == 0) {
        [myTimer invalidate];
        myTimer = nil;
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Alarm"
                                      message:@"Press OK"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 [_audioPlayer stop];
                                 [alarmTimer invalidate];
                                 
                             }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        if (alert != nil) {
            [self soundAlarm];
            alarmTimer = [NSTimer scheduledTimerWithTimeInterval:5.0
                                                    target:self
                                                    selector:@selector(soundAlarm)
                                                    userInfo:nil
                                                    repeats:YES];
        }
    }
}
-(void)getOriginalTime
{
    hour = [self.hourTextField.text longLongValue];
    minute = [self.minuteTextField.text longLongValue];
    seconds = [self.secondTextField.text longLongValue];
}

- (IBAction)setTimeButton:(id)sender {
    [myTimer invalidate];
    NSLog(@"Set Time Button Pressed");
    [self getOriginalTime];
    self.timeString = [NSString stringWithFormat: @"%02ld:%02ld:%02ld",hour,minute,seconds];
    self.timeLeftLabel.text = self.timeString;
    NSLog(@"%@",self.timeString);
    myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(timeTicker)
                                   userInfo:nil
                                    repeats:YES];
}

- (IBAction)pauseTimeButton:(id)sender {
    if (myTimer !=nil) {
        [myTimer invalidate];
        myTimer = nil;
    }
    else{
        myTimer =[NSTimer scheduledTimerWithTimeInterval:1.0
                                    target:self
                                    selector:@selector(timeTicker)
                                    userInfo:nil
                                    repeats:YES];
    }
    
}
- (IBAction)resetTimeButton:(id)sender {
    [myTimer invalidate];
    hour = 0;
    minute = 0;
    seconds = 0;
    self.timeString = [NSString stringWithFormat: @"%02ld:%02ld:%02ld",hour,minute,seconds];
    self.timeLeftLabel.text = self.timeString;
}
@end

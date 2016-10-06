//
//  ViewController.m
//  sampleCode
//
//  Created by Kalpesh Parikh on 10/5/16.
//  Copyright © 2016 kalpesh parikh. All rights reserved.
//

#import "AnimationViewController.h"
#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

#define M_PI   3.14159265358979323846264338327950288   /* pi */


@interface AnimationViewController ()
@property (nonatomic, weak) IBOutlet UIImageView *imgApp;
@property (nonatomic, strong) AVAudioPlayer *backgroundMusicPlayer;
@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title= @"Animation";
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
    [_imgApp addGestureRecognizer:gesture];
}

- (void) handlePanGesture:(UIPanGestureRecognizer *)gesture
{
    CGPoint translation = [gesture translationInView:gesture.view];
    gesture.view.center = CGPointMake(gesture.view.center.x + translation.x, gesture.view.center.y + translation.y);
    [gesture setTranslation:CGPointZero inView:gesture.view];
    
}


-(void) startFlashing
{
    NSError *error;
    NSString *path = [NSString stringWithFormat:@"%@/animation.wav", [[NSBundle mainBundle] resourcePath]];
    NSURL *backgroundMusicURL = [NSURL fileURLWithPath:path];
    self.backgroundMusicPlayer = [[AVAudioPlayer alloc]
                                  initWithContentsOfURL:backgroundMusicURL error:&error];
    [self.backgroundMusicPlayer prepareToPlay];
    [self.backgroundMusicPlayer play];
    
    self.imgApp.alpha = 1.0f;
    [UIView animateWithDuration:0.12
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut |
     UIViewAnimationOptionRepeat |
     UIViewAnimationOptionAutoreverse |
     UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.imgApp.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         self.imgApp.alpha = 1.0f;
                     }];
}

-(void) stopFlashing
{
    
    [UIView animateWithDuration:0.12
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut |
     UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.imgApp.alpha = 1.0f;
                     }
                     completion:^(BOOL finished){
                         self.imgApp.alpha = 1.0f;
                     }];
}


- (IBAction)spinAnimationAction:(id)sender
{
    [self startFlashing];
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat: 2*M_PI];
    animation.toValue = [NSNumber numberWithFloat:0.0f];
    animation.duration = 10.0f;
    animation.speed = 3.0;
    [self.imgApp.layer addAnimation:animation forKey:@"SpinAnimation"];
    
    self.imgApp.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:3.2
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.imgApp.transform = CGAffineTransformMakeScale(2,2);
                     }
                     completion:nil];
    self.imgApp.transform = CGAffineTransformMakeScale(2,2);
    [UIView animateWithDuration:3.2
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.imgApp.transform = CGAffineTransformIdentity;
                     }
                     completion:nil];
    [self performSelector:@selector(stopFlashing) withObject:nil afterDelay:3.2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

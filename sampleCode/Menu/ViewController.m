//
//  ViewController.m
//  sampleCode
//
//  Created by Kalpesh Parikh on 10/5/16.
//  Copyright © 2016 kalpesh parikh. All rights reserved.
//

#import "ViewController.h"
#import "APIViewController.h"
#import "AnimationViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Sample code";
    // setting back item to navigation bar
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil
                                                                action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)tableAction:(id)sender
{
    APIViewController *tableSectionViewController = [[APIViewController alloc] init];
    [self.navigationController pushViewController:tableSectionViewController animated:YES];
}

- (IBAction)animationAction:(id)sender
{
    AnimationViewController *animationSectionViewController = [[AnimationViewController alloc] init];
    [self.navigationController pushViewController:animationSectionViewController animated:YES];
}
@end


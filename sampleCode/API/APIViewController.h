//
//  ViewController.h
//  sampleCode
//
//  Created by Kalpesh Parikh on 10/5/16.
//  Copyright © 2016 kalpesh parikh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APIViewController : UIViewController  <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
-(void)callSearchAPI;

@end


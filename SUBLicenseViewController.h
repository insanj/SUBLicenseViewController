//
//  SUBLicenseViewController.h
//  Submarine
//
//  Created by Julian Weiss on 8/17/15.
//  Copyright (c) 2015 insanj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SUBLicenseViewController : UITableViewController

@property (strong, nonatomic) UIFont *licenseTitleFont, *licenseBodyFont;

- (void)addLicenseWithTitle:(NSString *)title body:(NSString *)body;

// - (void)addLicenseWithTitles:(NSArray *)titles bodies:(NSString *)bodies;

@end

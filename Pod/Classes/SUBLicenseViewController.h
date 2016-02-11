//
//  SUBLicenseViewController.h
//  Submarine
//
//  Created by Julian Weiss on 8/17/15.
//  Copyright (c) 2015 insanj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <Foundation/Foundation.h>
#import "SUBLicense.h"

#define noreturn __attribute__((noreturn)) void
#define unused __attribute__((unused))

@interface SUBLicenseViewController : UITableViewController

@property (strong, nonatomic) UIFont *licenseTitleFont, *licenseBodyFont;

/* Set an image as background for the main tableview */
@property (strong, nonatomic) UIImage *backgroundImage;

/* Set background color for section's header*/
@property (strong, nonatomic) UIColor *sectionHeaderBackgroundColor;

/* Set color for section's header text */
@property (strong, nonatomic) UIColor *sectionHeaderTextColor;

/* Set color for tableviewcell text */
@property (strong, nonatomic) UIColor *cellTextColor;

/* Set background color for tableviewcell and the tableview */
// this won't make any effect if u set the backgroundImage

@property (strong, nonatomic) UIColor *backgroundColor;

- (void)addLicenseWithTitle:(NSString *)title body:(NSString *)body __attribute__((deprecated("use addLicenses: to add licenses")));
- (void)addLicenses:(NSArray *)licenses; // License object should be SUBLicense

@end

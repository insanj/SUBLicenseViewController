//
//  SUBLicense.h
//  Pods
//
//  Created by Julian Weiss on 2/11/16.
//
//

#import <Foundation/Foundation.h>

@interface SUBLicense : NSObject

@property (strong, nonatomic) NSString *licenseTitle, *licenseBody;

+ (instancetype)licenseWithTitle:(NSString *)title body:(NSString *)body;

@end

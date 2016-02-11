//
//  SUBLicense.m
//  Pods
//
//  Created by Julian Weiss on 2/11/16.
//
//

#import "SUBLicense.h"

@implementation SUBLicense

+ (instancetype)licenseWithTitle:(NSString *)title body:(NSString *)body {
    SUBLicense *license = [[SUBLicense alloc] init];
    license.licenseTitle = title;
    license.licenseBody = body;
    return license;
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[SUBLicense class]]) {
        return [((SUBLicense *)object).licenseTitle isEqualToString:_licenseTitle] &&
        [((SUBLicense *)object).licenseBody  isEqualToString:_licenseBody];
    }
    
    return NO;
}

@end

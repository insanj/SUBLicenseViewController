//
//  SUBLicenseViewController.m
//  
//
//  Created by Julian Weiss on 8/17/15.
//
//

#import "SUBLicenseViewController.h"

@interface SUBLicense : NSObject

@property (strong, nonatomic) NSString *licenseTitle, *licenseBody;

+ (instancetype)licenseWithTitle:(NSString *)title body:(NSString *)body;

@end

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

@interface SUBLicenseViewController ()

@property (strong, nonatomic) NSMutableArray *licenses, *licensesPending;

@property (nonatomic, readwrite) BOOL licensesSuccessfullyLoaded;

@end

static NSString *kSubmarineLicenseHeaderReuseIdentifier = @"SubmarineLicenseHeaderReuseIdentifier";

@implementation SUBLicenseViewController

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.title = @"Licenses";
        self.tableView.separatorColor = [UIColor colorWithWhite:0.7 alpha:0.5];
        self.tableView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1.0];
        self.tableView.rowHeight = 120;
        self.tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        
        _licenseTitleFont = [UIFont systemFontOfSize:14.0 weight:UIFontWeightBold];
        _licenseBodyFont = [UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
        
        [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:kSubmarineLicenseHeaderReuseIdentifier];
        
        _licensesPending = [NSMutableArray array];
    }
    
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSError *licensesError;
    NSString *licensesPath = [[NSBundle mainBundle] pathForResource:@"Acknowledgements" ofType:@"plist"];
    // NSString *acknowledgementsString = [NSString stringWithContentsOfFile:licensesPath encoding:NSUTF8StringEncoding error:&licensesError];
    NSData *acknowledgementsData = [NSData dataWithContentsOfFile:licensesPath];

    if (!acknowledgementsData) {
        NSLog(@"SUBLicenseViewController could not load license at path %@, error: %@", licensesPath, licensesError);
        _licenses = [NSMutableArray arrayWithObject:[SUBLicense licenseWithTitle:@"Error Loading Licenses" body:[licensesError localizedDescription]]];
    }
    
    else {
        NSPropertyListFormat acknowledgementsPlistFormat;
        NSDictionary *acknowledgementsPlist = [NSPropertyListSerialization propertyListWithData:acknowledgementsData options:NSPropertyListImmutable format:&acknowledgementsPlistFormat error:&licensesError];
        
        if (!acknowledgementsPlist) {
            NSLog(@"SUBLicenseViewController could not parse license at path %@, error: %@", licensesPath, licensesError);
            _licenses = [NSMutableArray arrayWithObject:[SUBLicense licenseWithTitle:@"Error Loading Licenses" body:[licensesError localizedDescription]]];
        }
        
        else {
            NSMutableArray *loadingLicenses = [NSMutableArray array];
            NSArray *specifiers = acknowledgementsPlist[@"PreferenceSpecifiers"];
            
            for (NSDictionary *specifier in specifiers) {
                NSString *licenseTitle = specifier[@"Title"];
                NSString *licenseBody = specifier[@"FooterText"];
                
                if (licenseTitle && licenseBody) {
                    [loadingLicenses addObject:[SUBLicense licenseWithTitle:licenseTitle body:licenseBody]];
                }
            }
            
            
            [loadingLicenses insertObjects:_licensesPending atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, _licensesPending.count)]];
            _licenses = loadingLicenses;
            _licensesSuccessfullyLoaded = YES;
        }
    }
    
    if (!_licensesSuccessfullyLoaded) {
        _licenses = _licensesPending;
    }
    
    [self.tableView reloadData];
}

#pragma mark - licenses

- (void)addLicenseWithTitle:(NSString *)title body:(NSString *)body {
    SUBLicense *license = [SUBLicense licenseWithTitle:title body:body];
    [_licensesPending addObject:license];

    if (!_licenses) {
        if (_licensesSuccessfullyLoaded) {
            _licenses = [NSMutableArray arrayWithObject:license];
        }
        
        else {
            return; // do nothing, wait until load finishes
        }
    }
    
    else {
        if (_licensesSuccessfullyLoaded) {
            [_licenses insertObject:license atIndex:_licensesPending.count]; // we like the 1 offset, normally there's "Acknowledgements"
        }
        
        else {
            [_licenses removeAllObjects];
            _licenses = _licensesPending;
        }
    }
    
    [self.tableView reloadData];
}

#pragma mark - table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return fmax(_licenses.count, 1);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _licenses && _licenses.count > 0 ? 1 : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NSString *licenseTitle;
    if (!_licenses || _licenses.count < section) {
        licenseTitle = @"Loading licenses...";
    }
    
    else {
        SUBLicense *license = _licenses[section];
        licenseTitle = license.licenseTitle;
    }
    
    return [licenseTitle boundingRectWithSize:CGSizeMake(tableView.frame.size.width - 25, INFINITY) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : _licenseTitleFont} context:nil].size.height + 10.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kSubmarineLicenseHeaderReuseIdentifier];
    static NSInteger licenseHeaderLabelTag = 5212125;
    if (![headerFooterView.contentView viewWithTag:licenseHeaderLabelTag]) {
        headerFooterView.contentView.backgroundColor = [UIColor clearColor];
        
        UILabel *headerLabel = [[UILabel alloc] init];
        headerLabel.textColor = [UIColor whiteColor];
        headerLabel.font = _licenseTitleFont;
        headerLabel.textAlignment = NSTextAlignmentLeft;
        headerLabel.numberOfLines = 0;
        headerLabel.tag = licenseHeaderLabelTag;
        headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [headerFooterView.contentView addSubview:headerLabel];
        
        [headerFooterView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[label]-10-|" options:0 metrics:nil views:@{@"label" : headerLabel}]];
        [headerFooterView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[label]-5-|" options:0 metrics:nil views:@{@"label" : headerLabel}]];
    }
    
    UILabel *headerLabel = (UILabel *)[headerFooterView.contentView viewWithTag:licenseHeaderLabelTag];
    if (!_licenses || _licenses.count < section) {
        headerLabel.text = @"Loading licenses...";
    }
    
    else {
        SUBLicense *license = _licenses[section];
        headerLabel.text = license.licenseTitle;
    }
    
    return headerFooterView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!_licenses || _licenses.count < indexPath.section) {
        return 120;
    }
    
    SUBLicense *license = _licenses[indexPath.section];
    return [license.licenseBody boundingRectWithSize:CGSizeMake(tableView.frame.size.width - 25, INFINITY) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : _licenseBodyFont} context:nil].size.height + 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *licenseCellReuseIdentifier = @"SubmarineLicenseCellReuseIdentifier";
    UITableViewCell *licenseCell = [tableView dequeueReusableCellWithIdentifier:licenseCellReuseIdentifier];
    static NSInteger licenseCellLabelTag = 716173;
    if (!licenseCell) {
        licenseCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:licenseCellReuseIdentifier];
        licenseCell.backgroundColor = [UIColor clearColor];
        
        UIView *backgroundView = [[UIView alloc] init];
        backgroundView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.1];
        licenseCell.selectedBackgroundView = backgroundView;
        
        // UITextView *licenseLabel = [[UITextView alloc] init];
        UILabel *licenseLabel = [[UILabel alloc] init];
        licenseLabel.backgroundColor = [UIColor clearColor];
        licenseLabel.textColor = [UIColor whiteColor];
        licenseLabel.tag = licenseCellLabelTag;
        licenseLabel.numberOfLines = 0;
        licenseLabel.font = _licenseBodyFont;
        licenseLabel.textAlignment = NSTextAlignmentLeft;
        licenseLabel.clipsToBounds = NO;
        licenseLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [licenseCell.contentView addSubview:licenseLabel];
        
        [licenseCell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[label]-10-|" options:0 metrics:nil views:@{@"label" : licenseLabel}]];
        [licenseCell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[label]-|" options:0 metrics:nil views:@{@"label" : licenseLabel}]];
    }
    
    UILabel *licenseLabel = (UILabel *)[licenseCell.contentView viewWithTag:licenseCellLabelTag];
    if (!_licenses || _licenses.count < indexPath.section) {
        licenseLabel.text = @"Loading licenses...";
    }
    
    else {
        SUBLicense *license = _licenses[indexPath.section];
        licenseLabel.text = license.licenseBody;
    }
    
    return licenseCell;
}

@end

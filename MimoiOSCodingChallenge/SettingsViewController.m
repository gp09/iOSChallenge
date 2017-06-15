//
//  Created by Mimohello GmbH on 16.02.17.
//  Copyright (c) 2017 Mimohello GmbH. All rights reserved.
//

#import <PureLayout/PureLayout.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "SettingsViewController.h"
#import "SettingsAvatar.h"
#import "MimoiOSCodingChallenge-Swift.h"

// NOTE: The order of these enums are essential!
typedef NS_ENUM(NSUInteger, SettingsTableSection) {
    SettingsTableSectionAuthentication = 0,
    SettingsTableSectionShare,
	SettingsTableSectionNotification,
    SettingsTableSectionPurchase,
    SettingsTableSectionContact,
};

typedef NS_ENUM(NSUInteger, SettingsTableSectionAuthenticationRow) {
    SettingsTableSectionAuthenticationRowUpgrade = 0,
    SettingsTableSectionAuthenticationRowChangePassword,
	SettingsTableSectionAuthenticationRowSetGoal,
    SettingsTableSectionAuthenticationRowLogout
};

typedef NS_ENUM(NSUInteger, SettingsTableSectionNotificationRow) {
	SettingsTableSectionNotificationRowSwitch = 0,
	SettingsTableSectionNotificationRowTime
};

typedef NS_ENUM(NSUInteger, SettingsTableSectionPurchaseRow) {
    SettingsTableSectionPurchaseRowRestore = 0,
    //SettingsTableSectionPurchaseRowVolume
};
typedef NS_ENUM(NSUInteger, SettingsTableSectionShareRow) {
    SettingsTableSectionShareRowAppStore = 0,
    SettingsTableSectionShareRowFriends,
    SettingsTableSectionShareRowTwitter,
    SettingsTableSectionShareRowFacebook
};
typedef NS_ENUM(NSUInteger, SettingsTableSectionContactRow) {
	SettingsTableSectionContactRowHelp = 0,
	SettingsTableSectionContactRowFeedback,
	SettingsTableSectionContactRowTermsAndConditions,
	SettingsTableSectionContactRowPrivacyPolicy
};

static const CGFloat kSettingsSectionHeaderHeightAuthentication = 180.0;
static const CGFloat kSettingsSectionHeaderHeightStandard       = 42.0;
static const CGFloat kSettingsStandardRowHeight                 = 48.0;
static const CGFloat kSettingsSectionFooterHeight               = 48.0;


@interface SettingsViewController () <UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property BOOL restoreInProgress;
@property BOOL alreadyShownAlert;

@property (nonatomic) NSArray<NSNumber *> *tableSections;
@property (nonatomic) NSDictionary<NSNumber *, NSString*> *tableSectionHeaderTitles;
@property (nonatomic) NSDictionary<NSNumber *, NSDictionary*> *tableSectionRowTitles;
@property (nonatomic, strong) NSDictionary<NSNumber *, NSArray*> *tableSectionCellIdentifiers;

@property (readonly) CGFloat tableSectionHeaderFontSize;
@property (readonly) CGFloat emailLabelFontSize;

@property (nonatomic, strong) UIDatePicker *timePicker;
@property (nonatomic) BOOL didSetConstraints;
@property BOOL userSubscribed;
@end

@implementation SettingsViewController

#pragma mark - UIViewController View Handling

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupTableSections];
    [self setupTableSectionHeaderTitles];
    [self setupTableSectionRowTitles];
    [self setupTableCellIdentifiers];
    [self setupTableView];
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
	
	/* Code to be added after completion of the time feature in future release. Current release 1.2.3
	self.timePicker = [[UIDatePicker alloc] init];
	self.timePicker.datePickerMode = UIDatePickerModeTime;
	self.timePicker.backgroundColor = [UIColor whiteColor];
	self.timePicker.hidden = YES;
	[self.view addSubview:self.timePicker];
	 */
	[self.view setNeedsUpdateConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.alreadyShownAlert = NO;
    self.restoreInProgress = NO;
	self.userSubscribed = NO;
	[self.tableView reloadData];
}


- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

- (void)updateViewConstraints {
	if (!self.didSetConstraints) {
		/* Code to be added after completion of the time feature in future release. Current release 1.2.3
		CGFloat tabBarHeight = 0;
		if (self.tabBarController.tabBar) {
			tabBarHeight = self.tabBarController.tabBar.bounds.size.height;
		}
		[self.timePicker autoPinEdgeToSuperviewEdge:ALEdgeLeft];
		[self.timePicker autoPinEdgeToSuperviewEdge:ALEdgeRight];
		[self.timePicker autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:tabBarHeight];
		[self.timePicker autoSetDimension:ALDimensionHeight toSize:216];
		 */
		self.didSetConstraints = YES;
	}
	[super updateViewConstraints];
}

#pragma mark - Setup TableView

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor grayColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];

    NSDictionary *views = @{ @"tableView": self.tableView };
    NSDictionary *metrics = @{};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:metrics views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:metrics views:views]];
	
	[self.tableView registerClass:[SettingsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([SettingsTableViewCell class])];
}

- (void)setupTableSections {
    self.tableSections = @[
        @(SettingsTableSectionAuthentication),
		@(SettingsTableSectionShare),
		@(SettingsTableSectionNotification),
        @(SettingsTableSectionPurchase),
        @(SettingsTableSectionContact),
    ];
}

- (void)setupTableSectionHeaderTitles {
    self.tableSectionHeaderTitles = @{
        @(SettingsTableSectionAuthentication):  NSLocalizedString(@"Account", @"Table Section Header"),
		@(SettingsTableSectionShare):           NSLocalizedString(@"Share", @"Table Section Header"),
		@(SettingsTableSectionNotification):	NSLocalizedString(@"Dark Mode", @"Table Section Header"),
        @(SettingsTableSectionPurchase):        NSLocalizedString(@"Purchase", @"Table Section Header"),
        @(SettingsTableSectionContact):         NSLocalizedString(@"Contact", @"Table Section Header"),
    };
}

- (void)setupTableSectionRowTitles {
	NSMutableDictionary *rowTitles = [[NSMutableDictionary alloc] init];
	NSString *upgradeTitle;
	upgradeTitle = NSLocalizedString(@"DownloadMimo", nil);
	
	rowTitles[@(SettingsTableSectionAuthentication)] = @{@(SettingsTableSectionAuthenticationRowUpgrade): upgradeTitle,
														 @(SettingsTableSectionAuthenticationRowChangePassword): NSLocalizedString(@"ChangePassword", @"Table Section Row Title"),
														 @(SettingsTableSectionAuthenticationRowSetGoal): NSLocalizedString(@"SetGoal", @"Table Section Row Title"),
														 @(SettingsTableSectionAuthenticationRowLogout): NSLocalizedString(@"Logout", @"Table Section Row Title")};
	
	rowTitles[@(SettingsTableSectionNotification)] = @{@(SettingsTableSectionNotificationRowSwitch): NSLocalizedString(@"DarkMode", @"Table Section Row Title")};
	/* Code to be added after completion of the time feature in future release. Current release 1.2.3
	 @(SettingsTableSectionNotificationRowTime): NSLocalizedString(@"ReminderTime", @"Table Section Row Title"),
	 };
	 */
	rowTitles[@(SettingsTableSectionShare)] = @{@(SettingsTableSectionShareRowAppStore): NSLocalizedString(@"Rate us on the App Store", @"Table Section Row Title"),
												@(SettingsTableSectionShareRowFriends): NSLocalizedString(@"Share With Friends", @"Table Section Row Title"),
												@(SettingsTableSectionShareRowTwitter): NSLocalizedString(@"Follow us on Twitter", @"Table Section Row Title"),
												@(SettingsTableSectionShareRowFacebook): NSLocalizedString(@"Like us on Facebook", @"Table Section Row Title")};
	
	rowTitles[@(SettingsTableSectionPurchase)] = @{@(SettingsTableSectionPurchaseRowRestore): NSLocalizedString(@"Restore your purchases", @"Table Section Row Title")};
	
	rowTitles[@(SettingsTableSectionContact)] = @{@(SettingsTableSectionContactRowHelp) : NSLocalizedString(@"Help", @"Table Section Row Title"),
												  @(SettingsTableSectionContactRowFeedback) : NSLocalizedString(@"Feedback", @"Table Section Row Title"),
												  @(SettingsTableSectionContactRowTermsAndConditions) : NSLocalizedString(@"TermsAndConditions", nil),
												  @(SettingsTableSectionContactRowPrivacyPolicy) : NSLocalizedString(@"PrivacyPolicy", nil)};
	self.tableSectionRowTitles = rowTitles;
}

- (void)setupTableCellIdentifiers {
    NSMutableDictionary *rows = [NSMutableDictionary new];
    NSString *standardTableViewCellIdentifier = NSStringFromClass([SettingsTableViewCell class]);
    
    rows[@(SettingsTableSectionAuthentication)] = @[
        standardTableViewCellIdentifier,
        standardTableViewCellIdentifier,
        standardTableViewCellIdentifier,
		standardTableViewCellIdentifier
    ];
	rows[@(SettingsTableSectionShare)] = @[standardTableViewCellIdentifier,
										   standardTableViewCellIdentifier,
										   standardTableViewCellIdentifier,
										   standardTableViewCellIdentifier
										   ];
	rows[@(SettingsTableSectionNotification)] = @[standardTableViewCellIdentifier];
    rows[@(SettingsTableSectionPurchase)] = @[
        //standardTableViewCellIdentifier, Code to be added after completion of the time feature in future release. Current release 1.2.3
        standardTableViewCellIdentifier
    ];
	rows[@(SettingsTableSectionContact)] = @[standardTableViewCellIdentifier, standardTableViewCellIdentifier, standardTableViewCellIdentifier, standardTableViewCellIdentifier];
    self.tableSectionCellIdentifiers = rows;
}

#pragma mark - Custom Accessors

- (CGFloat)tableSectionHeaderFontSize {
    return 10.5;
}

- (CGFloat)emailLabelFontSize {
    return 14.0;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: this is just too complicated and - we ne
    if (indexPath.section == SettingsTableSectionAuthentication && indexPath.row == SettingsTableSectionAuthenticationRowUpgrade && self.userSubscribed) {
        return 0.f;
    } else if (indexPath.section == SettingsTableSectionShare && indexPath.row == SettingsTableSectionShareRowAppStore && !self.userSubscribed) {
        return 0.f;
    }
        
    return kSettingsStandardRowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return (section == SettingsTableSectionAuthentication) ? kSettingsSectionHeaderHeightAuthentication : kSettingsSectionHeaderHeightStandard;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // Note: Never(!) use 0.0 here. It won't work.
    return (section == [self numberOfSectionsInTableView:self.tableView] - 1) ? kSettingsSectionFooterHeight : CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    
    if (section == SettingsTableSectionAuthentication) {
		SettingsAvatar *avatar;
#if defined(TARGET_MIMO)
		avatar = [[GMISettingsAvatar alloc] initWithPremium:self.userSubscribed];
#else
		avatar = [[SettingsAvatar alloc] init];
#endif
		
        [headerView addSubview:avatar];
        
        NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:avatar attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:headerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f];
        [headerView addConstraint:centerX];
        NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:avatar attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:headerView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-16.f];
        [headerView addConstraint:centerY];
        
        UILabel *emailLabel = [[UILabel alloc] init];
        emailLabel.translatesAutoresizingMaskIntoConstraints = NO;
        emailLabel.font = [UIFont systemFontOfSize:self.emailLabelFontSize];
        emailLabel.text = @"you@getmimo.com";
        emailLabel.textColor = [UIColor grayColor];
        [headerView addSubview:emailLabel];
        
        centerX = [NSLayoutConstraint constraintWithItem:emailLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:headerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f];
        [headerView addConstraint:centerX];
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:emailLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:avatar attribute:NSLayoutAttributeBottom multiplier:1.0 constant:8.f];
        [headerView addConstraint:top];
    }
	
    CGFloat labelLeftMargin = 16.0;
    CGFloat labelBottomMargin = 6.0;

    UILabel *sectionLabel = [[UILabel alloc] init];
    sectionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    sectionLabel.font = [UIFont systemFontOfSize:self.tableSectionHeaderFontSize];
    sectionLabel.text = self.tableSectionHeaderTitles[@(section)].uppercaseString;
    sectionLabel.textColor = [UIColor lightGrayColor];
    [headerView addSubview:sectionLabel];
    
    NSDictionary *views = @{ @"sectionLabel": sectionLabel };
    NSDictionary *metrics = @{
        @"labelLeftMargin": @(labelLeftMargin),
        @"labelBottomMargin": @(labelBottomMargin)
    };
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(labelLeftMargin)-[sectionLabel]" options:0 metrics:metrics views:views]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[sectionLabel]-(labelBottomMargin)-|" options:0 metrics:metrics views:views]];
    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section != [self numberOfSectionsInTableView:self.tableView] - 1) return nil;
    
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor clearColor];
    
    UILabel *versionLabel = [[UILabel alloc] init];
    versionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    versionLabel.font = [UIFont systemFontOfSize:10.0];
    versionLabel.textColor = [UIColor lightGrayColor];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.text = @"Version 1.0";
    
    UILabel *copyrightLabel = [[UILabel alloc] init];
    copyrightLabel.translatesAutoresizingMaskIntoConstraints = NO;
	copyrightLabel.font = [UIFont systemFontOfSize:10.0];
    copyrightLabel.textColor = [UIColor lightGrayColor];
    copyrightLabel.textAlignment = NSTextAlignmentCenter;
    copyrightLabel.text = @"Mimo loves you!";
    
    [footerView addSubview:versionLabel];
    [footerView addSubview:copyrightLabel];
    
    NSDictionary *views = @{
        @"versionLabel": versionLabel,
        @"copyrightLabel": copyrightLabel
    };
    NSDictionary *metrics = @{
        @"topMargin": @(8),
        @"labelPadding": @(4)
    };
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[versionLabel]-|" options:0 metrics:metrics views:views]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[copyrightLabel]-|" options:0 metrics:metrics views:views]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(topMargin)-[versionLabel]-(labelPadding)-[copyrightLabel]" options:0 metrics:metrics views:views]];
    
    return footerView;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)configureCell forRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingsTableViewCell *cell = (SettingsTableViewCell *)configureCell;
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.activityIndicator.hidden = YES;

	cell.secondaryLabel.hidden = YES;
	cell.selectionSwitch.hidden = YES;
	if (indexPath.section == SettingsTableSectionNotification) {
		
		if (indexPath.row == SettingsTableSectionNotificationRowSwitch) {
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.selectionSwitch.hidden = NO;
			BOOL switchOn = NO;
			
			[cell.selectionSwitch setOn:switchOn animated:NO];
			cell.delegate = self;
		} else if (indexPath.row == SettingsTableSectionNotificationRowTime) {
			cell.secondaryLabel.hidden = NO;
		}
	}
    
    cell.label.text = self.tableSectionRowTitles[@(indexPath.section)][@(indexPath.row)];
    if (indexPath.section == SettingsTableSectionAuthentication && indexPath.row == SettingsTableSectionAuthenticationRowUpgrade) {
        // hide UPGRADE if user is already a subscriber
        if (self.userSubscribed) {
            cell.label.hidden = YES;
        } else {
#if !TARGET_MIMO
	cell.label.text = NSLocalizedString(@"DownloadMimo", nil);
#endif
            cell.label.textColor = [UIColor greenColor];
            cell.label.hidden = NO;
        }
    } else if (indexPath.section == SettingsTableSectionShare && indexPath.row == SettingsTableSectionShareRowAppStore) {
        // hide  RATE US ON THE APP STORE if user is NOT a subscriber
        if (self.userSubscribed) {
            cell.label.textColor = [UIColor greenColor];
            cell.label.hidden = NO;
        } else {
            cell.label.hidden = YES;
        }
    } else {
        cell.label.textColor = [UIColor grayColor];
        cell.label.hidden = NO;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingsTableViewCell *cell = (SettingsTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    switch (indexPath.section) {
        case SettingsTableSectionAuthentication:
            switch (indexPath.row) {
                case SettingsTableSectionAuthenticationRowUpgrade:
                    [self upgrade];
                    break;
                case SettingsTableSectionAuthenticationRowChangePassword:
                    [self changePassword];
                    break;
				case SettingsTableSectionAuthenticationRowSetGoal:
					[self setGoal];
					break;
                case SettingsTableSectionAuthenticationRowLogout:
                    [self logout];
                    break;
            }
            break;
		/* Code to be added after completion of the time feature in future release. Current release 1.2.3
		case SettingsTableSectionNotification: {
			switch (indexPath.row) {
				case SettingsTableSectionNotificationRowTime:
					[self toggleTimePickerView];
					break;
				default:
					break;
			}
		}
			break;
			 */
			
        case SettingsTableSectionPurchase:
            switch (indexPath.row) {
                case SettingsTableSectionPurchaseRowRestore:
                    [self restoreWithCell:cell];
                    break;
                //case SettingsTableSectionPurchaseRowVolume:
				//  [self volumePurchase];
				//  break;
            }
            break;
        case SettingsTableSectionShare: {
            switch (indexPath.row) {
                case SettingsTableSectionShareRowAppStore:
                    break;
                case SettingsTableSectionShareRowFriends:
                    [self sharePopoverForView:cell.label];
                    break;
                case SettingsTableSectionShareRowTwitter:
                    break;
                case SettingsTableSectionShareRowFacebook:
                    break;
            }
            break;
        }
        case SettingsTableSectionContact:
            switch (indexPath.row) {
                case SettingsTableSectionContactRowHelp:
                    [self requestHelp];
                    break;
                case SettingsTableSectionContactRowFeedback:
                    [self sendFeedback];
                    break;
				case SettingsTableSectionContactRowTermsAndConditions:
					[self openTermsAndConditions];
					break;
				case SettingsTableSectionContactRowPrivacyPolicy:
					[self openPrivacyPolicy];
					break;
					default:
					break;
            }
            break;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tableSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableSectionCellIdentifiers[@(section)].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *identifiers = self.tableSectionCellIdentifiers[@(indexPath.section)];
    return [tableView dequeueReusableCellWithIdentifier:identifiers[indexPath.row] forIndexPath:indexPath];
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    if (result == MFMailComposeResultSent) {
        //mail sent
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Notifications
- (void)handlePurchasesRestoreFinishedNotification:(NSNotification *)notification {
    // TODO: handle notification, but do we need it here? we use a block for restore callback
}

- (void)handlePurchasesRestoreSuccessNotification:(NSNotification *)notification {
    if (self.alreadyShownAlert == NO) {
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"Button Title") style:UIAlertActionStyleDefault handler:nil];
        
        self.alreadyShownAlert = YES;
        self.restoreInProgress = NO;
        
        [self.tableView reloadData];
    }
}

- (void)handlePurchasesRestoreFailureNotification:(NSNotification *)notification {
    if (self.alreadyShownAlert == NO) {
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"Button Title") style:UIAlertActionStyleDefault handler:nil];
        
        self.alreadyShownAlert = YES;
        self.restoreInProgress = NO;
        
        [self.tableView reloadData];
    }
}

- (void)handleLoginNotification:(NSNotification *)notification {
	[self.tableView reloadData];
}

#pragma mark - Helper

- (void)upgrade {
#if defined(TARGET_MIMO)

#else
	[self downloadMimo];
#endif
}

- (void)downloadMimo {
	
}

- (void)changePassword {
    // TODO: don't use strings -> save URL constants somewhere every class has access
	[[UIApplication sharedApplication] openURL:[[NSURL URLWithString:@"https://app.getmimo.com"] URLByAppendingPathComponent:@"forgot_password"] options:@{} completionHandler:nil];
}

- (void)logout {

}

- (void)restoreWithCell:(SettingsTableViewCell *)cell {
    if (self.restoreInProgress == NO) {
        cell.activityIndicator.hidden = NO;
        [cell.activityIndicator startAnimating];
        
        self.alreadyShownAlert = NO;
        self.restoreInProgress = YES;
        void (^completionBlock)() = ^void() {
            dispatch_async(dispatch_get_main_queue(), ^{
                [cell.activityIndicator stopAnimating];
                cell.activityIndicator.hidden = YES;
            });
        };
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // TODO: add alert for user
            dispatch_async(dispatch_get_main_queue(), ^{
				
			});
        });
    }
}

- (void)setGoal {

}

- (void)volumePurchase {

}

- (void)sharePopoverForView:(__kindof UIView *)view {
    NSArray *dataToShare = @[@"Share me!"];
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:dataToShare applicationActivities:nil];
	
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        activityViewController.popoverPresentationController.sourceView = view;
        activityViewController.popoverPresentationController.sourceRect = CGRectMake(CGRectGetMaxX(view.frame), CGRectGetMinY(view.frame)/2, 1, 1);
    }
    
    [self presentViewController:activityViewController animated:YES completion:^{}];
}

- (void)sendFeedback {

}

- (void)requestHelp {

}

- (void)openPrivacyPolicy {
	NSURL *url = [NSURL URLWithString:@"https://getmimo.com/privacy/#privacy-policy"];
	[[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}

- (void)openTermsAndConditions {
	NSURL *url = [NSURL URLWithString:@"https://getmimo.com/privacy/#terms-of-use"];
	[[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}

- (void)toggleTimePickerView {
	self.timePicker.hidden = !self.timePicker.hidden;
}

#pragma mark - Cleanup

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

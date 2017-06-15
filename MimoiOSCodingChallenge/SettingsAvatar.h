//
//  Created by Mimohello GmbH on 16.02.17.
//  Copyright (c) 2017 Mimohello GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsAvatar : UIView
- (instancetype)initWithPremium:(BOOL)premium;
- (void)updatePremium:(BOOL)premium;
@end

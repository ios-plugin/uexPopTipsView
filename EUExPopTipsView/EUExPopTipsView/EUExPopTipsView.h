//
//  EUExPopTipsView.h
//  EUExPopTipsView
//
//  Created by zhijian du on 15/1/26.
//  Copyright (c) 2015年 zhijian du. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EUExBase.h"
#import "MenuPopOverView.h"
@interface EUExPopTipsView : EUExBase<MenuPopOverViewDelegate>

@property(nonatomic , retain) MenuPopOverView *popOver;

@end

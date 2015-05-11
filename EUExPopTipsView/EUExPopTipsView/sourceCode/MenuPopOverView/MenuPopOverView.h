//
//  MenuPopOverView.h
//  SearchBar
//
//  Created by Camel Yang on 4/1/14.
//  Copyright (c) 2014 camelcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuPopOverView;

@protocol MenuPopOverViewDelegate <NSObject>
@optional
- (void)popoverView:(MenuPopOverView *)popoverView didSelectItemAtIndex:(NSInteger)index;
- (void)popoverViewDidDismiss:(MenuPopOverView *)popoverView;

@end

@interface MenuPopOverView : UIView

@property (nonatomic, retain) UIColor *popOverBackgroundColor;
@property (nonatomic, retain) UIColor *popOverHighlightedColor;
@property (nonatomic, retain) UIColor *popOverSelectedColor;
@property (nonatomic, retain) UIColor *popOverDividerColor;
@property (nonatomic, retain) UIColor *popOverBorderColor;
@property (nonatomic, retain) UIColor *popOverTextColor;
@property (nonatomic, retain) UIColor *popOverHighlightedTextColor;
@property (nonatomic, retain) UIColor *popOverSelectedTextColor;

@property (weak, nonatomic) id<MenuPopOverViewDelegate> delegate;

- (void)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view withStrings:(NSArray *)stringArray;
- (void)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view withStrings:(NSArray *)stringArray selectedIndex:(NSInteger)selectedIndex;

@end

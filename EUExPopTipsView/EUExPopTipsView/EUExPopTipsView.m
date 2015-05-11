//
//  EUExPopTipsView.m
//  EUExPopTipsView
//
//  Created by zhijian du on 15/1/26.
//  Copyright (c) 2015年 zhijian du. All rights reserved.
//

#import "EUExPopTipsView.h"
#import "EUtility.h"
#import "JSON.h"


@implementation EUExPopTipsView
{
    
}
-(id)initWithBrwView:(EBrowserView *)eInBrwView{
    self = [super initWithBrwView:eInBrwView];
    if (self) {
        
    }
    return self;
}

-(void)open:(NSMutableArray *)inArguments{
    NSDictionary *dict = nil;
    NSInteger centerX ,centerY ,textSize;
    NSString *bgColor = nil;
    NSString *textNColor = nil;
    NSString *textHColor = nil;
    NSString *dividerColor = nil;
    NSArray *labelsArray = nil ;
    if (inArguments.count > 0 && [[inArguments objectAtIndex:0] JSONValue] ) {
        dict = [[inArguments objectAtIndex:0] JSONValue] ;
        centerX = [[dict objectForKey:@"centerX"] integerValue];
        centerY = [[dict objectForKey:@"centerY"] integerValue];
        textSize = [[dict objectForKey:@"textSize"] floatValue];
        bgColor = [dict objectForKey:@"bgColor"];
        textNColor = [dict objectForKey:@"textNColor"];
        textHColor = [dict objectForKey:@"textHColor"];
        dividerColor =[dict objectForKey:@"dividerColor"];
        labelsArray = [dict objectForKey:@"labels"];
    }else {//设置默认数据
        centerX = 150;
        centerY = 200;
        textSize = 15;
        bgColor = @"#90000000";
        textNColor = @"#ffffff";
        textHColor = @"#0000C6";
        dividerColor = @"#636363";
        labelsArray = [NSArray arrayWithObjects:@"复制",@"粘贴",@"删除", nil];
    }
    
    CGPoint point =CGPointMake(centerX, centerY);
    MenuPopOverView *popOver = [[MenuPopOverView alloc] init];
    self.popOver = popOver;
    [popOver release];
    self.popOver.delegate = self;
    [self.popOver presentPopoverFromRect:CGRectMake(point.x, point.y, 0, 0) inView:(UIView*)self.meBrwView withStrings:labelsArray];
//    self.popOver.popOverBackgroundColor = [self getColor:bgColor];
//    self.popOver.popOverDividerColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    self.popOver.popOverTextColor = [self getColor:textNColor];
    self.popOver.popOverHighlightedTextColor = [self getColor:textHColor];
    self.popOver.popOverSelectedColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.popOver.popOverHighlightedColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.popOver.popOverHighlightedColor = [UIColor colorWithRed:169/255.0 green:169/255.0 blue:169/255.0 alpha:0.9];
    self.popOver.popOverSelectedColor = [UIColor colorWithRed:169/255.0 green:169/255.0 blue:169/255.0 alpha:0.9];
    
}


-(void)close:(NSMutableArray *)inArguments{
    if (self.popOver) {
        self.popOver.delegate = nil;
        self.popOver = nil;
    }
}

-(void)clean{
    if (self.popOver) {
        self.popOver.delegate = nil;
        self.popOver = nil;
    }
}

-(void)dealloc{
    if (self.popOver) {
        self.popOver.delegate = nil;
        self.popOver = nil;
    }
    [super dealloc];
}



-(UIImage *)getImageFromLocalFile:(NSString*)imageName{
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:@"png"]];
}
#pragma mark
/**
 *  十六进制字符串转化颜色
 *
 *  @param hexColor 十六进制颜色字符串
 *
 *  @return UIColor
 */
-(UIColor *) getColor:(NSString *)hexColor
{
    //把传进来的16进制的字符串转化为RGBA格式的颜色
    unsigned int red , green ,blue , alpha ;
    NSRange range;
    
    if (hexColor.length >7) {
        
        range.length = 2;
        range.location = 1;
        
        [[NSScanner scannerWithString:[hexColor substringWithRange:range] ] scanHexInt:&alpha];
        range.location =3;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
        range.location =5;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
        range.location =7;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    }else{
        
        range.length = 2;
        range.location = 1;
        
        [[NSScanner scannerWithString:[hexColor substringWithRange:range] ] scanHexInt:&red];
        range.location =3;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
        range.location =5;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
        
        alpha =255.0;
    }
    
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green/255.0f)blue:(float)(blue/255.0f)alpha:(float)(alpha/255.0f)];
}

#pragma mark MenuPopOverViewDelegate
- (void)popoverView:(MenuPopOverView *)popoverView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"select at %ld", (long)index);
    [super jsSuccessWithName:@"uexPopTipsView.onItemSelected" opId:0 dataType:0 strData:[NSString stringWithFormat:@"%d",index]];
}

- (void)popoverViewDidDismiss:(MenuPopOverView *)popoverView {
    NSLog(@"popOver dismissed.");
}

@end

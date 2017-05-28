//
//  UIBarButtonItem+Associated.m
//  SNde
//
//  Created by SNde on 16/1/13.
//  Copyright © 2016年 SNde. All rights reserved.
//

#import "UIBarButtonItem+Associated.h"
#import <objc/runtime.h>
static const void *kBlock = &kBlock;
static const void *kButtonTitle = &kButtonTitle;
static const void *kButtonTitleColor = &kButtonTitleColor;
static const void *kButtonImage = &kButtonImage;


@implementation UIBarButtonItem (Associated)
@dynamic block;



+(instancetype)barButtonItemAction:(ItemBlock)actionBlock
{
    return [UIBarButtonItem barButtonItemWithTitle:nil action:actionBlock];
}

+(instancetype)barButtonItemWithImage:(UIImage *)image action:(ItemBlock)actionBlock
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]init];

    UIButton *customView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [customView setImage:image forState:UIControlStateNormal];
    [customView setImage:image forState:UIControlStateSelected];
    [customView addTarget:item action:@selector(itemAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    item.customView = customView;
    item.block = actionBlock;
    item.target = self;
//    item.target = item;
//    item.action = @selector(itemAction:);
//    item.style = UIBarButtonItemStylePlain;
//    item.image = image;
    return item;
}

+(instancetype)barButtonItemWithTitle:(NSString *)title action:(ItemBlock)actionBlock
{
    UIFont *font = UIFontello(20);

    UIBarButtonItem *item = [[UIBarButtonItem alloc]init];
    
    UIButton *customView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [customView setTitle:title forState:UIControlStateNormal];
    [customView setTitle:title forState:UIControlStateSelected];
    [customView.titleLabel setFont:font];
    [customView addTarget:item action:@selector(itemAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    item.customView = customView;
    item.buttonTitleColor = mainFontColor;
    item.block = actionBlock;
    item.target = self;
    return item;
}

-(void)itemAction:(UIButton *)itemButton {
    if (self.block) {
        self.block();
    }
}

#pragma mark - buttonImage get / set
-(UIImage*)buttonImage {
    return objc_getAssociatedObject(self, kButtonImage);
}

-(void)setButtonImage:(UIImage *)buttonImage {
    UIButton *customView = self.customView;
    customView.frame =CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    [customView setImage:buttonImage forState:UIControlStateNormal];
    [customView setImage:buttonImage forState:UIControlStateSelected];
    objc_setAssociatedObject(self, kButtonImage, buttonImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - block get / set
- (ItemBlock)block {
    return objc_getAssociatedObject(self, kBlock);
}

- (void)setBlock:(ItemBlock)block {
    objc_setAssociatedObject(self, kBlock, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark - buttonTitleColor get / set
-(UIColor *)buttonTitleColor {
    return objc_getAssociatedObject(self, kButtonTitleColor);
}

-(void)setButtonTitleColor:(UIColor *)buttonTitleColor {
    objc_setAssociatedObject(self, kButtonTitleColor, buttonTitleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([self.customView isKindOfClass:[UIButton class]]) {
        UIButton *customView =  self.customView;
        [customView setTitleColor:buttonTitleColor forState:UIControlStateNormal];
        [customView setTitleColor:buttonTitleColor forState:UIControlStateSelected];
    }
}

#pragma mark - buttonTitle get / set
-(NSString *)buttonTitle {
    return objc_getAssociatedObject(self, kButtonTitle);
}

-(void)setButtonTitle:(NSString *)buttonTitle {
    objc_setAssociatedObject(self, kButtonTitle, buttonTitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([self.customView isKindOfClass:[UIButton class]]) {
        UIButton *customView =  self.customView;
        [customView setTitle:buttonTitle forState:UIControlStateNormal];
        [customView setTitle:buttonTitle forState:UIControlStateSelected];
    }
}



@end

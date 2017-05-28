//
//  UIBarButtonItem+Associated.h
//  SNde
//
//  Created by SNde on 16/1/13.
//  Copyright © 2016年 SNde. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ItemBlock)(void);

@interface UIBarButtonItem (Associated)

@property (nonatomic, copy  ) ItemBlock block;
@property (nonatomic, copy  ) NSString *buttonTitle;
@property (nonatomic, strong) UIColor  *buttonTitleColor;
@property (nonatomic, strong) UIImage  *buttonImage;

+(instancetype)barButtonItemAction:(ItemBlock)actionBlock;
+(instancetype)barButtonItemWithImage:(UIImage *)image action:(ItemBlock)actionBlock;
+(instancetype)barButtonItemWithTitle:(NSString *)title action:(ItemBlock)actionBlock;

@end

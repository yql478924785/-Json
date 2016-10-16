//
//  YQLNewsModel.h
//  jsonDemo
//
//  Created by apple on 2016/10/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YQLNewsModel : NSObject

@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *summary;
@property(nonatomic,copy) NSString *img;
@property(nonatomic,copy) NSString *sitename;
@property(nonatomic,copy) NSNumber *addtime;

@end

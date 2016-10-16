//
//  YQLNewsCell.m
//  jsonDemo
//
//  Created by apple on 2016/10/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YQLNewsCell.h"
#import "UIImageView+WebCache.h"
#import "YQLNewsModel.h"
@interface YQLNewsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageIcon;

@property (weak, nonatomic) IBOutlet UILabel *lableTitle;

@property (weak, nonatomic) IBOutlet UILabel *lableDesc;

@property (weak, nonatomic) IBOutlet UILabel *lableSetName;

@property (weak, nonatomic) IBOutlet UILabel *lableAddTime;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLine;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descLine;


@end

@implementation YQLNewsCell

- (void)setModel:(YQLNewsModel *)model{
    
    _model = model;
    [_imageIcon sd_setImageWithURL:[NSURL URLWithString:model.img]];
    _lableTitle.text = model.title;
    _lableDesc.text = model.summary;
    _lableSetName.text = model.sitename;
    _lableAddTime.text = [NSString stringWithFormat:@"%zd",model.addtime];
    
//    if ([model.img isEqualToString:@""]) {
//        self.titleLine.constant = -10;
//        self.descLine.constant = -10;
//    }
//    else{
//        self.titleLine.constant = -151;
//        self.descLine.constant = -151;
//    }

}

- (void)layoutSubviews{
    [super layoutSubviews];
    //获取控件每行显示的长度
    CGFloat lableTitleWidth = self.lableTitle.bounds.size.width;
    
    //获取文字的总长度
    CGFloat textWidth = [self.lableTitle.text sizeWithAttributes:@{NSFontAttributeName:self.lableTitle.font}].width;
    
    if (textWidth > lableTitleWidth * 2 ) {
        self.lableDesc.hidden = YES;
    }else{
        self.lableDesc.hidden = NO;
    }

}




@end

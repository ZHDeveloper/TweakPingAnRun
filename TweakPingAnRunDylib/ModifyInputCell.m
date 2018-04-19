//
//  ModifyInputCell.m
//  OC-Test
//
//  Created by ZhiHua Shen on 2018/4/8.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "ModifyInputCell.h"
#import "NSDate+Extension.h"

@implementation ModifyInputCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.nameLabel = [UILabel new];
        self.inputText = [UITextField new];
        
        self.inputText.keyboardType = UIKeyboardTypeNumberPad;
        self.inputText.font = [UIFont systemFontOfSize:15];
        
        UIView *contentView = [self contentView];
        
        [contentView addSubview:self.nameLabel];
        [contentView addSubview:self.inputText];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.nameLabel sizeToFit];
    
    self.nameLabel.frame = CGRectMake(15, 0, self.nameLabel.frame.size.width, self.frame.size.height);
    
    CGFloat inputX = 15+self.nameLabel.frame.size.width+4;
    CGFloat inputW = self.frame.size.width - inputX;
    
    self.inputText.frame = CGRectMake(inputX, 0, inputW, self.frame.size.height);
}

- (void)setIdxPath:(NSIndexPath *)idxPath {
    _idxPath = idxPath;
    if (idxPath.row == 0) {
        self.nameLabel.text = @"步数:";
        long count = [[NSUserDefaults standardUserDefaults] integerForKey:@"stepCount"];
        if (![NSDate isModifyDateToday] || count == 0) {
            self.inputText.text = nil;
            self.inputText.placeholder = @"默认是0;";
        }
        else {
            self.inputText.text = [NSString stringWithFormat:@"%ld",count];
        }
    }
    else if (idxPath.row == 1) {
        self.nameLabel.text = @"心率:";
        long rate = [[NSUserDefaults standardUserDefaults] integerForKey:@"heartRate"];
        if (![NSDate isModifyDateToday] || rate == 0) {
            self.inputText.text = nil;
            self.inputText.placeholder = @"默认是0;";
        }
        else {
            self.inputText.text = [NSString stringWithFormat:@"%ld",rate];
        }
    }
}

@end


//
//  TableViewCell.m
//  demo
//
//  Created by 薛晓林 on 16/9/18.
//  Copyright © 2016年 薛晓林. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

@end

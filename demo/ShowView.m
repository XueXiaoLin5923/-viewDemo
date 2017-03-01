//
//  ShowView.m
//  demo
//
//  Created by 薛晓林 on 16/9/18.
//  Copyright © 2016年 薛晓林. All rights reserved.
//

#import "ShowView.h"
#import "TableViewCell.h"
@implementation ShowView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blueColor];
        [self creaateUI];
    }
    return self;
}

- (void)creaateUI
{
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, XLPXCAL(59), XLWidth, 1)];
    lineView.backgroundColor = MYLINECOLOR;
    [self addSubview:lineView];
    
    for (int i = 0; i < 3; i++) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(XLWidth / 2 - XLPXCAL(52) / 2, XLPXCAL(18) + XLPXCAL(12) * i, XLPXCAL(52), XLPXCAL(3))];
        line.backgroundColor = MYLINECOLOR;
        [self addSubview:line];
    }
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,XLPXCAL(60), XLWidth, CGRectGetHeight(self.frame) - XLPXCAL(60)) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor purpleColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"AppointmentShopCell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return XLPXCAL(300);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return XLPXCAL(30);
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    self.tableView.frame = CGRectMake(0, 30, self.frame.size.width, self.frame.size.height - 30);
    
}

@end

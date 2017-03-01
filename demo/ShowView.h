//
//  ShowView.h
//  demo
//
//  Created by 薛晓林 on 16/9/18.
//  Copyright © 2016年 薛晓林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowView : UIView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end

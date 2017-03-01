//
//  ViewController.m
//  demo
//
//  Created by 薛晓林 on 16/9/18.
//  Copyright © 2016年 薛晓林. All rights reserved.
//

#import "ViewController.h"
#import "ShowView.h"

CGFloat const gestureMinimumTranslation = 00.0 ;

typedef enum : NSInteger {
    
    kNone,
    
    kTop = 1,
    
    kMiddle,
    
    kDown,
    
    kMax
    
    
} kShowViewStatus;

typedef enum : NSUInteger {
    kMotionDirectionTypeNone,
    kMotionDirectionTypeUp,
    kMotionDirectionTypeDown,
} MotionDirectionType;

@interface ViewController ()
{
    kShowViewStatus      showStatus;//移动View的移动状态
    MotionDirectionType  _directionType;//移动方向
    BOOL                 _flag;//记录移动方向标记
    
}

@property(nonatomic , strong)UIScrollView *scrollView;

@property(nonatomic , strong)UITableView *tableView;

@property(nonatomic , strong)ShowView *show;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _flag = NO;
    _directionType = kMotionDirectionTypeNone;
    showStatus = kMiddle;
    
    
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor orangeColor];
    self.show = [[ShowView alloc]initWithFrame:CGRectMake(0, XLPXCAL(636) + 64, XLWidth, XLHeight - (XLPXCAL(636) + 64))];
    [self.view addSubview:self.show];
    
    
    [self.show.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    
    
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    
    [self.show addGestureRecognizer:recognizer];
    
    UISwipeGestureRecognizer *swipt = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    [swipt setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.show addGestureRecognizer:swipt];
    
    UISwipeGestureRecognizer *swipt1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    [swipt1 setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.show addGestureRecognizer:swipt1];

}

- (void)swipeAction:(UISwipeGestureRecognizer *)swipe
{
    
    switch (swipe.direction) {
            
        case UISwipeGestureRecognizerDirectionUp:
        {
            if (showStatus -1 > kNone) {
                showStatus--;
                [self animationShowViewOfStatus:showStatus];
            }
        }
            break;
        case UISwipeGestureRecognizerDirectionDown:
        {
            if (showStatus + 1 < kMax) {
                showStatus++;
                [self animationShowViewOfStatus:showStatus];
            }
        }
            break;
        default:
            break;
    }
    
    
}

-(void)handleSwipeFrom:(UIPanGestureRecognizer *)recognizer{
    
    CGPoint point = [recognizer translationInView:self.view];
    
//    NSLog(@"%@",NSStringFromCGPoint(showPoint));
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            _flag = YES;
            CGRect tempF = self.show.frame;
            tempF.size.height = XLHeight;
            self.show.frame = tempF;
            
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            if (_flag) {
                
                if (point.y > 0) {
                    
                    _directionType = kMotionDirectionTypeDown;
                    _flag = NO;
                }else if(point.y < 0){
                    
                     _directionType = kMotionDirectionTypeUp;
                    _flag = NO;
                }else{
                    _directionType = kMotionDirectionTypeNone;
                }
                
            }
            
            recognizer.view.center = CGPointMake(recognizer.view.center.x, recognizer.view.center.y + point.y);
            [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
            
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        {
            
            if (_directionType == kMotionDirectionTypeUp) {
                
                
                if (showStatus -1 > kNone) {
                    showStatus--;
                    [self animationShowViewOfStatus:showStatus];
                }
            }else if(_directionType == kMotionDirectionTypeDown){
                
                if (showStatus + 1 < kMax) {
                    showStatus++;
                    [self animationShowViewOfStatus:showStatus];
                }
            }
            
        }
            break;
        default:
            break;
    }
    
}

/**
 * 传入一个状态值 根据状态值进行动画
 */
- (void)animationShowViewOfStatus:( kShowViewStatus)status
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        switch (showStatus) {
            case kTop:
            {
                
                [UIView animateWithDuration:0.25 animations:^{
                    
                    CGRect tempF = self.show.frame;
                    tempF.origin.y = 64 - XLPXCAL(60);
                    tempF.size.height = XLHeight;
                    self.show.frame = tempF;
                    
                    
                } completion:^(BOOL finished) {
                    
                    CGRect tempF = self.show.frame;
                    tempF.size.height = XLHeight - (64 - XLPXCAL(60));
                    self.show.frame = tempF;
                    
                }];
            }
                break;
            case kMiddle:
            {
                [UIView animateWithDuration:0.25 animations:^{
                    
                    CGRect tempF = self.show.frame;
                    tempF.origin.y = XLPXCAL(636) + 64;
                    tempF.size.height = XLHeight;
                    self.show.frame = tempF;
                    
                } completion:^(BOOL finished) {
                    
                    CGRect tempF = self.show.frame;
                    tempF.size.height = XLHeight - (XLPXCAL(636) + 64);
                    self.show.frame = tempF;
                    
                }];
            }
                break;
            case kDown:
            {
                [UIView animateWithDuration:0.25 animations:^{
                    
                    CGRect tempF = self.show.frame;
                    tempF.origin.y = XLHeight - XLPXCAL(60);
                    tempF.size.height = XLHeight;
                    self.show.frame = tempF;
                    
                } completion:^(BOOL finished) {
                    
                    CGRect tempF = self.show.frame;
                    tempF.size.height = XLHeight - (XLPXCAL(636) + 64);
                    self.show.frame = tempF;
                    
                }];
            }
                break;
            default:
                break;
        }
        
    });
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        NSLog(@"self.show.tableView.contentOffset = %@",NSStringFromCGPoint(self.show.tableView.contentOffset));
        
        if (self.show.tableView.contentOffset.y <-55) {
            
            if (showStatus + 1 < kMax) {
                
                self.show.tableView.scrollEnabled = NO;
                [self.show.tableView setContentOffset:self.show.tableView.contentOffset animated:YES];
                
                showStatus++;
                
                [UIView animateWithDuration:0.25 animations:^{
                    [self animationShowViewOfStatus:showStatus];
                } completion:^(BOOL finished) {
                    self.show.tableView.scrollEnabled = YES;
                }];
            }
            
        }
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

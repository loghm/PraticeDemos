//
//  ViewController.m
//  Test_cycle_reference
//
//  Created by 黄明族 on 2021/4/19.
//

/**
 * NSTimer的循环引用问题
 *
 */

#import "ViewController.h"
#import "AViewController.h"

@interface ViewController ()


@property (nonatomic, strong) UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.btn];
}

- (void)go:(UIButton *)sender {
    AViewController *a = [[AViewController alloc] init];
    [self.navigationController pushViewController:a animated:YES];
}

- (UIButton *)btn {
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setTitle:@"gogogo" forState:UIControlStateNormal];
        [_btn setBackgroundColor:UIColor.redColor];
        [_btn sizeToFit];
        CGRect frame = CGRectMake(_btn.frame.origin.x, _btn.frame.origin.y, _btn.frame.size.width, _btn.frame.size.height);
        frame.origin.x = 30;
        frame.origin.y = 150;
        _btn.frame = frame;
        [_btn addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}


@end

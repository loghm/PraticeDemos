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
#import "BViewController.h"

@interface ViewController ()


@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UIButton *abtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.btn];
    [self.view addSubview:self.abtn];
}

- (void)go:(UIButton *)sender {
    AViewController *a = [[AViewController alloc] init];
    [self.navigationController pushViewController:a animated:YES];
}

- (void)ago:(UIButton *)sender {
    BViewController *a = [[BViewController alloc] init];
    [self.navigationController pushViewController:a animated:YES];
}

- (UIButton *)getCommonBtn {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:UIColor.redColor];
    return btn;
}

- (UIButton *)btn {
    if (!_btn) {
        _btn = [self getCommonBtn];
        [_btn setTitle:@"gogogo_timer" forState:UIControlStateNormal];
        [_btn sizeToFit];
        CGRect frame = CGRectMake(_btn.frame.origin.x, _btn.frame.origin.y, _btn.frame.size.width, _btn.frame.size.height);
        frame.origin.x = 30;
        frame.origin.y = 150;
        _btn.frame = frame;
        [_btn addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (UIButton *)abtn {
    if (!_abtn) {
        _abtn = [self getCommonBtn];
        [_abtn setTitle:@"gogogo_block" forState:UIControlStateNormal];
        [_abtn sizeToFit];
        CGRect frame = CGRectMake(_abtn.frame.origin.x, _abtn.frame.origin.y, _abtn.frame.size.width, _abtn.frame.size.height);
        frame.origin.x = 30;
        frame.origin.y = 245;
        _abtn.frame = frame;
        [_abtn addTarget:self action:@selector(ago:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _abtn;
}


@end

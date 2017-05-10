//
//  ViewController.m
//  LeftCollectionViewItemsFlowLayout
//
//  Created by fangd@silviscene.com on 2017/5/8.
//  Copyright © 2017年 skm. All rights reserved.
//

#import "ViewController.h"
#import "Header.h"
#import "SkyItemsViewController.h"
#import "SkyLeftItemsViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self creatSegaMnetControl];
}
- (void)creatSegaMnetControl
{
    UISegmentedControl *segaMnetControl = [[UISegmentedControl alloc]initWithItems:@[@"正常的items",@"左对齐的items"]];
    segaMnetControl.frame = CGRectMake((WIDTH-280)/2, 120,280,32);
    segaMnetControl.tintColor = kRGBColor(16,123,214);
    [segaMnetControl addTarget:self action:@selector(SegmentControlChange:) forControlEvents:UIControlEventValueChanged];
    [segaMnetControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:kRGBColor(16,123,214)} forState:UIControlStateNormal];
    segaMnetControl.layer.borderWidth = 1;
    segaMnetControl.layer.cornerRadius = 5;
    segaMnetControl.layer.masksToBounds = YES;
    segaMnetControl.layer.borderColor = kRGBColor(16,123,214).CGColor;
    [segaMnetControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    [self.view addSubview:segaMnetControl];
}

-(void)SegmentControlChange:(UISegmentedControl *)seg
{
    if (seg.selectedSegmentIndex == 0) {
        SkyItemsViewController *VC = [[SkyItemsViewController alloc]init];
        [self presentViewController:VC animated:YES completion:nil];
    }
    if (seg.selectedSegmentIndex == 1) {
        SkyLeftItemsViewController *VC = [[SkyLeftItemsViewController alloc]init];
        [self presentViewController:VC animated:YES completion:nil];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

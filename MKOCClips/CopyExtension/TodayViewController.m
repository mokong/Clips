//
//  TodayViewController.m
//  CopyExtension
//
//  Created by moyekong on 15/9/16.
//  Copyright (c) 2015年 wiwide. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "CopyHandler.h"

@interface TodayViewController () <NCWidgetProviding>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel; // source
@property (weak, nonatomic) IBOutlet UILabel *displayLabel; // content

@property (strong, nonatomic) CopyHandler* tempHandler;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tempHandler = [[CopyHandler alloc] init];
    [self updateTitleLabel];
    [self updateDisplayLabel];
}

- (void)updateTitleLabel {
    self.titleLabel.text = [UIDevice currentDevice].name;
}

- (void)updateDisplayLabel {
    NSString *content = [self.tempHandler currentPasteBoardContent];
    self.displayLabel.text = content;
    [self.tempHandler saveContent:content];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openContainingApp:(id)sender {
    NSURL *url = [NSURL URLWithString:@"MKOCClips://"];
    [self.extensionContext openURL:url completionHandler:nil];
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    return UIEdgeInsetsZero;
}

@end

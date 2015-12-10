//
//  ViewController.m
//  MKOCClips
//
//  Created by moyekong on 15/9/16.
//  Copyright (c) 2015年 wiwide. All rights reserved.
//

#import "ViewController.h"
#import "MKCopyTableSectionHeaderView.h"
#import "MKCurrentPasteBoardCell.h"
#import "MKCopyTableViewCell.h"
#import "CopyHandler.h"
#import "MKCopyItem.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *pasteBoardHistoryArray;
@property (nonatomic, strong) CopyHandler *tempHandler;

@end

@implementation ViewController

static CGFloat const kTableSectionHeaderH = 32.0;
static CGFloat const kTableSectionFooterH = 0.1;
static NSString* const kCellReuseIdentifier = @"MKCopyTableViewCell";
static NSString* const kCurrentCellReuseIdentifier = @"MKCurrentPasteBoardCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tempHandler = [[CopyHandler alloc] init];
    self.navigationItem.title = @"剪切板";
    _pasteBoardHistoryArray = [self.tempHandler pasteBoardHistory];
    [self setupSubviews];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCurrentContent) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupSubviews {
    if (self.tableView) {
        return;
    }
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64.0, self.view.bounds.size.width, self.view.bounds.size.height - 64.0) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"MKCopyTableViewCell" bundle:nil] forCellReuseIdentifier:kCellReuseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"MKCurrentPasteBoardCell" bundle:nil] forCellReuseIdentifier:kCurrentCellReuseIdentifier];
    
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView delegate && datasource -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return self.pasteBoardHistoryArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kTableSectionHeaderH;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MKCopyTableSectionHeaderView *headerView = [[MKCopyTableSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, kTableSectionHeaderH)];
    if (section == 0) {
        headerView.displayLabel.text = @"现在剪切板的内容：";
    } else {
        headerView.displayLabel.text = @"剪切板的历史记录：";
    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return kTableSectionFooterH;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, kTableSectionFooterH)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return [self heightForCurrentCellAtIndexPath:indexPath];
    } else {
        return [self heightForCopyCellAtIndexPath:indexPath];
    }
}

- (CGFloat)heightForCurrentCellAtIndexPath:(NSIndexPath *)indexPath {
    static MKCurrentPasteBoardCell *currentCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        currentCell = [self.tableView dequeueReusableCellWithIdentifier:kCurrentCellReuseIdentifier];
    });
    [self configureCurrentCell:currentCell atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCurrentCell:currentCell];
}

- (CGFloat)calculateHeightForConfiguredSizingCurrentCell:(MKCurrentPasteBoardCell *)cell {
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1.0f;
}


- (CGFloat)heightForCopyCellAtIndexPath:(NSIndexPath *)indexPath {
    static MKCopyTableViewCell *copyCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        copyCell = [self.tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier];
    });
    [self configureCopyCell:copyCell atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:copyCell];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(MKCopyTableViewCell *)cell {
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKCurrentPasteBoardCell *cell = [tableView dequeueReusableCellWithIdentifier:kCurrentCellReuseIdentifier forIndexPath:indexPath];
        [self configureCurrentCell:cell atIndexPath:indexPath];
        return cell;
    } else {
        MKCopyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
        [self configureCopyCell:cell atIndexPath:indexPath];
        return cell;
    }
}

- (void)configureCurrentCell:(MKCurrentPasteBoardCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.displayLabel.text = [self.tempHandler currentPasteBoardContent];
    cell.displayLabel.textColor = [UIColor blackColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)configureCopyCell:(MKCopyTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    MKCopyItem *tempItem = _pasteBoardHistoryArray[indexPath.row];
    cell.displayLabel.text = tempItem.content;
    cell.timeIntervalLabel.text = [self.tempHandler getTimeInterval:tempItem.saveDate];
    cell.sourceDisplayLabel.text = tempItem.pasteBoardSource;
        
    cell.displayLabel.textColor = [UIColor darkGrayColor];
    cell.timeIntervalLabel.textColor = [UIColor lightGrayColor];
    cell.sourceDisplayLabel.textColor = [UIColor lightGrayColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return;
    } else {
        MKCopyItem *item = _pasteBoardHistoryArray[indexPath.row];
        [self.tempHandler copyContentToPasteBoard:item.content];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSIndexPath *firstSectionIndexPath= [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[firstSectionIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return UITableViewCellEditingStyleNone;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.section == 0) {
//            [self.tempHandler copyContentToPasteBoard:@""];
//            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        } else {
            MKCopyItem *item = _pasteBoardHistoryArray[indexPath.row];
            [self.tempHandler deleteContent:item.content];
            
            [self.pasteBoardHistoryArray removeObjectAtIndex:indexPath.row];
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
}

#pragma mark - refresh current content -
- (void)refreshCurrentContent {
    _pasteBoardHistoryArray = [self.tempHandler pasteBoardHistory];
    [self.tableView reloadData];
}

- (IBAction)edit:(id)sender {
    BOOL isEdit = !self.tableView.editing;
    if (isEdit) {
        self.navigationItem.rightBarButtonItem.title = @"完成";
    } else {
        self.navigationItem.rightBarButtonItem.title = @"编辑";
    }
    [self.tableView setEditing:isEdit animated:YES];
}

@end

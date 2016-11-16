//
//  ListViewController.m
//  SimpleTunnel
//
//  Created by Layne on 16/11/16.
//  Copyright © 2016年 Layne. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()
@property (nonatomic, assign) BOOL isAddEnabled;
@property (nonatomic, assign) BOOL isAlwaysEditing;
@property (nonatomic, strong) UITableViewCell *addCell;
@property (nonatomic, assign) NSInteger listCount;
@property (nonatomic, assign) UITableViewCellAccessoryType listAccessoryType;
@property (nonatomic, assign) UITableViewCellAccessoryType listEditingAccessoryType;
@property (nonatomic, assign) UITableViewCellSelectionStyle listCellSelectionStyle;
@property (nonatomic, copy) NSString *listAddButtonText;
@end

@implementation ListViewController

#pragma mark - lifeCycle
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}

- (instancetype)init {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isAlwaysEditing) {
        self.tableView.editing = YES;
    } else {
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = nil;
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        indexPath = [self.tableView indexPathForCell:sender];
    } else {
        return;
    }
    [self listSetupSegue:segue forItemAtIndex:indexPath.row];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    if (editing) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.listCount inSection:0];
        if (self.isEditing) {
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        } else {
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        }
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = self.listCount;
    if (self.tableView.isEditing) {
        count += 1;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    if (indexPath.item < self.listCount) {
        UITableViewCell *itemCell = [tableView dequeueReusableCellWithIdentifier:@"item-cell"];
        cell = itemCell;
        cell.textLabel.text = [self listTextForItemIndex:indexPath.row];
        cell.accessoryType = self.listAccessoryType;
        cell.editingAccessoryType = self.listEditingAccessoryType;
        cell.imageView.image = [self listImageForItemIndex:indexPath.row];
    } else if (self.tableView.isEditing && indexPath.row == self.listCount) {
        if (self.addCell != nil) {
            cell = self.addCell;
        } else {
            UITableViewCell *addButtonCell = [tableView dequeueReusableCellWithIdentifier:@"add-button"];
            cell = addButtonCell;
            cell.textLabel.text = self.listAddButtonText;
            cell.editingAccessoryType = UITableViewCellAccessoryNone;
        }
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (editingStyle) {
        case UITableViewCellEditingStyleDelete:
            [self listRemoveItemIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
            break;
        default:
            break;
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.listCount) {
        return UITableViewCellEditingStyleDelete;
    } else {
        return UITableViewCellEditingStyleInsert;
    }
}

#pragma mark - privateFunc
- (void)listSetupSegue:(UIStoryboardSegue *)segue forItemAtIndex:(NSInteger)index {
}

- (void)listInsertItemAtIndex:(NSInteger)index {
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:index inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
}

- (NSString *)listTextForItemIndex:(NSInteger)index {
    return @"";
}

- (UIImage *)listImageForItemIndex:(NSInteger)index {
    return nil;
}

- (void)listRemoveItemIndex:(NSInteger)index {
}

#pragma mark - lazyLoad
- (NSInteger)listCount {
    return 0;
}

- (UITableViewCellAccessoryType)listAccessoryType {
    return UITableViewCellAccessoryNone;
}

- (UITableViewCellAccessoryType)listEditingAccessoryType {
    return UITableViewCellAccessoryNone;
}

- (UITableViewCellSelectionStyle)listCellSelectionStyle {
    return UITableViewCellSelectionStyleDefault;
}

- (NSString *)listAddButtonText {
    return @"Add Configuration...";
}

@end

//
//  JUNTableViewAbstractBuilder.m
//  JUNKit
//
//  Created by Jun Ma on 2022/11/22.
//

#import "JUNTableViewAbstractBuilder.h"
#import "JUNTableViewProxy.h"

#define JUNKitInnerException(var_reason, var_userInfo) [NSException exceptionWithName:@"JUNKitInnerException" reason:var_reason userInfo:var_userInfo]

@interface JUNTableViewAbstractBuilder ()

@end

@implementation JUNTableViewAbstractBuilder

static NSString *cellReuseId = @"cell";

- (NSUInteger)_getItemCount {
    @throw JUNKitInnerException(nil, nil);
}

- (UIView *)_getItemForIndexPath:(NSIndexPath *)indexPath {
    @throw JUNKitInnerException(nil, nil);
}

- (void)_setUpCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    NSParameterAssert(indexPath.section == 0);
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    UIView *item = [self _getItemForIndexPath:indexPath];
    item.translatesAutoresizingMaskIntoConstraints = false;
    [cell.contentView addSubview:item];
    if ([self _itemHasWidthConstraint:item]) {
        [self _setUpCellConstraintsByAlignment:cell item:item];
    } else {
        [self _setUpCellConstraintsByDefault:cell item:item];
    }
}

- (bool)_itemHasWidthConstraint:(UIView *)item {
    for (NSLayoutConstraint *constraint in item.constraints) {
        if (constraint.firstItem != item) continue;
        if (constraint.firstAttribute != NSLayoutAttributeWidth) continue;
        return true;
    }
    if (item.frame.size.width == 0.0f) {
        [item sizeToFit];
    }
    NSParameterAssert(item.frame.size.width >= 0.0f);
    return item.frame.size.width > 0.0f;
}

- (void)_setUpCellConstraintsByAlignment:(UITableViewCell *)cell item:(UIView *)item {
    [self _setUpCellCommonConstraints:cell item:item];
    if (self.alignment == JUNTableViewItemAlignmentLeading) {
        [cell.contentView addConstraints:@[
            [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:self.indent],
        ]];
    } else if (self.alignment == JUNTableViewItemAlignmentCenter) {
        [cell.contentView addConstraints:@[
            [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f],
        ]];
    } else if (self.alignment == JUNTableViewItemAlignmentTrailing) {
        [cell.contentView addConstraints:@[
            [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:-self.indent],
        ]];
    }
}

- (void)_setUpCellConstraintsByDefault:(UITableViewCell *)cell item:(UIView *)item {
    [self _setUpCellCommonConstraints:cell item:item];
    [cell.contentView addConstraints:@[
        [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:self.indent],
        [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:-self.indent],
    ]];
}

- (void)_setUpCellCommonConstraints:(UITableViewCell *)cell item:(UIView *)item {
    
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-self.itemSpacing * 0.5];
    bottomConstraint.priority = UILayoutPriorityRequired - 1;
    [cell.contentView addConstraints:@[
        [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeTop multiplier:1.0f constant:self.itemSpacing * 0.5],
        bottomConstraint,
    ]];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self _getItemCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseId];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [self _setUpCell:cell forIndexPath:indexPath];
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.itemSpacing * 0.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return self.itemSpacing * 0.5;
}

@end

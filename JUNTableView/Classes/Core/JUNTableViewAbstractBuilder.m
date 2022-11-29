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
    
    for (UIView *subview in cell.contentView.subviews) {
        [subview removeFromSuperview];
    }
    
    UIView *item = [self _getItemForIndexPath:indexPath];
    
    UIView *itemWrapper = [self _wrappedItem:item];
    [cell.contentView addSubview:itemWrapper];
    
    CGFloat itemW = item.frame.size.width;
    CGFloat itemH = item.frame.size.height;
    
    [cell.contentView addConstraints:@[
        [NSLayoutConstraint constraintWithItem:itemWrapper attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:cell.contentView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:self.indent],
        [NSLayoutConstraint constraintWithItem:itemWrapper attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationLessThanOrEqual toItem:cell.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:-self.indent],
        [NSLayoutConstraint constraintWithItem:itemWrapper attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:itemWrapper attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f],
    ]];
    
    if (itemW) {
        NSLayoutConstraint *wConstraint = [NSLayoutConstraint constraintWithItem:itemWrapper attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:itemW];
        wConstraint.priority = UILayoutPriorityDefaultHigh;
        [itemWrapper addConstraint:wConstraint];
        
        if (self.alignment == JUNTableViewItemAlignmentLeading) {
            [cell.contentView addConstraint:
                [NSLayoutConstraint constraintWithItem:itemWrapper attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:self.indent]
            ];
        } else if (self.alignment == JUNTableViewItemAlignmentCenter) {
            [cell.contentView addConstraint:
                [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]
            ];
        } else if (self.alignment == JUNTableViewItemAlignmentTrailing) {
            [cell.contentView addConstraint:
                [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:-self.indent]
            ];
        }
    } else {
        NSLayoutConstraint *wConstraint = [NSLayoutConstraint constraintWithItem:itemWrapper attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f];
        wConstraint.priority = UILayoutPriorityDefaultHigh;
        [cell.contentView addConstraint:wConstraint];
    }
    
    if (itemH) {
        NSLayoutConstraint *hConstraint = [NSLayoutConstraint constraintWithItem:itemWrapper attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:itemH];
        hConstraint.priority = UILayoutPriorityDefaultHigh;
        [itemWrapper addConstraint:hConstraint];
    }
}

- (UIView *)_wrappedItem:(UIView *)item {
    item.translatesAutoresizingMaskIntoConstraints = false;
    UIView *itemWrapper = [[UIView alloc] init];
    itemWrapper.translatesAutoresizingMaskIntoConstraints = false;
    [itemWrapper addSubview:item];
    [itemWrapper addConstraints:@[
        [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:itemWrapper attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:itemWrapper attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:itemWrapper attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:itemWrapper attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f],
    ]];
    return itemWrapper;
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

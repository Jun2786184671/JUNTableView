//
//  UITableView+JUNex.m
//  JUNKit
//
//  Created by Jun Ma on 2022/11/22.
//

#import "UITableView+JUNex.h"
#import "JUNTableViewProxy.h"

@implementation UITableView (JUNex)
@dynamic jun_alignment, jun_itemSpacing, jun_indent;

+ (instancetype)jun_tableViewWithItems:(NSArray<UIView *> *)items {
    return (UITableView *)[[JUNTableViewProxy alloc] initWithItemsBuiler:^NSArray<UIView *> * _Nonnull{
        return items;
    }];
}

+ (instancetype)jun_tableViewWithItemsBuilder:(JUNTableViewItemsBuilder)itemsBuilder {
    return (UITableView *)[[JUNTableViewProxy alloc] initWithItemsBuiler:itemsBuilder];
}

+ (instancetype)jun_tableViewWithItemCount:(NSUInteger)itemCount itemBuilder:(JUNTableViewItemIndexBuilder)itemBuilder {
    return (UITableView *)[[JUNTableViewProxy alloc] initWithItemCountBuilder:^NSUInteger{
        return itemCount;
    } itemBuilder:itemBuilder];
}

+ (instancetype)jun_tableViewWithItemCountBuilder:(JUNTableViewCountBuilder)countBuilder itemBuilder:(JUNTableViewItemIndexBuilder)itemBuilder {
    return (UITableView *)[[JUNTableViewProxy alloc] initWithItemCountBuilder:countBuilder itemBuilder:itemBuilder];
}

+ (instancetype)jun_tableViewWithForEach:(NSArray<id> *)elements itemBuilder:(JUNTableViewItemForEachBuilder)itemBuilder {
    return (UITableView *)[[JUNTableViewProxy alloc] initWithItemCountBuilder:^NSUInteger{
        return elements.count;
    } itemBuilder:^UIView * _Nonnull(NSUInteger index) {
        return itemBuilder(index, elements[index]);
    }];
}

@end

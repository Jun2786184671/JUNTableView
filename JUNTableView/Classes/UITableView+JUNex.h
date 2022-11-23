//
//  UITableView+JUNex.h
//  JUNKit
//
//  Created by Jun Ma on 2022/11/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSArray<UIView *> * _Nonnull (^JUNTableViewItemsBuilder)(void);
typedef UIView * _Nonnull (^JUNTableViewItemIndexBuilder)(NSUInteger index);
typedef UIView * _Nonnull (^JUNTableViewItemForEachBuilder)(NSUInteger index, id element);
typedef NSUInteger (^JUNTableViewCountBuilder)(void);

typedef enum {
    JUNTableViewItemAlignmentLeading = -1,
    JUNTableViewItemAlignmentCenter = 0,
    JUNTableViewItemAlignmentTrailing = 1,
} JUNTableViewItemAlignment;

@interface UITableView (JUNex)

+ (instancetype)jun_tableViewWithItems:(NSArray<UIView *> *)items;
+ (instancetype)jun_tableViewWithItemsBuilder:(JUNTableViewItemsBuilder)itemsBuilder;
+ (instancetype)jun_tableViewWithItemCount:(NSUInteger)itemCount itemBuilder:(JUNTableViewItemIndexBuilder)itemBuilder;
+ (instancetype)jun_tableViewWithItemCountBuilder:(JUNTableViewCountBuilder)countBuilder itemBuilder:(JUNTableViewItemIndexBuilder)itemBuilder;
+ (instancetype)jun_tableViewWithForEach:(NSArray<id> *)elements itemBuilder:(JUNTableViewItemForEachBuilder)itemBuilder;

// The following attribute assignments are only valid for TableViews created with the jun prefix methods above.
@property(nonatomic, assign) JUNTableViewItemAlignment jun_alignment;
@property(nonatomic, assign) CGFloat jun_itemSpacing;
@property(nonatomic, assign) CGFloat jun_indent;

@end

NS_ASSUME_NONNULL_END

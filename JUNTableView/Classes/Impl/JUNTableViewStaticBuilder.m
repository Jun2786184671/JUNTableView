//
//  JUNTableViewStaticBuilder.m
//  Expecta
//
//  Created by Jun Ma on 2022/11/22.
//

#import "JUNTableViewStaticBuilder.h"

@interface JUNTableViewStaticBuilder ()

@property(nonatomic, strong, readonly) NSArray<UIView *> *(^itemsBuilder)(void);

@property(nonatomic, strong, readonly) NSArray<UIView *> *cachedItems;

@end

@implementation JUNTableViewStaticBuilder

static NSString *cellReuseId = @"static";

- (instancetype)initWithItemsBuilder:(NSArray<UIView *> *(^)(void))itemsBuilder {
    if (self = [super init]) {
        _itemsBuilder = itemsBuilder;
    }
    return self;
}

- (NSUInteger)_getItemCount {
    NSParameterAssert(self.itemsBuilder != nil);
    _cachedItems = self.itemsBuilder();
    return _cachedItems.count;
}

- (UIView *)_getItemForIndexPath:(NSIndexPath *)indexPath {
    return self.cachedItems[indexPath.row];
}

@end

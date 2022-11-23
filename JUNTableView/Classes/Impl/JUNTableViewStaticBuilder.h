//
//  JUNTableViewStaticBuilder.h
//  Expecta
//
//  Created by Jun Ma on 2022/11/22.
//

#import "JUNTableViewAbstractBuilder.h"

NS_ASSUME_NONNULL_BEGIN

@interface JUNTableViewStaticBuilder : JUNTableViewAbstractBuilder

- (instancetype)initWithItemsBuilder:(NSArray<UIView *> *(^)(void))itemsBuilder;

@end

NS_ASSUME_NONNULL_END

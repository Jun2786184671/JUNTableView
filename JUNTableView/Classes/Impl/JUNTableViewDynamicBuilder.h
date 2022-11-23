//
//  JUNTableViewDynamicBuilder.h
//  Expecta
//
//  Created by Jun Ma on 2022/11/22.
//

#import "JUNTableViewAbstractBuilder.h"

NS_ASSUME_NONNULL_BEGIN

@interface JUNTableViewDynamicBuilder : JUNTableViewAbstractBuilder

- (instancetype)initWithItemCountBuilder:(NSUInteger (^)(void))countBuilder itemBuilder:(UIView *(^)(NSUInteger index))itemBuilder;

@end

NS_ASSUME_NONNULL_END

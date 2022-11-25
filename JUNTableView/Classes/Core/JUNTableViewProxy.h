//
//  JUNTableView.h
//  Expecta
//
//  Created by Jun Ma on 2022/11/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JUNTableViewProxy : UIView

- (instancetype)initWithItemsBuiler:(NSArray<UIView *> *(^)(void))itemsBuilder;
- (instancetype)initWithItemCountBuilder:(NSUInteger (^)(void))countBuilder itemBuilder:(UIView *(^)(NSUInteger index))itemBuilder;

@end

NS_ASSUME_NONNULL_END

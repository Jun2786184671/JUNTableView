//
//  JUNTableViewAbstractBuilder.h
//  JUNKit
//
//  Created by Jun Ma on 2022/11/22.
//

#import <Foundation/Foundation.h>
#import "UITableView+JUNex.h"

NS_ASSUME_NONNULL_BEGIN

@interface JUNTableViewAbstractBuilder : NSObject <UITableViewDelegate, UITableViewDataSource>

- (NSUInteger)_getItemCount;
- (UIView *)_getItemForIndexPath:(NSIndexPath *)indexPath;

@property(nonatomic, assign) JUNTableViewItemAlignment alignment;
@property(nonatomic, assign) CGFloat itemSpacing;
@property(nonatomic, assign) CGFloat indent;

@end

NS_ASSUME_NONNULL_END

//
//  JUNTableView.m
//  Expecta
//
//  Created by Jun Ma on 2022/11/22.
//

#import "JUNTableViewProxy.h"
#import "JUNTableViewStaticBuilder.h"
#import "JUNTableViewDynamicBuilder.h"
#import "UITableView+JUNex.h"
#import <objc/runtime.h>

@interface JUNTableViewProxy () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong, readonly) UITableView *target;
@property(nonatomic, strong, readonly) JUNTableViewAbstractBuilder *builder;
@property(nonatomic, assign) JUNTableViewItemAlignment jun_alignment;
@property(nonatomic, assign) CGFloat jun_itemSpacing;
@property(nonatomic, assign) CGFloat jun_indent;
@property(nonatomic, weak) id<UITableViewDelegate> delegate;
@property(nonatomic, weak) id<UITableViewDataSource> dataSource;

@end

@implementation JUNTableViewProxy
@synthesize target = _target;

- (instancetype)initWithItemsBuiler:(NSArray<UIView *> *(^)(void))itemsBuilder {
    if (self = [self init]) {
        _builder = [[JUNTableViewStaticBuilder alloc] initWithItemsBuilder:itemsBuilder];
    }
    return self;
}

- (instancetype)initWithItemCountBuilder:(NSUInteger (^)(void))countBuilder itemBuilder:(UIView *(^)(NSUInteger))itemBuilder {
    if (self = [self init]) {
        _builder = [[JUNTableViewDynamicBuilder alloc] initWithItemCountBuilder:countBuilder itemBuilder:itemBuilder];
    }
    return self;
}

- (UITableView *)target {
    if (_target == nil) {
        _target = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self _setUpWrappedInstance];
    }
    return _target;
}

- (void)_setUpWrappedInstance {
    _target.translatesAutoresizingMaskIntoConstraints = false;
    _target.backgroundColor = [UIColor clearColor];
    _target.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *sizeBox = [[UIView alloc] init];
    sizeBox.frame = CGRectMake(0, 0, 0, CGFLOAT_MIN);
    _target.tableHeaderView = sizeBox;
    _target.tableFooterView = sizeBox;
}

- (void)setJun_alignment:(JUNTableViewItemAlignment)alignment {
    _jun_alignment = alignment;
    _builder.alignment = alignment;
}

- (void)setJun_itemSpacing:(CGFloat)itemSpacing {
    _jun_itemSpacing = itemSpacing;
    _builder.itemSpacing = itemSpacing;
}

- (void)setJun_indent:(CGFloat)indent {
    _jun_indent = indent;
    _builder.indent = indent;
}

- (void)didMoveToSuperview {
    if (self.target.superview) return;
    [self addSubview:self.target];
    self.target.delegate = self;
    self.target.dataSource = self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.target.frame = self.bounds;
}

#pragma mark - Proxy

- (bool)respondsToSelector:(SEL)aSelector {
//    NSLog(@"%@, %d", NSStringFromSelector(aSelector), [self forwardingTargetForSelector:aSelector] != nil);
    if ([super respondsToSelector:aSelector]) return true;
    return [self forwardingTargetForSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([self.target respondsToSelector:aSelector]) {
        return self.target;
    } else if ([self _isTableViewDelegateMethod:aSelector] && [self.delegate respondsToSelector:aSelector]) {
        return self.delegate;
    } else if ([self _isTableViewDataSourceMethod:aSelector] && [self.dataSource respondsToSelector:aSelector]) {
        return self.dataSource;
    }
    return nil;
}

- (bool)_isTableViewDelegateMethod:(SEL)selector {
    return [self _protocol:@protocol(UITableViewDelegate) containsMethod:selector];
}

- (bool)_isTableViewDataSourceMethod:(SEL)selector {
    return [self _protocol:@protocol(UITableViewDataSource) containsMethod:selector];
}

- (bool)_protocol:(Protocol *)protocol containsMethod:(SEL)selector {
    struct objc_method_description desc;
    desc = protocol_getMethodDescription(protocol, selector, NO, YES);
    if(desc.name != nil) {
        return true;
    }
    desc = protocol_getMethodDescription(protocol, selector, YES, YES);
    if(desc.name != nil) {
        return true;
    }
    return false;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.builder tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.builder tableView:tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark - <UITableViewDelegate>

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self.builder tableView:tableView viewForHeaderInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self.builder tableView:tableView viewForFooterInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self.builder tableView:tableView heightForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [self.builder tableView:tableView heightForFooterInSection:section];
}

@end

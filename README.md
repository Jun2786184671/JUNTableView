# JUNTableView

[![Version](https://img.shields.io/cocoapods/v/JUNTableView.svg?style=flat)](https://cocoapods.org/pods/JUNTableView)
[![License](https://img.shields.io/cocoapods/l/JUNTableView.svg?style=flat)](https://cocoapods.org/pods/JUNTableView)
[![Platform](https://img.shields.io/cocoapods/p/JUNTableView.svg?style=flat)](https://cocoapods.org/pods/JUNTableView)

## Demo

To run the demo project, clone the repo, and run `pod install` from the Example directory first.

## Installation

JUNTableView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JUNTableView'
```

## Guide
1. ```#import <JUNTableView/UITableView+JUNex.h>``` into your project's pch file, otherwise you will need to import this header in anywhere you want to quickly create a tableview.
2. There are a couple of methods that you can use to create a tableview quickly and elegantly.
```objc
+ (instancetype)jun_tableViewWithItems:(NSArray<UIView *> *)items;
+ (instancetype)jun_tableViewWithItemsBuilder:(JUNTableViewItemsBuilder)itemsBuilder;
+ (instancetype)jun_tableViewWithItemCount:(NSUInteger)itemCount itemBuilder:(JUNTableViewItemIndexBuilder)itemBuilder;
+ (instancetype)jun_tableViewWithItemCountBuilder:(JUNTableViewCountBuilder)countBuilder itemBuilder:(JUNTableViewItemIndexBuilder)itemBuilder;
+ (instancetype)jun_tableViewWithForEach:(NSArray<id> *)elements itemBuilder:(JUNTableViewItemForEachBuilder)itemBuilder;
```
 Don't worry about not specifying some of the parameter types in these methods, when you type these methods in XCode, you'll immediately know what to do next.
3. Here are some examples.
```objc
[UITableView jun_tableViewWithItems:@[
	aUILabel,
	aUIButton,
	aUISwitch,
	...
]];
```
```objc
[UITableView jun_tableViewWithForEach:aStringArray 
	itemBuilder:^UIView *(NSUInteger index, id element) {
	if ([element isEqual:@"text"]) {
	    return aUILabel;
	} else if ([element isEqual:@"button"]) {
		return aUIButton;
	} else {
		// Fall on other conditions...
	}
}];
```
```objc
UITableView *tableview = [UITableView jun_tableViewWithItemCountBuilder:^NSUInteger{
    return getRandomInteger();
} itemBuilder:^UIView *(NSUInteger index) {
    if (index == 0) {
    	return aUILabel,
    } else {
    	// Fall on other conditions...
    }
}];

[NSTimer scheduledTimerWithTimeInterval:1.0 repeats:true block:^(NSTimer *timer) {
	[tableview reloadData];
}];
```
4. A created tableview can set the delegate and datasource as normal.
```objc
tableview.delegate = anyDelegate;
tableview.dataSouce = anyDataSource;
```
5. Tableview created by the above methods has some additional properties.
```objc
@property(nonatomic, assign) JUNTableViewItemAlignment jun_alignment;
@property(nonatomic, assign) CGFloat jun_itemSpacing;
@property(nonatomic, assign) CGFloat jun_indent;
```
You can go to ```<JUNTableView/UITableView+JUNex.h>``` to see in detail.
## Author

Jun Ma, maxinchun5@gmail.com

## License

JUNTableView is available under the MIT license. See the LICENSE file for more info.

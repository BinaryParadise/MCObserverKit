# MCObserverKit

[![CI Status](https://travis-ci.org/MC-Studio/MCObserverKit.svg?style=flat)](https://travis-ci.org/MC-Studio/MCObserverKit)
[![Version](https://img.shields.io/cocoapods/v/MCObserverKit.svg?style=flat)](http://cocoapods.org/pods/MCObserverKit)
[![License](https://img.shields.io/cocoapods/l/MCObserverKit.svg?style=flat)](http://cocoapods.org/pods/MCObserverKit)
[![Platform](https://img.shields.io/cocoapods/p/MCObserverKit.svg?style=flat)](http://cocoapods.org/pods/MCObserverKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

MCObserverKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MCObserverKit'
```
## 如何使用

```objc
@interface MCTestModel : NSObject

@property (nonatomic, assign) int uuid;
@property (nonatomic, assign) int uuid1;

@property (nonatomic, copy, nullable) NSString *text;

@end

MCTestModel *m1 = [MCTestModel new];
//uuid变化时回调block
[MCObserver(m1, uuid) valueChanged:^(id target, id value) {
    XCTAssert(m1.uuid == 15568);
    [testExpectation fulfill];
}];
//text变化且符合条件时回调block
[MCObserver(m1, text) valueChanged:^(id target, id value) {
    XCTAssert(value);
    [testExpectation fulfill];
} condition:^BOOL(id target, id value) {
    return [value length] > 2;
}];
//uuid变化时回调SEL
[MCObserver(m1, uuid) addTarget:m1 action:@selector(targetCallback:)];

//赋值，触发值变化回调
m1.uuid = 15568;
```

## License

MCObserverKit is available under the MIT license. See the LICENSE file for more info.

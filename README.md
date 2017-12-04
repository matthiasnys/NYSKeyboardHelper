# NYSKeyboardHelper

[![CI Status](http://img.shields.io/travis/matthiasnys/NYSKeyboardHelper.svg?style=flat)](https://travis-ci.org/matthiasnys/NYSKeyboardHelper)
[![Version](https://img.shields.io/cocoapods/v/NYSKeyboardHelper.svg?style=flat)](http://cocoapods.org/pods/NYSKeyboardHelper)
[![License](https://img.shields.io/cocoapods/l/NYSKeyboardHelper.svg?style=flat)](http://cocoapods.org/pods/NYSKeyboardHelper)
[![Platform](https://img.shields.io/cocoapods/p/NYSKeyboardHelper.svg?style=flat)](http://cocoapods.org/pods/NYSKeyboardHelper)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

NYSKeyboardHelper is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'NYSKeyboardHelper'
```

## Use

### Storyboards

Simply pin a constraint to the bottom of your view and the scrollview that wraps your textinput. Override the NSLayoutconstraint as 'NYSKeyboardHelper'. And that's it. It should automatically shrink your scrollview to not go under your keyboard.

Add some 'extra indent' in the properties of the constraint to have a bit of margin between your containerview and the view.

### Code

```swift
self.view.addConstraint(NYSKeyboardHelper(item: self.view, attribute: .bottom, relatedBy: .equal, toItem: button, attribute: .bottom, multiplier: 1.0, constant: 0.0))
```
set the 'extraIndent' property to have more margin between your containerview and the view.

## Author

matthiasnys, matthias@b-nys.com

## License

NYSKeyboardHelper is available under the MIT license. See the LICENSE file for more info.

# SUBLicenseViewController

[![CI Status](http://img.shields.io/travis/insanj/SUBLicenseViewController.svg?style=flat)](https://travis-ci.org/insanj/SUBLicenseViewController)
[![Version](https://img.shields.io/cocoapods/v/SUBLicenseViewController.svg?style=flat)](http://cocoapods.org/pods/SUBLicenseViewController)
[![License](https://img.shields.io/cocoapods/l/SUBLicenseViewController.svg?style=flat)](http://cocoapods.org/pods/SUBLicenseViewController)
[![Platform](https://img.shields.io/cocoapods/p/SUBLicenseViewController.svg?style=flat)](http://cocoapods.org/pods/SUBLicenseViewController)

Incredibly simple license view controller for iOS. **Makes it really easy to attractively present acknowledgements for open source libraries within your app.** You know, the ones that come with all that 3rd party code you use?

![](Screenshots/first.png) ![](Screenshots/second.png)

## Usage

    SUBLicenseViewController *licenseViewController = [[SUBLicenseViewController alloc] init];
    [self.navigationController pushViewController:licenseViewController animated:YES];

SUBLicenseViewController will automatically parse and add your [Cocoapods acknowledgements files](https://github.com/CocoaPods/CocoaPods/wiki/Acknowledgements) as long as you add it to `Copy Bundle Resources` like so:

![](Screenshots/instructions.jpg)

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

SUBLicenseViewController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SUBLicenseViewController"
```

## Author

Julian (insanj) Weiss, insanjmail@gmail.com

## License

SUBLicenseViewController is available under the MIT license. See the LICENSE file for more info.

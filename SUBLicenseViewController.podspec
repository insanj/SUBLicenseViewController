#
# Be sure to run `pod lib lint SUBLicenseViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SUBLicenseViewController"
  s.version          = "1.0.1"
  s.summary          = "Incredibly simple license view controller. Makes it easy to attractively present acknowledgements for open source libraries within your app."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
  Incredibly simple license view controller for iOS. Makes it really easy to attractively present acknowledgements for open source libraries within your app.
                       DESC

  s.homepage         = "https://github.com/insanj/SUBLicenseViewController"
  s.screenshots      = "https://raw.githubusercontent.com/insanj/SUBLicenseViewController/master/Screenshots/first.png", "https://raw.githubusercontent.com/insanj/SUBLicenseViewController/master/Screenshots/first.png"
  s.license          = 'MIT'
  s.author           = { "insanj" => "insanjmail@gmail.com" }
  s.source           = { :git => "https://github.com/insanj/SUBLicenseViewController.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/insanj'

  s.platform     = :ios, '9.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'SUBLicenseViewController' => ['Pod/Assets/*.png']
  }

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

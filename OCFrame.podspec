#
# Be sure to run `pod lib lint OCFrame.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'OCFrame'
  s.version          = '1.0.1'
  s.summary          = 'iOS App Framework.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
						iOS App Framework using ObjC.
                       DESC

  s.homepage         = 'https://github.com/tospery/OCFrame'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tospery' => 'tospery@gmail.com' }
  s.source           = { :git => 'https://github.com/tospery/OCFrame.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = 'OCFrame/Classes/**/*'
  
  s.resource_bundles = {
    'OCFrame' => ['OCFrame/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'QMUIKit/QMUICore', '4.3.0'
  s.dependency 'CocoaLumberjack', '3.7.2'
  s.dependency 'RESTful', '1.0.0'
  s.dependency 'JLRoutes', '2.1'
  s.dependency 'SDWebImage', '5.12.1'
  s.dependency 'MJRefresh', '3.7.2'
  s.dependency 'FCUUID', '1.3.1'
  s.dependency 'PINCache', '3.0.3'
  s.dependency 'GVUserDefaults', '1.0.2'
  s.dependency 'Toast', '4.0.0'
  s.dependency 'TYAlertController', '1.2.0'
  s.dependency 'DZNEmptyDataSet', '1.8.1'
  s.dependency 'DKNightVersion', '2.4.3'
  # s.dependency 'WebViewJavascriptBridge', '6.0.3'
end

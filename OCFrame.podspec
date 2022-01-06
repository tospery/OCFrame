#
# Be sure to run `pod lib lint OCFrame.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'OCFrame'
  s.version          = '1.1.2'
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
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'YangJianxiang' => 'tospery@gmail.com' }
  s.source           = { :git => 'https://github.com/tospery/OCFrame.git', :tag => s.version.to_s }

  s.platform         = :ios, '11.0'
  s.frameworks       = 'Foundation'
  s.source_files     = 'OCFrame/OCFrame.h'
  
  s.subspec 'Model' do |ss|
    ss.source_files = 'OCFrame/OCFrame.h', 'OCFrame/Model'
	ss.dependency 'libextobjc/EXTConcreteProtocol', '0.6'
    ss.dependency 'Mantle-JX', '2.2.0-v3'
	ss.dependency 'PINCache', '3.0.3'
  end
  
  s.subspec 'Reactor' do |ss|
	ss.source_files = 'OCFrame/Reactor/**/*'
	ss.frameworks = 'UIKit'
    ss.dependency 'OCFrame/Model'
	s.dependency 'QMUIKit/QMUICore', '4.4.0'
	s.dependency 'CocoaLumberjack', '3.7.2'
	s.dependency 'AFNetworkActivityLogger', '3.0.0'
	s.dependency 'Overcoat-JX', '4.0.5'
	s.dependency 'JLRoutes', '2.1'
	s.dependency 'Giotto', '0.3.7'
	s.dependency 'FCUUID', '1.3.1'
	s.dependency 'GVUserDefaults', '1.0.2'
	s.dependency 'SDWebImage', '5.12.1'
	s.dependency 'MJRefresh', '3.7.2'
	s.dependency 'DZNEmptyDataSet', '1.8.1'
  end
  
  s.subspec 'Resources' do |ss|
    ss.resource_bundles = {'Resources' => ['OCFrame/Resources/*.*']}
  end

end

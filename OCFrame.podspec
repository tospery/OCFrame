#
# Be sure to run `pod lib lint OCFrame.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'OCFrame'
  s.version          = '1.1.4'
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
  
  s.subspec 'OCFCore' do |ss|
    ss.source_files = 'OCFrame/OCFCore/**/*'
	ss.dependency 'libextobjc/EXTConcreteProtocol', '0.6'
	ss.dependency 'CocoaLumberjack', '3.7.2'
	ss.dependency 'Mantle-JX', '2.2.0-v4'
	ss.dependency 'PINCache', '3.0.3'
  end
  
  s.subspec 'OCFNetwork' do |ss|
    ss.source_files = 'OCFrame/OCFNetwork/**/*'
	ss.dependency 'OCFrame/OCFCore'
	ss.dependency 'Overcoat-JX', '4.0.6'
  	ss.dependency 'AFNetworkActivityLogger', '3.0.0'
  end
  
  s.subspec 'OCFExtensions' do |ss|
    ss.source_files = 'OCFrame/OCFExtensions/**/*'
	ss.frameworks = 'UIKit'
  	ss.dependency 'OCFrame/OCFCore'
	ss.dependency 'OCFrame/OCFResources'
	ss.dependency 'QMUIKit/QMUICore', '4.4.0'
	ss.dependency 'Giotto', '0.3.7'
	ss.dependency 'FCUUID', '1.3.1'
	ss.dependency 'SDWebImage', '5.12.1'
  end
  
  s.subspec 'OCFReactor' do |ss|
	ss.source_files = 'OCFrame/OCFReactor/**/*'
	ss.dependency 'OCFrame/OCFNetwork'
    ss.dependency 'OCFrame/OCFExtensions'
	ss.dependency 'OCFrame/OCFComponents/JSBridge'
	ss.dependency 'JLRoutes', '2.1'
	ss.dependency 'GVUserDefaults', '1.0.2'
	ss.dependency 'MJRefresh', '3.7.2'
	ss.dependency 'DZNEmptyDataSet', '1.8.1'
  end
  
  s.subspec 'OCFResources' do |ss|
    ss.resource_bundles = {'OCFResources' => ['OCFrame/OCFResources/*.*']}
  end
  
  s.subspec 'OCFComponents' do |ss|
    ss.subspec 'JSBridge' do |sss|
      sss.source_files = 'OCFrame/OCFComponents/JSBridge/**/*'
	  sss.frameworks = 'UIKit', 'WebKit'
    end
  end

end

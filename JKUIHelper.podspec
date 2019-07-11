#
# Be sure to run `pod lib lint JKUIHelper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JKUIHelper'
  s.version          = '0.1.9.3'
  s.summary          = 'this is a tool to help ios develop to draw UI easily.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
this is a tool to help ios develop to draw UI easily. it will update with the needs
                       DESC

  s.homepage         = 'https://github.com/xindizhiyin2014/JKUIHelper'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xindizhiyin2014' => '929097264@qq.com' }
  s.source           = { :git => 'https://github.com/xindizhiyin2014/JKUIHelper.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'JKUIHelper/Classes/**/*'
  
  s.subspec 'JKShadow' do |spec|
      spec.source_files = 'JKUIHelper/JKShadow/**/*'
  end
  
  s.subspec 'JKRoundCorner' do |spec|
      spec.source_files = 'JKUIHelper/JKRoundCorner/**/*'
  end
  
  s.subspec 'JKTextView' do |spec|
      spec.source_files = 'JKUIHelper/JKTextView/**/*'
  end
  
  s.subspec 'JKHitTest' do |spec|
      spec.source_files = 'JKUIHelper/JKHitTest/**/*'
  end
  
  s.subspec 'JKProtocol' do |spec|
      spec.source_files = 'JKUIHelper/JKProtocol/**/*'
  end
  
  s.subspec 'JKCategories' do |spec|
      spec.source_files = 'JKUIHelper/JKCategories/**/*'
  end
  
  
  
  # s.resource_bundles = {
  #   'JKUIHelper' => ['JKUIHelper/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'SDWebImage'

end

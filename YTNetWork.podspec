#
# Be sure to run `pod lib lint YTNetWork.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YTNetWork'
  s.version          = '0.1.0'
  s.summary          = '对于YTKNetWork的封装，只适用于自由项目不通用'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
对于YTKNetWork的封装，只适用于自由项目不通用
                       DESC

  s.homepage         = 'https://github.com/iwangyantao/YTNetWork'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'iwangyantao' => 'iwangyantao@163.com' }
  s.source           = { :git => 'https://github.com/iwangyantao/YTNetWork.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'YTNetWork/Classes/**/*'
  
  # s.resource_bundles = {
  #   'YTNetWork' => ['YTNetWork/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'AFNetworking'
   s.dependency 'AFNetworking'
   s.dependency 'AFNetworking'
   s.dependency 'AFNetworking'

end

#
# Be sure to run `pod lib lint NN_Alert_Views.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NN_Alert'
  s.version          = '0.0.1'
  s.summary          = 'A unifined alert views mimicking material design diaglog.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  A unifined alert views mimicking material design diaglog
  build on top of material cosmic mid
                       DESC

  s.homepage         = 'https://github.com/autumnssun/POD_Alert_View'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'autumnssun' => 'autumns.sun@gmail.com' }
  s.source           = { :git => 'https://github.com/autumnssun/POD_Alert_View.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'
  s.swift_version = '4.2'

  s.source_files = 'NN_Alert/**/*'
  s.source_files = 'NN_Alert/**/*.{h,m,swift}'
  s.resources = 'NN_Alert/**/*.{xcassets}'
  # s.resource_bundles = {
  #   'NN_Alert_Views' => ['NN_Alert_Views/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SnapKit'
  s.dependency 'Material'
  s.dependency 'SwiftValidator'

end

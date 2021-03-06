#
# Be sure to run `pod lib lint HQYPlayer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HQYPlayer'
  s.version          = '0.3.0'
  s.summary          = 'A short description of HQYPlayer.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/bingstyle/HQYPlayer'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'bingstyle' => '183292352@qq.com' }
  s.source           = { :git => 'https://github.com/bingstyle/HQYPlayer.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  # s.resource_bundles = {
  #   'HQYPlayer' => ['HQYPlayer/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.xcconfig = { 'VALID_ARCHS' => 'arm64 x86_64', }
  s.static_framework = true
  s.dependency 'IJKMediaFramework'
  s.default_subspec = 'Core'
  
  s.subspec "Core" do |ss|
      ss.source_files = 'HQYPlayer/Classes/**/*'
      ss.public_header_files = 'HQYPlayer/Classes/**/*.h'
  end
  s.subspec "TXLiteAVSDK_Player" do |ss|
      ss.dependency 'HQYPlayer/Core'
      ss.dependency 'TXLiteAVSDK_Player'
  end
  s.subspec "TXLiteAVSDK_Smart" do |ss|
      ss.dependency 'HQYPlayer/Core'
      ss.dependency 'TXLiteAVSDK_Smart'
  end
  s.subspec "TXLiteAVSDK_Professional" do |ss|
      ss.dependency 'HQYPlayer/Core'
      ss.dependency 'TXLiteAVSDK_Professional'
  end
  s.subspec "TXLiteAVSDK_UGC" do |ss|
      ss.dependency 'HQYPlayer/Core'
      ss.dependency 'TXLiteAVSDK_UGC'
  end
  
end

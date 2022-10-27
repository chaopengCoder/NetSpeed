#
# Be sure to run `pod lib lint NetSpeed.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NetSpeed'
  s.version          = '1.0.1'
  s.summary          = 'iOS 测速 使用Swift编写, 兼容Objective-C'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/chaopengCoder/NetSpeed'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'chaopengCoder' => 'chaopeng_coder@qq.com' }
  s.source           = { :git => 'https://github.com/chaopengCoder/NetSpeed.git', :tag => s.version.to_s }

  s.swift_version = '5.0'
  s.ios.deployment_target = '11.0'

  s.source_files = 'NetSpeed/Classes/**/*'
end

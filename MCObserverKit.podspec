#
# Be sure to run `pod lib lint MCObserverKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MCObserverKit'
  s.version          = '0.2.0'
  s.summary          = 'A short description of MCObserverKit.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/MC-Studio/MCObserverKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mylcode' => 'mylcode.ali@gmail.com' }
  s.source           = { :git => 'https://github.com/BinaryParadise/MCObserverKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.requires_arc    = true

  s.source_files = 'MCObserverKit/**/*'

  s.dependency 'MCFoundation', '~> 0.2'

end

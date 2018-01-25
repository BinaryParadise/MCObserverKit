#
# Be sure to run `pod lib lint MCObserverKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MCObserverKit'
  s.version          = '0.1.0'
  s.summary          = 'A short description of MCObserverKit.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/MC-Studio/MCObserverKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mylcode' => 'mylcode.ali@gmail.com' }
  s.source           = { :git => 'https://github.com/MC-Studio/MCObserverKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.requires_arc    = true

  s.pod_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES', 'GCC_PREPROCESSOR_DEFINITIONS' => 'MCLoggerLevel=5'}

  s.source_files = 'MCObserverKit/**/*'

  s.dependency 'MCLogger', '~> 0.2.4'

end

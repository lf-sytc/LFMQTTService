#
# Be sure to run `pod lib lint LFMQTTService.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LFMQTTService'
  s.version          = '0.1.0'
  s.summary          = 'A short description of LFMQTTService.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
  s.homepage         = 'https://github.com/lf-sytc/LFMQTTService'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lf_sytc@hotmail.com' => 'lf_sytc@hotmail.com' }
  s.source           = { :git => 'https://github.com/lf-sytc/LFMQTTService.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'

  s.source_files = 'LFMQTTService/Classes/**/*'

end

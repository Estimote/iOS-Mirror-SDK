Pod::Spec.new do |s|
  s.name             = 'EstimoteMirrorCore'
  s.version          = '0.1.4'
  s.summary          = 'Estimote MirrorCore SDK is responsible for the communication between the phone and Mirror.'

  s.description      = <<-DESC
Estimote MirrorCore SDK is responsible for the communication between the phone and Mirror.
                       DESC

  s.homepage         = 'https://github.com/Estimote/iOS-Mirror-SDK'
  s.license          = { :type => 'Apache 2.0', :file => 'LICENSE.txt' }
  s.author           = { 'Estimote' => 'contact@estimote.com' }
  s.source           = { :git => 'https://github.com/Estimote/iOS-Mirror-SDK.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/estimote'

  s.ios.deployment_target = '8.0'
  s.vendored_frameworks = 'Core/MirrorCoreSDK.framework'
end

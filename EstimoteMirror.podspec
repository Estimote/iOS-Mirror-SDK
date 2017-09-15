Pod::Spec.new do |s|
  s.name             = 'EstimoteMirror'
  s.version          = '0.1.4'
  s.summary          = 'Take control of the TV screen from your iOS app with Estimote Mirror SDK'
  s.description      = <<-DESC
The Mirror SDK is a dev tool designed to reflect our imagination of the future of mobile development in the world of contextual interactions over BLE.
                       DESC

  s.homepage         = 'https://github.com/Estimote/iOS-Mirror-SDK'
  s.license          = { :type => 'Apache 2.0', :file => 'LICENSE.txt' }
  s.author           = { 'Estimote' => 'contact@estimote.com' }
  s.source           = { :git => 'https://github.com/Estimote/iOS-Mirror-SDK.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/estimote'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Sources/**/*.{swift,h}'
  s.module_name = 'MirrorDisplay'

  s.dependency 'EstimoteMirrorCore'
end

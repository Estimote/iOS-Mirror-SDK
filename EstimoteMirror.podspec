Pod::Spec.new do |s|
  s.name             = 'EstimoteMirror'
  s.version          = '0.2.0'
  s.summary          = 'Take control of the TV screen from your iOS app with Estimote Mirror SDK'
  s.description      = <<-DESC
The Mirror SDK is an addition to the Estimote Mirror Core SDK that enables easy interaction with built-in and custom templates.
                       DESC

  s.homepage         = 'https://github.com/Estimote/iOS-Mirror-SDK'
  s.license          = { :type => 'Apache 2.0', :file => 'LICENSE.txt' }
  s.author           = { 'Estimote' => 'contact@estimote.com' }
  s.source           = { :git => 'https://github.com/Estimote/iOS-Mirror-SDK.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/estimote'

  s.ios.deployment_target = '10.0'
  s.swift_version = '4.1'

  s.source_files = 'Sources/**/*.{swift,h}'
  s.module_name = 'MirrorDisplay'

  s.dependency 'EstimoteMirrorCore'

end

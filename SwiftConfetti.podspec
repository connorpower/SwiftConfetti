Pod::Spec.new do |s|
  s.name             = 'SwiftConfetti'
  s.version          = '1.0.0'
  s.summary          = 'A delightful Swift confetti library, rendered using Metal.'
  s.swift_versions   = ['5.1', '5.2']
  s.homepage         = 'https://github.com/connorpower/SwiftConfetti'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Connor Power' => 'connor@connorpower.com' }
  s.source           = { :git => 'https://github.com/connorpower/SwiftConfetti.git', :tag => s.version.to_s }

  s.ios.deployment_target = '12.0'

  s.source_files = 'SwiftConfetti/Classes/**/*'
  s.resources = ['SwiftConfetti/Assets/*.png']
  s.frameworks = 'SceneKit', 'Metal'
end

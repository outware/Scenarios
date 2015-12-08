Pod::Spec.new do |s|
  s.name     = 'Scenarios'
  s.version  = '0.2.2'
  s.license  = { :type => 'Apache 2.0', :file => 'LICENSE.txt' }
  s.summary  = 'Human-oriented testing in Swift.'
  s.homepage = 'https://github.com/outware/Scenarios'
  s.authors  = { 'Adam Sharplet' => 'adsharp@me.com' }

  s.source   = { :git => 'https://github.com/outware/Scenarios.git', :tag => "v#{s.version}" }
  s.source_files = 'Scenarios/**/*.swift'

  s.ios.deployment_target = '8.0'

  s.framework = 'XCTest'
  s.dependency 'Quick'
  s.dependency 'STRegex'
end

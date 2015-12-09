Pod::Spec.new do |s|
  s.name     = File.basename(__FILE__, ".podspec")
  s.version  = %x(git describe --tags --abbrev=0).chomp.sub(/^v/, '')
  s.summary  = %x(curl -s https://api.github.com/repos/outware/#{s.name} | ruby -rjson -e 'puts JSON.parse($stdin.read).fetch("description")').chomp
  s.license  = { :type => 'Apache 2.0', :file => 'LICENSE.txt' }
  s.homepage = 'https://github.com/outware/Scenarios'
  s.authors  = { 'Adam Sharplet' => 'adsharp@me.com' }
  s.source   = { :git => 'https://github.com/outware/Scenarios.git', :tag => "v#{s.version}" }
  s.source_files = 'Scenarios/**/*.swift'
  s.ios.deployment_target = '8.0'
  s.framework = 'XCTest'
  s.dependency 'Quick'
  s.dependency 'STRegex'
end

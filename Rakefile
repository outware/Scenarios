module Quick
  PROJECT = "Carthage/Checkouts/Quick/Quick.xcodeproj"
  SCHEME = "Quick-iOS"
end

module Scenarios
  WORKSPACE = "Scenarios.xcworkspace"
  SCHEME = "Scenarios-iOS"
end

DESTINATION = "platform=iOS Simulator,name=iPhone 6s"

task :quick do
  sh "xcodebuild -project #{Quick::PROJECT} -scheme #{Quick::SCHEME} -destination '#{DESTINATION}' | xcpretty -c; exit ${PIPESTATUS[0]}"
end

task :test => :quick do
  sh "xcodebuild test -workspace #{Scenarios::WORKSPACE} -scheme #{Scenarios::SCHEME} -destination '#{DESTINATION}' | xcpretty -c; exit ${PIPESTATUS[0]}"
end

task :default => :test

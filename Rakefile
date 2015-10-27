WORKSPACE = "Scenarios.xcworkspace"
SCHEME = "Scenarios-iOS"
DESTINATION = "platform=iOS Simulator,name=iPhone 6s"

task :test do
  sh "xcodebuild test -workspace #{WORKSPACE} -scheme #{SCHEME} -destination '#{DESTINATION}' | xcpretty -c; exit ${PIPESTATUS[0]}"
end

task :default => :test

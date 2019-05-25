DESTINATION = "platform=iOS Simulator,name=iPhone X"
SCHEME = "Scenarios-iOS"

def xcpretty(cmd)
  sh "#{cmd} | xcpretty -c; exit ${PIPESTATUS[0]}"
end

task :default => :test

desc "Setup Scenarios for development"
task :setup do
  sh "carthage bootstrap --platform iOS"
end

desc "Run the specs & UI tests"
task :test => ["test:specs", "test:demo"]

desc "Cleans the Scenarios development workspace"
task :clean do
  xcpretty "xcodebuild clean -scheme Scenarios-iOS -destination '#{DESTINATION}'"
end

namespace :test do
  desc "Attempts to build Scenarios and its dependencies"
  task :build do
    sh "carthage build --no-skip-current --platform iOS"
  end

  desc "Runs the unit tests for Scenarios"
  task :specs do
    xcpretty "xcodebuild test -scheme Scenarios-iOS -destination '#{DESTINATION}'"
  end

  desc "Runs the unit tests for Scenarios via swiftpm"
  task :package do
    sh "swift test"
  end

  desc "Runs the UI tests / demo for Scenarios"
  task :demo do
    xcpretty "xcodebuild test -workspace Demo/Demo.xcworkspace -scheme Demo-iOS -destination '#{DESTINATION}'"
  end

  desc "Run all tests"
  task :all => ["test:package", "test:specs", "test:demo"]
end

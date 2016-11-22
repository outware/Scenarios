
SUPPORTED_PLATFORMS = "iphoneos"
CARTHAGE_PLATFORMS = "--platform #{SUPPORTED_PLATFORMS}"

desc "Setup Scenarios for development"
task :setup do
  system "carthage bootstrap #{CARTHAGE_PLATFORMS}"
end

desc "Attempts to build Scenarios and its dependencies"
task :build do
  system "carthage build #{CARTHAGE_PLATFORMS} --no-skip-current"
end

SCHEME = "Scenarios-iOS"
DESTINATION = "platform=iOS Simulator,name=iPhone 6s"

task :clean do
  sh "xcodebuild clean -configuration Release -scheme #{SCHEME} -destination '#{DESTINATION}' | xcpretty -c; exit ${PIPESTATUS[0]}"
end

task :spec do
  sh "xcodebuild test -configuration Release -scheme #{SCHEME} -destination '#{DESTINATION}' | xcpretty -c; exit ${PIPESTATUS[0]}"
end

task :demo do
  sh "xcodebuild test -configuration Release -workspace Demo/Demo.xcworkspace -scheme Demo-iOS -destination '#{DESTINATION}' | xcpretty -c; exit ${PIPESTATUS[0]}"
end

task :default => [:spec, :demo]

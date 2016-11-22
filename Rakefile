
desc "Setup Scenarios for development"
task :setup do
  system "carthage bootstrap --platform iphoneos"
end

desc "Attempts to build Scenarios and its dependencies"
task :build do
  system "carthage build --platform iphoneos --no-skip-current"
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

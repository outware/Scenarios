SCHEME = "Scenarios-iOS"
DESTINATION = "platform=iOS Simulator,name=iPhone 6s"

task :clean do
  sh "xcodebuild clean -scheme #{SCHEME} -destination '#{DESTINATION}' | xcpretty -c; exit ${PIPESTATUS[0]}"
end

task :spec do
  sh "xcodebuild test -scheme #{SCHEME} -destination '#{DESTINATION}' | xcpretty -c; exit ${PIPESTATUS[0]}"
end

task :demo do
  sh "xcodebuild test -workspace Demo/Demo.xcworkspace -scheme Demo-iOS -destination '#{DESTINATION}' | xcpretty -c; exit ${PIPESTATUS[0]}"
end

task :default => [:spec, :demo]

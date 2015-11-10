WORKSPACE = "Scenarios.xcworkspace"
SCHEME = "Scenarios-iOS"
DESTINATION = "platform=iOS Simulator,name=iPhone 6s"

task :clean do
  sh "xcodebuild clean -workspace #{WORKSPACE} -scheme #{SCHEME} -destination '#{DESTINATION}' | xcpretty -c; exit ${PIPESTATUS[0]}"
end

task :spec do
  sh "xcodebuild test -workspace #{WORKSPACE} -scheme #{SCHEME} -destination '#{DESTINATION}' | xcpretty -c; exit ${PIPESTATUS[0]}"
end

task :demo do
  sh "xcodebuild test -workspace #{WORKSPACE} -scheme Demo-iOS -destination '#{DESTINATION}' | xcpretty -c; exit ${PIPESTATUS[0]}"
end

task :default => [:spec, :demo]

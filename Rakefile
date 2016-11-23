
SUPPORTED_PLATFORMS = "iphoneos"
CARTHAGE_PLATFORMS = "--platform #{SUPPORTED_PLATFORMS}"
SWIFT_2_3_TOOLCHAIN = "--toolchain com.apple.dt.toolchain.Swift_2_3"

SCHEME = "Scenarios-iOS"
DESTINATION = "platform=iOS Simulator,name=iPhone 6s"

def printCommand (command)
  puts "\n====> #{command}\n"
end

def systemExec (command)
  printCommand command
  system command
end

desc "Setup Scenarios for development"
task :setup do
  bootstrap = "carthage bootstrap #{CARTHAGE_PLATFORMS}"
  bootstrap += " #{SWIFT_2_3_TOOLCHAIN}" if canUseSwift2_3?
  systemExec bootstrap
end

namespace :test do

  desc "Attempts to build Scenarios and its dependencies"
  task :build do
    build = "carthage build #{CARTHAGE_PLATFORMS} --no-skip-current"
    build += " #{SWIFT_2_3_TOOLCHAIN}" if canUseSwift2_3?
    systemExec build
  end

  desc "Runs the unit tests for Scenarios"
  task :specs do
    sh "xcodebuild test -configuration Release -scheme #{SCHEME} -destination '#{DESTINATION}' | xcpretty -c; exit ${PIPESTATUS[0]}"
  end

  desc "Runs the UI tests / demo for Scenarios"
  task :demo do
    sh "xcodebuild test -configuration Release -workspace Demo/Demo.xcworkspace -scheme Demo-iOS -destination '#{DESTINATION}' | xcpretty -c; exit ${PIPESTATUS[0]}"
  end

end

desc "Cleans the Scenarios development workspace"
task :clean do
  sh "xcodebuild clean -configuration Release -scheme #{SCHEME} -destination '#{DESTINATION}' | xcpretty -c; exit ${PIPESTATUS[0]}"
end

task :default => ["test:specs", "test:demo"]

# Utility

class Array
  def includeAny? (arrayOfElements)
    raise "'#{arrayOfElements}' is not an `Array`" unless arrayOfElements.is_a? Array
    arrayOfElements.each { |element| return true if self.include? element }
    return false
  end
end

class String
  def isInstalled
    !`which #{self}`.empty?
  end
end

def canUseSwift2_3?
  raise "`xcodebuild` is not installed.`" unless "xcodebuild".isInstalled
  `xcodebuild -version | grep 'Xcode 8'`
    .split
    .map { |text| text.to_f }
    .includeAny? [8.0, 8.1, 8.2]
end

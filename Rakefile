
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
  CarthageTask::Bootstrap.execute
end

namespace :test do

  desc "Attempts to build Scenarios and its dependencies"
  task :build do
    CarthageTask::Build.execute
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

class Task
  private
  def initialize (command)
    @command = command
  end

  public
  def execute
    function = @command
    systemExec function
  end
end

class CarthageTask < Task
  def execute
    function = @command += " #{CARTHAGE_PLATFORMS}"
    function += " #{SWIFT_2_3_TOOLCHAIN}" if canUseSwift2_3?
    systemExec function
  end

  Bootstrap = CarthageTask.new('carthage bootstrap')
  Build     = CarthageTask.new('carthage build --no-skip-current')
end

def canUseSwift2_3?
  `xcodebuild -version | grep 'Xcode 8'`
    .split
    .map { |text| text.to_f }
    .includeAny? [8.0, 8.1, 8.2]
end

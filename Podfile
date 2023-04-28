# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

workspace 'TodoList'
target 'TodoList' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'SwiftGen', '~> 6.0'
  pod 'Swinject'

  target 'Storage' do
    project 'Storage/Storage.xcodeproj'
    pod 'Swinject'

end
end


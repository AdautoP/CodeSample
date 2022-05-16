# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

workspace 'CodeSample.xcworkspace'

def base_frameworks
  pod 'AloeStackView'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'TinyConstraints'
  pod 'SwiftGen', '~> 6.0'
  pod 'SwiftLint'
end

target 'CodeSample' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  inherit! :search_paths
  base_frameworks

  # Pods for CodeSample

  target 'CodeSampleTests' do
    # Pods for testing
  end
end

target 'Core' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  inherit! :complete

  project 'Modules/Core/Core.xcodeproj'

  base_frameworks

  # Pods for CodeSample
end

target 'Components' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  inherit! :complete

  project 'Modules/Components/Components.xcodeproj'

  base_frameworks

  # Pods for CodeSample
end

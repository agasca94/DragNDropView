#
# Be sure to run `pod lib lint DragNDropView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DragNDropView'
  s.version          = '0.1.0'
  s.summary          = 'An image view with support for child views with rotating, resizing and moving capabilities.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
An image view with support for child views with rotating, resizing and moving capabilities.
The image can also modify its brightness level and support drawings with the finger.
                       DESC

  s.homepage         = 'https://github.com/ArturoGasca/DragNDropView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ArturoGasca' => 'agasca1994@gmail.com' }
  s.source           = { :git => 'https://github.com/ArturoGasca/DragNDropView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'DragNDropView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'DragNDropView' => ['DragNDropView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

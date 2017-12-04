#
# Be sure to run `pod lib lint NYSKeyboardHelper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NYSKeyboardHelper'
  s.version          = '0.1.0'
  s.summary          = 'A constraint that fixes your keyboard needs'

  s.description      = <<-DESC
A keyboard constraint class that can manage your keyboard needs in different situations. It automagically makes your bottom constraint interactive so you don't have to worry about it. Just pin it between your containerview and the input view.
                       DESC

  s.homepage         = 'https://github.com/matthiasnys/NYSKeyboardHelper'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'matthiasnys' => 'matthias@b-nys.com' }
  s.source           = { :git => 'https://github.com/matthiasnys/NYSKeyboardHelper.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'NYSKeyboardHelper/Classes/**/*'
end


Pod::Spec.new do |s|
  s.name             = 'FoundationKit'
  s.version          = '0.1.0'
  s.summary          = 'A short description of FoundationKit.'
  s.homepage         = 'https://github.com/Mike Cap/FoundationKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mike Cap' => 'hoangelec@icloud.com' }
  s.source           = { :git => 'https://github.com/Mike Cap/FoundationKit.git', :tag => s.version.to_s }s

  s.ios.deployment_target = '13.0'

  s.source_files = 'FoundationKit/Classes/**/*'
  
  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'Tests/**/*'
  end
end

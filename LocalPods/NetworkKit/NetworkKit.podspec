
Pod::Spec.new do |s|
  s.name             = 'NetworkKit'
  s.version          = '0.1.0'
  s.summary          = 'A short description of NetworkKit.'
  s.homepage         = 'https://github.com/Mike Cap/NetworkKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mike Cap' => 'hoangelec@icloud.com' }
  s.source           = { :git => 'https://github.com/Mike Cap/NetworkKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'

  s.source_files = 'NetworkKit/Classes/**/*'
  s.dependency 'Alamofire'
  s.dependency 'FoundationKit'
  
  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'Tests/**/*'
  end
end

# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

def use_local_pod(pod_name, configurations: nil, test_specs: nil)
  puts "configurations: #{configurations}"
  puts "test_specs: #{test_specs}"
  if !test_specs.nil? && !configurations.nil?
    puts "test_specs && configurations exists"
    pod "#{pod_name}", :path => "LocalPods/#{pod_name}", :configurations => configurations, :test_specs => test_specs
  elsif !test_specs.nil?
  puts "test_specs exists"
     pod "#{pod_name}", :path => "LocalPods/#{pod_name}", :testspecs => test_specs
  elsif !configurations.nil?
  puts "configurations exists"
        pod "#{pod_name}", :path => "LocalPods/#{pod_name}", :configurations => configurations
  else
    puts "simple pod"
        pod "#{pod_name}", :path => "LocalPods/#{pod_name}"
  end
end

  
target 'MVVMBoxing' do
  use_frameworks!

  pod 'SnapKit'
  pod 'Factory'
  use_local_pod('FoundationKit', test_specs: ['Tests'])
  use_local_pod('NetworkKit', test_specs: ['Tests'])
end

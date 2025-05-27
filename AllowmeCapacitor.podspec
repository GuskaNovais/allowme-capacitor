require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name = 'AllowmeCapacitor'
  s.version = package['version']
  s.summary = package['description']
  s.license = package['license']
  s.homepage = package['repository']['url']
  s.author = package['author']
  s.source = { :git => package['repository']['url'], :tag => s.version.to_s }
  s.source_files = 'ios/Sources/**/*.{swift,h,m,c,cc,mm,cpp}'
  s.ios.deployment_target = '14.0'
  s.dependency 'Capacitor'

  
  s.dependency 'AllowMeSDK', '~> 3.3.2'
  s.source = { :git => 'https://git-codecommit.us-east-1.amazonaws.com/v1/repos/allowme_Spec', :tag => s.version.to_s }

  s.swift_version = '5.1'
end

#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'stripe_apple_pay'
  s.version          = '1.0.0'
  s.summary          = 'Charge users using Apple Pay and Stripe.'
  s.description      = <<-DESC
Create chargeable stripe tokens using Apple Pay.
                       DESC
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Jacobo Soffer' => 'sofferjacob@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'Stripe', '> 19.0.0'
  s.swift_version = '5.0'
  s.homepage = 'https://github.com/sofferjacob/stripe_apple_pay'

  s.ios.deployment_target = '12.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
end


Pod::Spec.new do |spec|

  spec.name         = "NFCPassportReader"
  spec.version      = "2.1.1"
  spec.summary      = "This package handles reading an NFC Enabled passport using iOS 13 CoreNFC APIS"

  spec.homepage     = "https://github.com/TechTeamer/NFCPassportReader"
  spec.license      = "MIT"
  spec.author       = { "Oliver Kocsis" => "oliver.kocsis@facekom.com" }
  spec.platform = :ios
  spec.ios.deployment_target = "15.0"

  spec.source       = { :git => "https://github.com/TechTeamer/NFCPassportReader.git", :tag => "#{spec.version}" }

  spec.source_files  = "Sources/**/*.{swift}"

  spec.swift_version = "5.10"

  spec.dependency "OpenSSL-Universal", '1.1.2200'
  spec.xcconfig          = { 'OTHER_LDFLAGS' => '-weak_framework CryptoKit -weak_framework CoreNFC -weak_framework CryptoTokenKit' }

  spec.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
  }
  spec.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

end

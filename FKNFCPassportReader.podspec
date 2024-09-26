Pod::Spec.new do |spec|

  spec.name         = "NFCPassportReader"
  spec.version      = "2.1.3-facekom"
  spec.summary      = "This package handles reading an NFC Enabled passport using iOS 13 CoreNFC APIS"

  spec.homepage     = "https://github.com/TechTeamer/NFCPassportReader"
  spec.license      = "MIT"
  spec.author       = { "Name" => "info@techteamer.com" }
  spec.platform = :ios
  spec.ios.deployment_target = "15.0"

  spec.source       = { :git => "https://github.com/TechTeamer/NFCPassportReader.git", :tag => "#{spec.version}" }

  spec.source_files  = "Sources/**/*.{swift}"

  spec.swift_version = "5.5"

  spec.dependency "OpenSSL-Universal", '1.1.2301'
  spec.xcconfig          = { 
    'OTHER_LDFLAGS' => '-weak_framework CryptoKit -weak_framework CoreNFC -weak_framework CryptoTokenKit',
    'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES'
  }


end

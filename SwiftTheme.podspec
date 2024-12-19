Pod::Spec.new do |s|
  s.name         = "SwiftTheme"
  s.version      = "0.0.1"
  s.summary      = "Powerful theme/skin manager for iOS 15+"
  s.homepage     = "https://github.com/phuongddx/SwiftTheme"

  s.license      = 'MIT'
  s.author       = { "Gesen" => "i@gesen.me" }
  s.source       = { :git => "https://github.com/phuongddx/SwiftTheme.git", :tag => s.version.to_s }

  s.ios.deployment_target = "15.0"
  s.requires_arc = true

  s.source_files = 'SwiftTheme/**/*'
  
  s.swift_version = "4.2"
  s.swift_versions = ['4.2', '5.0', '5.1']

end

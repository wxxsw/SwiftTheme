Pod::Spec.new do |s|
  s.name         = "SwiftTheme"
  s.version      = "0.10.1"
  s.summary      = "Powerful theme/skin manager for iOS 9+ 主题/换肤, 夜间模式"
  s.homepage     = "https://github.com/wxxsw/SwiftTheme"

  s.license      = 'MIT'
  s.author       = { "Gesen" => "i@gesen.me" }
  s.source       = { :git => "https://github.com/yuyedaidao/SwiftTheme.git", :tag => s.version.to_s }

  s.ios.deployment_target = "9.0"
  s.tvos.deployment_target = "9.0"
  s.requires_arc = true

  s.source_files = 'Sources'
  
  s.swift_version = "4.2"
  s.swift_versions = ['4.2', '5.0', '5.1']

end

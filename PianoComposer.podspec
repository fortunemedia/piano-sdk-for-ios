Pod::Spec.new do |s|
  s.name         = "PianoComposer"
  s.version      = "2.3.5"
  s.summary      = "Enables iOS apps to use mobile composer by Piano.io"
  s.homepage     = "https://github.com/tinypass/piano-sdk-for-ios"
  s.license      = { :type => "Apache License, Version 2.0", :file => "LICENSE" }
  s.author       = "Piano Inc."
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/tinypass/piano-sdk-for-ios.git", :tag => "#{s.version}" }
  s.vendored_frameworks = "Frameworks/PianoComposer.framework"
end

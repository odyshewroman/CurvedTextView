Pod::Spec.new do |s|
  s.name             = 'CurvedTextView'
  s.version          = '1.0.0'
  s.summary          = 'UI component for drawing curved text'
  s.homepage         = 'https://github.com/odyshewroman/CurvedTextView'
  s.license          = { :type => 'Creative Commons Attribution-ShareAlike', :file => 'LICENSE.md' }
  s.author           = { 'Odyshew Roman' => 'odyshewroman@gmail.com' }
  s.source           = { :git => 'https://github.com/odyshewroman/CurvedTextView.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'
  s.source_files = 'Sources/CurvedTextView/*'
end

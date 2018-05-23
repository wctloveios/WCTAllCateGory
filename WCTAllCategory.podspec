
Pod::Spec.new do |s|

  s.name         = "WCTAllCategory"
  s.version      = "1.0.2"
  s.summary      = "A short description of WCTAllCategory."
  s.description  = <<-DESC
                WCT ALL Category!
                   DESC
  s.homepage     = "https://github.com/wctloveios/WCTAllCateGory"
  s.license      = "MIT"
  s.author       = { "wct" => "wctloveios@163.com" }
  s.platform     = :ios, "8.0"

  s.source_files  = "#{s.name}/**/*.{h,m}"
  s.source       = { :git => "https://github.com/wctloveios/WCTAllCateGory.git", :tag => "1.0.2" }
  s.framework  = "UIKit"

  # 预留
  # s.exclude_files = "Classes/Exclude"
  # s.public_header_files = "Classes/**/*.h"
  # s.resource  = "icon.png"
  #s.resource_bundles  = {'WCTAllCategory' => [#{s.name}/**/*.{}]}
  # s.resources = "Resources/*.png"
  # s.frameworks = "SomeFramework", "AnotherFramework"
  # s.dependency "JSONKit", "~> 1.4"

end

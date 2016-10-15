Pod::Spec.new do |s|
s.name = 'XFLegoVIPER'
s.version = '1.5.1'
s.license = 'MIT'
s.summary = 'A VIPER project engine.'
s.homepage = 'https://github.com/yizzuide/XFLegoVIPER'
s.authors = { 'yizzuide' => 'fu837014586@163.com' }
s.source = { :git => 'https://github.com/yizzuide/XFLegoVIPER.git', :tag => s.version.to_s }
s.requires_arc = true
s.ios.deployment_target = '6.0'
s.source_files = 'XFLegoVIPER/**/*.{h,m}'
end
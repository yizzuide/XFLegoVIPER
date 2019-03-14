Pod::Spec.new do |s|
s.name = 'XFLegoVIPER'
s.version = '4.20.0'
s.license = 'MIT'
s.summary = 'A seamless framework for build app from MVC, MVVM, VIPER (etc.) design pattern in iOS world. (OC & Swift)'
s.homepage = 'https://github.com/yizzuide/XFLegoVIPER'
s.authors = { 'yizzuide' => 'fu837014586@163.com' }
s.source = { :git => 'https://github.com/yizzuide/XFLegoVIPER.git', :tag => s.version.to_s }
s.requires_arc = true
s.ios.deployment_target = '6.0'
s.source_files = 'XFLegoVIPER/**/*.{h,m}'
end
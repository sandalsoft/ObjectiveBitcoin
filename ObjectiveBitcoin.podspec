Pod::Spec.new do |s|
  s.platform     = :osx, '10.8'
  s.name         = 'ObjectiveBitcoin'
  s.version      = '0.1.0'
  s.license      = 'MIT'
  s.homepage     = 'https://github.com/sandalsoft/ObjectiveBitcoin'
  s.authors      = { 'Eric Nelson' => '@sandalsoft' }
  s.summary      = 'Objective-C Wrapper for bitcoind JSON-RPC.'
  s.source       =  {
                      :git => 'https://github.com/sandalsoft/ObjectiveBitcoin.git',
                      :tag=> s.version.to_s
					}
  s.source_files = 'ObjectiveBitcoin/*.{h,m}'
  s.framework    = 'SystemConfiguration'
  s.requires_arc = true
  s.ios.dependency 'AFNetworking'
end

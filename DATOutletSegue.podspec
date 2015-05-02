Pod::Spec.new do |s|
  s.name = 'DATOutletSegue'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'A segue to connect view controllers to their parents in the storyboard'
  s.homepage = 'https://github.com/datinc/DATOutletSegue'
  s.authors = { 'Peter Gulyas' => 'peter@datinc.ca' }
  s.source = { :git => 'https://github.com/datinc/DATOutletSegue.git', :tag => s.version }
  s.ios.deployment_target = '8.0'
  s.source_files = 'DATOutletSegue/*.{m,h}'
  s.requires_arc = true
end

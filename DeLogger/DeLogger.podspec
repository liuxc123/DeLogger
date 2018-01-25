Pod::Spec.new do |s|
  s.name             = 'DeLogger'
  s.version          = '0.1.0'
  s.summary          = 'iOS debugger tool for iOS developer. Display logs, network request, device informations, crash logs while using the app.'
  s.description  = <<-DESC
                    DeLogger is an debugger tool for iOS, with the following features:

                    ● display all app logs in different colors as you like.
                    ● display all app network http requests details, including third-party SDK in app.
                    ● display app device informations and app identity informations.
                    ● display app crash logs.
                    ● filter keywords in app logs and app network http requests.
                    ● app memory real-time monitoring.

                    Welcome to star and fork. If you have any questions, welcome to open issues.
                  DESC

  s.homepage         = 'https://github.com/liuxc123/DeLogger'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liuxc123' => 'lxc_work@126.com' }
  s.source           = { :git => 'https://github.com/liuxc123/DeLogger.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = "Source/Classes/*.swift"
  s.resources = ["Source/Classes/*.xib", "Source/Classes/*.storyboard", "Source/Assets/*.png"]
  s.ios.frameworks = 'UIKit', 'Foundation'
  s.requires_arc = true

end

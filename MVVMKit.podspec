
Pod::Spec.new do |s|

  s.name         = "SwiftMVVMPattern"
  s.version      = "0.9.0"
  s.summary      = "A small framework to adopt MVVM as Design Pattern."

  s.description  = <<-DESC
                    SwiftMVVMPattern allows you to clearify your objects responsability using simple protocol adoption.
                    The main goal is to declare your View Model class and adopt the ViewModel protocol.
                    Your ViewController then will adopt one between ViewModelHolder or ViewModelObserver.
                    Doing this you will move all your unnecessary code from ViewController to the ViewModel
                    and your ViewController will require just to update the views and request actions to its
                    ViewModel.
                    DESC

  s.homepage     = "http://github.com/falcon283/SwiftMVVMPattern"

  s.license      = "MIT"
  s.author       = { "Gabriele Trabucco" => "gabrynet83@gmail.com" }

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  s.source       = { :git => "https://github.com/falcon283/SwiftMVVMPattern.git", :tag => s.version.to_s }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.source_files  = "MVVMKit/Classes/ViewModel/*.{h,m,swift}",
                    "MVVMKit/Classes/View/*.{h,m,swift}"

  s.subspec 'Context' do |ctx|
     ctx.source_files  = "MVVMKit/Classes/Context/*.{h,m,swift}"
  end

  s.subspec 'Presenter' do |prs|
     prs.source_files  = "MVVMKit/Classes/Presenter/*.{h,m,swift}"
  end

  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  s.requires_arc = true

end

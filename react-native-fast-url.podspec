require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))
folly_version = '2021.06.28.00-v2'
folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -Wno-comma -Wno-shorten-64-to-32'


Pod::Spec.new do |s|
  s.name         = "react-native-fast-url"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]
  s.platforms    = { :ios => "13.4" }
  s.source       = { :git => "https://github.com/KusStar/react-native-fast-url.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m,mm}", "cpp/{fast-url,URLHostObjects,utils}.{h,cpp}"
  s.requires_arc = true

  s.dependency "React-Core"
  s.dependency "React-jsi"

  s.compiler_flags = "#{folly_compiler_flags} -DADA_INCLUDE_URL_PATTERN=0"
  s.pod_target_xcconfig = {
    "HEADER_SEARCH_PATHS" => "\"$(PODS_ROOT)/boost\" \"$(PODS_ROOT)/Headers/Private/React-Core\"",
    "CLANG_CXX_LANGUAGE_STANDARD" => "c++20",
    "FASTURL_ADA_OPTIMIZATION[config=Release]" => "-O3"
  }

  s.subspec "Ada" do |ada|
    ada.source_files = "cpp/ada.{h,cpp}"
    ada.compiler_flags = "$(FASTURL_ADA_OPTIMIZATION)"
  end
end

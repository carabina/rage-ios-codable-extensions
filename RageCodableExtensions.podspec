Pod::Spec.new do |s|
    s.name             = "RageCodableExtensions"
    s.summary          = "JSON serialization extensions for Rage"
    s.version          = "0.2.0"
    s.homepage         = "https://github.com/gspd-mobi/rage-ios-codable-extensions"
    s.license          = "MIT"
    s.author           = { "Artem Cherkasov" => "artem.cherkasov@gspd.mobi" }
    s.source           = { :git => "https://github.com/gspd-mobi/rage-ios-codable-extensions.git", :tag => s.version.to_s }

    s.platform     = :ios, "10.0"
    s.requires_arc = true

    s.default_subspec = "Core"

    s.subspec "Core" do |ss|
        ss.source_files = "RageCodableExtensions/Codable/*.swift"
        ss.framework = "Foundation"
        ss.dependency "Rage", "~> 0.14.0"
    end

    s.subspec "RxSwift" do |ss|
        ss.source_files = "RageCodableExtensions/RxSwift/*.swift"
        ss.dependency "RageCodableExtensions/Core"
        ss.dependency "Rage/RxSwift", "~> 0.14.0"
    end
end

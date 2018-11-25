
Pod::Spec.new do |s|

  s.name         = "CMTextView"
  s.version      = "1.0.0"
  s.summary      = "UITextView subclass with placeholder text."
  s.description  = "CMTextView is an UITextView subclass which provides the placeholder text functionality."
  s.homepage     = "https://github.com/Code-Mafia/CMTextView.git"
  s.license      = "MIT"

  s.author              = { "Rajmani Kushwaha" => "rajmanikush@gmail.com" }
  #s.social_media_url   = "https://www.linkedin.com/in/rajmanikush/"

  s.platform     = :ios, "11.0"
  s.source       = { :git => "https://github.com/Code-Mafia/CMTextView.git", :tag => "1.0.1" }

  s.source_files  = "CMTextView/*"

end

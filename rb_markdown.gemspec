Gem::Specification.new do |s|
  s.name            = "rb_markdown"
  s.version         = "0.2.3"
  s.summary         = "A tiny markdown engine"
  s.authors         = ["Aurélien Delogu"]
  s.email           = "aurelien.delogu@gmail.com"
  s.files           = Dir["src/**/*.rb"]
  s.require_paths   = ["src"]
  s.add_dependency  "rb_monkey", "~> 0.1.0"
  s.add_dependency  "rouge", "~> 3.30"
end

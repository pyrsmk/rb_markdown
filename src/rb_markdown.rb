require "rb_monkey"

Dir.glob(
  File.join(__dir__, "markdown", "*.rb"),
  &method(:require)
)

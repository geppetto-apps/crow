require "compiler/crystal/syntax/virtual_file.cr"
require "compiler/crystal/syntax/exception.cr"
require "compiler/crystal/syntax/parser.cr"

require "./crow/*"

module Crow
  include Crow::Basic
  include Crow::Vars
  include Crow::Symbol
  include Crow::Literals
  include Crow::Conditionals
  include Crow::Expressions
  include Crow::TemplateString
  include Crow::Functions
  include Crow::Classes
  include Crow::Formatting
  extend self

  def convert(crystal_source_code)
    parser = Crystal::Parser.new(crystal_source_code)
    node = Crystal::Expressions.from(parser.parse)
    transpile node
  end
end

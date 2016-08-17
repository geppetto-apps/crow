require "compiler/crystal/syntax/virtual_file.cr"
require "compiler/crystal/syntax/exception.cr"
require "compiler/crystal/syntax/parser.cr"
require "logger"

require "./crow/*"

module Crow
  include Crow::Core
  include Crow::Vars
  include Crow::Types
  include Crow::Symbol
  include Crow::Literals
  include Crow::Conditionals
  include Crow::Expressions
  include Crow::TemplateString
  include Crow::Functions
  include Crow::Exceptions
  include Crow::Classes
  include Crow::Formatting
  extend self

  @@logger = Logger.new(STDERR)
  @@logger.level = Logger::ERROR
  @@strict = false

  def convert(crystal_source_code)
    parser = Crystal::Parser.new(crystal_source_code)
    node = Crystal::Expressions.from(parser.parse)
    transpile node
  end

  def logger
    @@logger
  end

  def logger=(logger)
    @@logger = logger
  end

  def strict=(strict)
    @@strict = strict
  end

  def log_fallback_usage(node)
    if @@strict
      raise "Fallback is not allowed in strict mode. " \
      "Attempted to transpile a node of type #{node.class}."
    else
      logger.info "Using fallback for node with type #{node.class}."
    end
  end
end

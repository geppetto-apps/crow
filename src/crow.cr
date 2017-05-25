require "compiler/crystal/syntax/virtual_file.cr"
require "compiler/crystal/syntax/exception.cr"
require "compiler/crystal/syntax/parser.cr"
require "logger"

require "./crow/*"

macro read_prelude
  path = File.expand_path("../prelude.js", __FILE__)
  File.read(path)
end

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
  include Crow::Macros
  include Crow::Formatting
  include Crow::Loops
  extend self

  PRELUDE = read_prelude

  @@logger = Logger.new(STDERR)
  @@logger.level = Logger::ERROR
  @@strict = false

  def convert(crystal_source_code, prelude = false)
    parser = Crystal::Parser.new(crystal_source_code)
    node = Crystal::Expressions.from(parser.parse)
    result = ""
    result += PRELUDE if prelude
    result += transpile(node).strip
    result
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
      raise "Fallback is not allowed in strict mode. \
             Attempted to transpile a node of type #{node.class}."
    else
      logger.info "Using fallback for node with type #{node.class}."
    end
  end

  CONTEXTS = [:top]

  private def context(context, &blk)
    CONTEXTS.push context
    result = yield
    CONTEXTS.pop
    result
  end

  private def context?(context)
    CONTEXTS.last == context
  end
end

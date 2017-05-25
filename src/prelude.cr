class RuntimeError
  def initialize(message : String)
    @_message = message
  end

  def message
    @_message
  end
end

Crow = {
  RuntimeError: RuntimeError,
}

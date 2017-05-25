(function () {
  class RuntimeError {
    constructor(message) {
      this._message = message;
    }

    message() {
      return this._message;
    }
  }

  global.Crow = {
    RuntimeError: RuntimeError,
  };
}());

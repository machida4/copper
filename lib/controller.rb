class Controller
  attr_reader :name, :action
  attr_accessor :status, :body

  def initialize(name: nil, action: nil)
    @name = name
    @action = action
  end

  def call(action)
    send(action)
    self.status = 200
    self.body = "Hello world"
    self
  end

  def not_found
    self.status = 404
    self.body = "Nothing found"
    self
  end

  def internal_error
    self.status = 500
    self.body = "Internal error"
    self
  end
end
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
    self.body = "404 Not Found"
    self
  end

  def internal_error
    self.status = 500
    self.body = "500 Internal Server Error"
    self
  end
end
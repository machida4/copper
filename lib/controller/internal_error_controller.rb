require_relative "template.rb"

class InternalErrorController < Controller::Template
  def call()
    # send(action)
    self.status = 500
    self.body = "500 Internal Server Error"
    self
  end
end

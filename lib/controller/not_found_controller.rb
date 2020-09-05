require_relative "template.rb"

class NotFoundController < Controller::Template
  def call()
    # send(action)
    self.status = 404
    self.body = "404 Not Found"
    self
  end
end

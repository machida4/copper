class InternalErrorController < Controller::Template
  def call(action)
    # send(action)
    self.status = 500
    self.body = "500 Internal Server Error"
    self
  end
end

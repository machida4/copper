class NotFoundController < BaseController
  def call(action)
    # send(action)
    self.status = 404
    self.body = "404 Not Found"
    self
  end
end
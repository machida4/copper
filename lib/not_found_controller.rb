class NotFoundController < BaseController
  def call(action)
    send(action)
    self.status = 404
    self.body = "404 Not Found"
    self
  end

  def not_found
    # none
  end
end
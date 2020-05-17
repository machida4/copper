class TopController < BaseController
  def index
    @users = User.all
  end
end

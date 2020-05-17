class TopController < BaseController
  def index
    binding.pry
    @users = User.all
  end
end

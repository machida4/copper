class TopController < Controller::Template
  def index
    @users = User.all
  end
end

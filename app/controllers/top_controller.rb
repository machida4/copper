class TopController < Controller::Template
  def index
    @users = User.all
  end

  def create
    return false if params[:name].nil? || params[:group].nil?

    User.insert(name: params[:name], group: params[:group])
    redirect(to: "/top")
  end
end

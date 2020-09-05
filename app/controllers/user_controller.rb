class UserController < Controller::Template
  def index
    @users = User.all
  end

  def create
    return false if params[:name].nil? || params[:group].nil?

    User.insert(name: params[:name], group: params[:group])

    redirect(to: "/users")
  end

  def show
    id = match_params[:id]
    @user = User.first(id: id)
  end

  def destroy
    id = match_params[:id]
    User.first(id: id).destroy

    redirect(to: "/users")
  end
end

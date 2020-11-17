class UsersController <ApplicationController
  before_action :set_user ,only: [:show ,:edit ,:update]
  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 2)
  end
  def index
    @user = User.paginate(page: params[:page], per_page: 2)
  end
  def new
    @user= User.new
  end
  def edit

  end
  def update

    if @user.update(user_params)
      flash[:notice] = "Welcome to the Alpha Blog #{@user.username}, you have successfully Updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id]=@user.id #this is to keep the user logged in the user page after sign up!!!!
      flash[:notice] = "Welcome to the Alpha Blog #{@user.username}, you have successfully signed up"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
def set_user
  @user = User.find(params[:id])
end
end
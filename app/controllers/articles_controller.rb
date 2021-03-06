class ArticlesController < ApplicationController
 before_action :set_article, only: [:show, :edit, :update, :destroy]
 before_action :require_user,except: [:show, :index]
 before_action :require_same_user, only:[:edit,:update,:destroy]


   def index
     @articles = Article.paginate(page: params[:page], per_page: 5)
   end


  def show

  end


   def new
    @article = Article.new
   end

   def edit

   end

  def create
    @article = Article.new(article_params)
    @article.user=current_user
    if @article.save
      flash[:notice]=" successfully saved!!!"
      redirect_to @article
    else
      render 'new'

    end
   end

   def update

     if @article.update(article_params)
       flash[:notice] = "Article was updated successfully."
       redirect_to article_path
     else
       render 'edit'
     end
  end

  def destroy
    @article.destroy
    redirect_to @article

  end

  private
    def set_article
      @article = Article.find(params[:id])
    end


    def article_params
      params.require(:article).permit(:title, :description, category_ids: [])
    end
  def require_same_user
    if current_user!=@article.user && !current_user.admin?
      flash[:alert]=" you can edit and delete only in your account "
      redirect_to @article
    end
  end
end

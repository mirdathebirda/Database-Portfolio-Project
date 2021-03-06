class PostsController < ApplicationController
  def show
    @post = Post.find_by_sql("SELECT * FROM post where id = #{params[:id]};").first
  end

  def new
  end

  def index
  @posts = Post.all
  if params[:search]
    @posts = Post.search(params[:search])
  else
    @posts = Post.all
  end
end

  def create
    if post_params[:title].blank? || post_params[:body].blank?
      render(json: "Error: blank entries") and return
    end

    cols = post_params.keys.join(", ")
    vals = post_params.values.map{|val| %Q(#{Post.sanitize(val)})}.join(", ")
    Post.connection.execute("INSERT INTO post (author, blog, #{cols}, date) VALUES (#{current_user.id}, #{params[:blog_id]}, #{vals}, #{Post.sanitize(Time.now)});")
    post = Post.find_by_sql("SELECT * FROM post WHERE author = #{current_user.id} ORDER BY id DESC LIMIT 1;").first
    redirect_to "/blogs/#{params[:blog_id]}/posts/#{post.id}"
  end

  def edit
    @post = Post.find_by_sql("SELECT * FROM post where id = #{params[:id]};").first
  end

  def update
    if post_params[:title].blank? || post_params[:body].blank?
      render(json: "Error: blank entries") and return
    end

    updates = post_params.map{|k, v| [%Q(#{k}=#{Post.sanitize(v)})]}.join(", ")
    Post.connection.execute("UPDATE post SET #{updates} WHERE id = #{params[:id]};")
    redirect_to "/blogs/#{params[:blog_id]}/posts/#{params[:id]}"
  end

  def destroy
    Post.connection.execute("DELETE FROM post WHERE id = #{params[:id]};")
    redirect_to "/blogs/#{params[:blog_id]}"
  end

private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end

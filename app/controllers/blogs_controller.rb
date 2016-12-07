class BlogsController < ApplicationController
#shows ONE blog page
  def show
    page_size = 6
    unless params[:page]
      params[:page] = 1
    end

    @blog = Blog.find_by_sql("SELECT * FROM blog where id = #{params[:id]};").first
    @posts = Post.find_by_sql "SELECT * FROM post WHERE blog = #{@blog.id} LIMIT #{(params[:page].to_i - 1) * page_size}, #{page_size + 1};"

    if params[:search]
      @posts = Post.search(params[:search], @blog.id, page_size, params[:page].to_i)
    end

    @has_prev = params[:page].to_i > 1
    @has_next = @posts.length > page_size
    @posts = @posts[0...page_size]
  end

#for manage and browse blogs
  def index
    page_size = 6
    unless params[:page]
      params[:page] = 1
    end

    if params[:user_id]
      @blogs = Blog.find_by_sql "SELECT * FROM blog WHERE owner = #{params[:user_id]} AND visible = true LIMIT #{(params[:page].to_i - 1) * page_size}, #{page_size + 1};"
    else
      @blogs = Blog.find_by_sql "SELECT * FROM blog WHERE visible = true LIMIT #{(params[:page].to_i - 1) * page_size}, #{page_size + 1};"
    end
    @has_prev = params[:page].to_i > 1
    @has_next = @blogs.length > page_size
    @blogs = @blogs[0...page_size]
  end

  def new
  end

  def create
    if blog_params[:title].blank? || blog_params[:description].blank?
      render(json: "Error: blank entries") and return
    end

    cols = blog_params.keys.join(", ")
    vals = blog_params.values.map{|val| %Q(#{Blog.sanitize(val)}) }.join(", ")
    Blog.connection.execute("INSERT INTO blog (owner, #{cols}) VALUES (#{current_user.id}, #{vals});")
    blog = Blog.find_by_sql("SELECT * FROM blog WHERE owner = #{current_user.id} ORDER BY id DESC LIMIT 1;").first
    redirect_to "/blogs/#{blog.id}"
  end

  def edit
    @blog = Blog.find_by_sql("SELECT * FROM blog where id = #{params[:id]};").first
  end

  def update
    if blog_params[:title].blank? || blog_params[:description].blank?
      render(json: "Error: blank entries") and return
    end
    
    updates = blog_params.map{|k, v| [%Q(#{k}=#{Blog.sanitize(v)})]}.join(", ")
    Blog.connection.execute("UPDATE blog SET #{updates} WHERE id = #{params[:id]};")
    redirect_to "/blogs/#{params[:id]}"
  end

  def destroy
    Blog.connection.execute("UPDATE blog SET visible=false WHERE id = #{params[:id]};")
    redirect_to "/blogs"
  end

private

  def blog_params
    params.require(:blog).permit(:title, :description)
  end
end

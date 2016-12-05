class CommentsController < ApplicationController

    def create
      cols = comment_params.keys.join(", ")
      vals = comment_params.values.map{|val| %Q(#{Comment.sanitize(val)})}.join(", ")
      Comment.connection.execute("INSERT INTO comment (author, post, #{cols}, date) VALUES (#{current_user.id}, #{params[:post_id]}, #{vals}, #{Comment.sanitize(Time.now)});")
      redirect_to "/blogs/#{params[:blog_id]}/posts/#{params[:post_id]}"
    end


    def update
      updates = comment_params.map{|k, v| [%Q(#{k}=#{Comment.sanitize(v)})]}.join(", ")
      Comment.connection.execute("UPDATE comment SET #{updates} WHERE id = #{params[:id]};")
      redirect_to "/blogs/#{params[:blog_id]}/posts/#{params[:post_id]}"
    end

    def destroy
      Comment.connection.execute("DELETE FROM comment WHERE id = #{params[:id]};")
      redirect_to "/blogs/#{params[:blog_id]}/posts/#{params[:post_id]}"

    end

    #to package up data for the comment form
    private
    def comment_params
      params.require(:comment).permit(:text)
    end
end

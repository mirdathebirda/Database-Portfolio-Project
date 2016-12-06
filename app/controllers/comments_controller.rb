class CommentsController < ApplicationController

    def create
      if comment_params[:text].blank?
        render(json: "Error: Please write something") and return
      end

      cols = comment_params.keys.join(", ")
      vals = comment_params.values.map{|val| %Q(#{Comment.sanitize(val)})}.join(", ")
      if current_user.nil?
        user = User.create(name: 'Anonymous', password: 'password123')
        Comment.connection.execute("INSERT INTO comment (author, post, #{cols}, date) VALUES (#{user.id}, #{params[:post_id]}, #{vals}, #{Comment.sanitize(Time.now)});")
      else
        Comment.connection.execute("INSERT INTO comment (author, post, #{cols}, date) VALUES (#{current_user.id}, #{params[:post_id]}, #{vals}, #{Comment.sanitize(Time.now)});")
      end
      redirect_to :back
    end

    def update
      if comment_params[:text].blank?
        render(json: "Error: Please write something") and return
      end

      updates = comment_params.map{|k, v| [%Q(#{k}=#{Comment.sanitize(v)})]}.join(", ")
      Comment.connection.execute("UPDATE comment SET #{updates} WHERE id = #{params[:id]};")
      redirect_to :back
    end

    def destroy
      Comment.connection.execute("DELETE FROM comment WHERE id = #{params[:id]};")
      redirect_to :back
    end

private

    def comment_params
      params.require(:comment).permit(:text)
    end
end

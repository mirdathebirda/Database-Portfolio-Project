class StarsController < ApplicationController

  before_filter :authorize

  def star
    stars = Star.find_by_sql("SELECT * FROM star WHERE user = #{current_user.id} AND post = #{params[:post_id]};")
    if stars.empty?
      Star.connection.execute("INSERT INTO star (user, post) VALUES (#{current_user.id}, #{params[:post_id]});")
    else
      Star.connection.execute("UPDATE star SET starred=true WHERE id = #{stars.first.id};")
    end

    # See migrations, this should have been a trigger if clearDB supported them
    Star.connection.execute "UPDATE post SET star_count = (SELECT COUNT(*)
              FROM star
              WHERE star.post = post.id
              AND starred = true) WHERE id = #{params[:post_id].to_i};"
    redirect_to :back
  end

  def unstar
    Star.connection.execute("UPDATE star SET starred=false WHERE user = #{current_user.id} AND post = #{params[:post_id]};")
    
    # See migrations, this should have been a trigger if clearDB supported them
    Star.connection.execute "UPDATE post SET star_count = (SELECT COUNT(*)
              FROM star
              WHERE star.post = post.id
              AND starred = true) WHERE id = #{params[:post_id].to_i};"
    redirect_to :back
  end
end


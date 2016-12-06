class StarsController < ApplicationController

  before_filter :authorize

  def star
    star = Star.find_by_sql("SELECT * FROM star WHERE user = #{current_user.id} AND post = #{params[:post_id]};")
    if star.empty?
      Star.connection.execute("INSERT INTO star (user, post) VALUES (#{current_user.id}, #{params[:post_id]});")
    else
      Star.connection.execute("UPDATE star SET starred=true WHERE id = #{star.first.id};")
    end
    redirect_to :back
  end

  def unstar
    Star.connection.execute("UPDATE star SET starred=false WHERE user = #{current_user.id} AND post = #{params[:post_id]};")
    redirect_to :back
  end
end


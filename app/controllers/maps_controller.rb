class MapsController < ApplicationController
  def index
    @posts = Post.all
    @hash = Gmaps4rails.build_markers(@post) do |post, marker|
      marker.lat post.latitude
      marker.lng post.longitude
      marker.infowindow post.description
    end
  end
end
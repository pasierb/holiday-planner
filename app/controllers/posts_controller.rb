class PostsController < ApplicationController
  before_filter :find_post, :only => :show
 
  def index
    @posts = Post.all( :order => ["posts.created_at DESC"], :conditions => { :locale => I18n.locale } )
  end

  def show
  end

protected

  def find_post
    @post = Post.find_by_permalink_and_locale( params[:permalink], I18n.locale )
    unless @post
      redirect_to posts_path
    end
  end

end

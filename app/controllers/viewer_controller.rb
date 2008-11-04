class ViewerController < ApplicationController
  
  def show
    @page = Page.find_by_name(params[:name])
    @subpages = @page.subpages
    @pagetitle = @page.title
    @pageComments = @page.comments
    @comment = Comment.new(params[:comment])
    @comment.page_id = @page.id
    @comment.display = false
    if request.post?
    if @comment.save
        flash[:notice] = "hello"
        redirect_to :action => 'show'
    end    
    end
    login_required if @page.admin?
  end
  
  def get_unformatted_text
    @page = Page.find(params[:id])
    render :text => @page.body(:source)
  end
  
  def set_page_body
    @page = Page.find(params[:id])
    @page.update_attribute(:body, params[:value])
    render :text => @page.body
  end
  
end

class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create 
    @comment = Comment.new(comment_params)

    if @comment.save 
      @comment = @comment.attributes.merge(
        'poster' => @comment.user.username,
        'image' => url_for(@comment.user.image)
      )
      render json: @comment 
    else
      render json: { msg: 'Something went wrong!', type: 'err' }
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update 
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      render json: @comment 
    else
      render json: { msg: 'Something went wrong!', type: 'err' }
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :user_id, :body)
  end

end
class Api::TwatsController < ApplicationController

  def get_all_twats
    twat_preload = Twat.all.includes(:user).order(created_at: :desc)
    @twats = twat_preload.map do |twat|
      twat.attributes.merge(
        'poster' => twat.user.username
      )
    end
    render json: @twats
  end

  def twat_exists
    @like = Twat.find_by(id: params[:id]).likes.where('user_id = ? AND twat_id = ?', params[:user_id], params[:id])

    if @like
      render json: @like, status: 200
    else
      render body: nil, status: 404
    end
  end

  def home_twats
    current_user = User.find(params[:id])
    return unless current_user
    
    main_preload = Twat.where(user_id: current_user.id ).includes(:user).order(created_at: :desc)
    @twats = main_preload.map do |twat|
      if twat.media.attached?
        twat.attributes.merge(
          'poster' => twat.user.username,
          'image' =>  url_for(twat.user.image),
          'media' => url_for(twat.media),
          'media_type' => twat.media.content_type
        )
      else
        twat.attributes.merge(
          'poster' => twat.user.username,
          'image' =>  url_for(twat.user.image)
        )
      end
    end

    current_user.follows.each do |f|
      preload = Twat.where(user_id: f.followee_id).includes(:user).order(created_at: :desc)
                    
      user_twats = preload.map do |twat|
        if twat.media.attached?
          twat.attributes.merge(
            'poster' => twat.user.username,
            'image' =>  url_for(twat.user.image),
            'media' => url_for(twat.media),
            'media_type' => twat.media.content_type
          )
        else
          twat.attributes.merge(
            'poster' => twat.user.username,
            'image' =>  url_for(twat.user.image)
          )
        end
      end
      user_twats.each { |twat| @twats << twat }
    end
    
    if @twats
      render json: @twats, status: 200
    else
      render json: {"error" => "#{current_user.username}, please follow another user to see posts on your timeline!"}, status: 404
    end
  end

  def get_twat
    first_fetch = Twat.includes(:user).find(params[:id])
    @twat = first_fetch.attributes.merge(
      'poster' => first_fetch.user.username,
      'image' => url_for(first_fetch.user.image)
    )
    render json: @twat
  end

  def get_twat_comments
    @twat = Twat.find(params[:id])
    comment_fetch = @twat.comments.order(created_at: :desc)
    @comments = comment_fetch.map do |comment|
      comment.attributes.merge(
        'image' => url_for(comment.user.image),
        'poster' => comment.user.username
      )
    end
    render json: @comments
  end

  def get_twat_stats
    @twat = Twat.includes(:comments, :likes).find(params[:id])
    render json: { likes: @twat.likes.count, comments: @twat.comments.count }
  end

end
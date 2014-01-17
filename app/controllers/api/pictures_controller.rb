class Api::PicturesController < ApplicationController

  skip_before_action :verify_authenticity_token

  respond_to :json

  # POST
  # 画像アップロード
  def upload
    picture = Picture.find_or_initialize_by( user_id: current_user.id, upid: params[:upid] )

    begin
      picture.store_files params[:file]
    rescue Exception => e
      return render_error "ディレクトリへのアップロードに失敗しました。"
    end

    picture.description   = params[:description]
    picture.num_of_images = params[:num_of_images].to_i

    if picture.save
      render :status => 200,
             :json => {
               :success => true,
               :message => "正常に登録しました。"
             }
    else
      render_error "更新処理で失敗しました。"
    end
  end


  private

  def render_error message
    render :status => 417,
           :json => {
             :success => false,
             :message => message
           }

  end

end
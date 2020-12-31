class ImagesController < ApplicationController
  def index
    images = params[:tag].present? ? Image.tagged_with(params[:tag]) : Image.all
    @images = images.order(created_at: :desc)
  end

  def show
    @image = Image.find(params[:id])
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(create_image_params)

    @image.save!
    redirect_to @image
  rescue StandardError
    render :new
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    redirect_to images_path
  end

  def edit
    @image = Image.find(params[:id])
  end

  def update
    @image = Image.find(params[:id])

    @image.update!(update_image_params)
    redirect_to @image
  rescue ActiveRecord::RecordInvalid
    render :edit
  end

  private

  def create_image_params
    params.require(:image).permit(:name, :url, :tag_list)
  end

  def update_image_params
    params.require(:image).permit(:tag_list)
  end
end

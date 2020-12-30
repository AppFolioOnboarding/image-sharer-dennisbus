require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get images_url
    assert_response :success
  end

  test 'should get new' do
    get new_image_url
    assert_response :success
  end

  test 'should create image' do
    post images_url, params: { image: { name: 'ruby icon',
                                        url: 'https://tttlabs.ro/wp-content/uploads/2018/03/blog_ruby3_logo.png',
                                        tag_list: 'ruby' } }
    assert_redirected_to image_url(Image.last)
  end

  test 'should show image' do
    @image = images(:two)
    get image_url(@image)
    assert_response :success
  end

  test 'should get images with tag' do
    post images_url, params: { image: { name: 'ruby icon',
                                        url: 'https://tttlabs.ro/wp-content/uploads/2018/03/blog_ruby3_logo.png',
                                        tag_list: 'ruby' } }

    get images_url(tag: 'ruby')
    assert_select 'ul' do
      assert_select 'li', 1 # one li found for the new tag 'ruby'
    end
  end

  test 'should delete image' do
    @image = images(:two)
    assert_difference('Image.count', -1) do
      delete image_url(@image)
    end

    assert_redirected_to images_url
  end

  def test_edit_image_tag
    @image = images(:two)
    get edit_image_url(@image.id)
    assert_response :success
    assert_select('#header', 'Edit Image Tags:')
  end

  def test_update_image_tag_success
    @image = images(:two)
    assert_equal('MyString', @image.name)

    img_name = 'twoImg'
    img_url = 'https://www.goog.com/2020.png'
    img_tag = 'tag for two'
    image_params = { name: img_name, url: img_url, tag_list: img_tag }
    put image_path(@image.id), params: { image: image_params }

    assert_redirected_to image_url(@image)
    @image.reload

    assert_equal([img_tag], @image.tag_list)
    assert_equal(img_name, @image.name)
    assert_equal(img_url, @image.url)
  end

  def test_update_image_tag_fail
    @image = images(:two)

    img_name = 'twoImg'
    img_url = 'https://'
    img_tag = 'tag for two'
    image_params = { name: img_name, url: img_url, tag_list: img_tag }
    put image_path(@image.id), params: { image: image_params }

    assert_select('#header', 'Edit Image Tags:') # validation failed on url and redirect to edit page
  end
end

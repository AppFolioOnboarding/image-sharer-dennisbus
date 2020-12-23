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
end

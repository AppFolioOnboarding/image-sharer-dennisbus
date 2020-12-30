require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  url_error_mesg = 'Url please enter a valid HTTP url path'

  test 'should not save image without name' do
    image = Image.new
    assert_not image.save
  end

  test 'missing name field error message' do
    image = Image.new
    image.url = 'http://www.google.com/12345.png'
    image.save
    assert_includes(image.errors.full_messages, "Name can't be blank")
  end

  test 'should not save image without url' do
    image = Image.new
    image.name = 'fav img'
    assert_not image.save
    assert_includes(image.errors.full_messages, "Url can't be blank")
    assert_includes(image.errors.full_messages, url_error_mesg)
  end

  test 'should not save image without valid url' do
    image = Image.new
    image.name = 'fav img'
    image.url = 'invalid url path'
    assert_not image.save
    assert_includes(image.errors.full_messages, url_error_mesg)
  end

  test 'should not save image without http url' do
    image = Image.new
    image.name = 'fav img'
    image.url = 'www.google.com/12345.png'
    assert_not image.save
    assert_includes(image.errors.full_messages, url_error_mesg)
  end

  test 'save image successfully' do
    db_size = Image.all.size
    image = Image.new
    img_name = 'fav img'
    image.name = img_name
    img_url = 'http://www.google.com/12345.png'
    image.url = img_url
    image.tag_list = 'test'
    assert image.save
    assert_empty(image.errors.full_messages) # no error mesg

    # Image stored in database
    assert_equal(Image.all.size, db_size + 1)
    assert_not_nil(Image.find(image.id))
    assert_equal(Image.find(image.id).name, img_name)
    assert_equal(Image.find(image.id).url, img_url)
    assert_equal(Image.find(image.id).tag_list.count, 1)
  end

  test 'should not save image without tag' do
    image = Image.new
    image.name = 'fav img'
    image.url = 'http://www.google.com/12345.png'
    assert_not image.save
    assert_includes(image.errors.full_messages, "Tag list can't be blank")
  end

  test 'save image with tags' do
    image = Image.new
    img_name = 'fav img tags'
    image.name = img_name
    img_url = 'http://www.google.com/678.png'
    image.url = img_url
    tag_list = 'num6, num7, num8'
    image.tag_list = tag_list
    assert image.save
    assert_empty(image.errors.full_messages) # no error mesg

    # Image stored in database
    assert_not_nil(Image.find(image.id))
    assert_equal(Image.find(image.id).tag_list, tag_list.split(', '))
  end

  test 'retrieve image with tags' do
    find_images = Image.tagged_with('rails')
    assert_equal 0, find_images.size # before adding the tag

    image = Image.new
    img_name = 'ruby rail'
    image.name = img_name
    image.url = 'http://www.google.com/678.png'
    image.tag_list = 'ruby, rails'
    assert image.save

    find_images = Image.tagged_with('rails')
    assert_equal 1, find_images.size # after adding the tag
  end

  test 'destroy image' do
    image = images(:two)
    assert_equal 'MyString', image.name

    assert_difference('Image.count', -1) do
      image.destroy
    end
  end

  def test_update_img_tag
    image = images(:two)
    img_name = 'fav img'
    image.name = img_name
    img_url = 'http://www.google.com/12345.png'
    image.url = img_url
    img_tag = 'ruby, rails'
    image.tag_list = img_tag

    assert image.save
    assert_predicate(image, :valid?)
    assert_empty(image.errors.full_messages) # no error mesg
    assert_equal(img_tag.split(', '), image.tag_list)
  end
end

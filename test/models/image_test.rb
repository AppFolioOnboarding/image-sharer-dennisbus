require 'test_helper'

class ImageTest < ActiveSupport::TestCase

  test "should not save image without name" do
	  image = Image.new
	  assert_not image.save
  end

  test "missing name field error message" do
	  image = Image.new
	  image.url = "http://www.google.com/12345.png"
	  image.save
	  assert_equal(image.errors.full_messages, ["Name can't be blank"], "")
  end

  test "should not save image without url" do
	  image = Image.new
	  image.name = "fav img"
	  assert_not image.save
	  assert_equal(image.errors.full_messages, ["Url can't be blank", "Url please enter a valid HTTP url path"], "")
  end

  test "should not save image without valid url" do
	  image = Image.new
	  image.name = "fav img"
	  image.url = "invalid url path"
	  assert_not image.save
	  assert_equal(image.errors.full_messages, ["Url please enter a valid HTTP url path"], "")
  end

  test "should not save image without http url" do
	  image = Image.new
	  image.name = "fav img"
	  image.url = "www.google.com/12345.png"
	  assert_not image.save
	  assert_equal(image.errors.full_messages, ["Url please enter a valid HTTP url path"], "")
  end

  test "save image successfully" do
  	  dbSize = Image.all.size
	  image = Image.new
	  imgName = "fav img"
	  image.name = imgName
	  imgUrl = "http://www.google.com/12345.png"
	  image.url = imgUrl
	  assert image.save
	  assert_empty(image.errors.full_messages, "")	#no error mesg

	  #Image stored in database
	  assert_equal(Image.all.size, dbSize + 1)
	  assert_not_nil(Image.find(image.id))
	  assert_equal(Image.find(image.id).name, imgName)
	  assert_equal(Image.find(image.id).url, imgUrl)
  end

end

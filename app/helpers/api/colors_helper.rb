module Api::ColorsHelper

  def valid_color?(color)
    color_object = Color.new(color)

    color_object.rgb? || color_object.hex?
  end

  def complementary
    { color: "##{SecureRandom.hex(3)}" }
  end

  def triadic; end

  def tetradic; end

  def analogous; end

  def split_complementary; end

end

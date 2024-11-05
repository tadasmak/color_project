module Api::ColorsHelper
  
  def complementary
    { color: "##{SecureRandom.hex(3)}" }
  end

  def triadic; end

  def tetradic; end

  def analogous; end

  def split_complementary; end

end

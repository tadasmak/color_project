module Api::ColorsHelper
  def complementary
    { color: "##{SecureRandom.hex(3)}" }
  end
end

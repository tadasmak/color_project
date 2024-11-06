class Color
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def hex?
    color.is_a?(String) && color.match?(/^#[0-9a-fA-F]{6}$/)
  end

  def rgb?
    color.is_a?(String) && color.match?(/^rgb\(\s*(\d{1,3})\s*,\s*(\d{1,3})\s*,\s*(\d{1,3})\s*\)$/)
  end

  def rgb_array
    if hex?
      hex_elements = hex.gsub('#', '').scan(/../)
      r, g, b = hex_elements.map(&:hex)
    elsif rgb?
      rgb_elements = color.gsub('rgb(', '').gsub(')', '').split(',').map(&:strip).map(&:to_i)
      r, g, b = rgb_elements if rgb_elements.length == 3
    end

    return { r:, g:, b: }
  end

  def hex
    return color if hex?

    if rgb?
      r, g, b = rgb_array.map { |color| color.to_s(16) }
      return "##{r}#{g}#{b}"
    end
      
    nil
  end

  def rgb
    return color if rgb?

    if hex?
      r, g, b = rgb_array
      return "rgb(#{r}, #{g}, #{b})"
    end

    nil
  end
end
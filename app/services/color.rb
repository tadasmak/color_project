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

  def hex
    return color if hex?

    if rgb?
      rgb_values = color.gsub('rgb(', '').gsub(')', '').split(',').map(&:strip).map(&:to_i).map { |color| color.to_s(16) }
      r, g, b = rgb_values if rgb_values.length == 3

      return "##{r}#{g}#{b}"
    else
      nil
    end
  end

  def rgb
    return color if rgb?

    if hex?
      hex_values = color.gsub('#', '').scan(/../)
      r, g, b = hex_values.map(&:hex)
      
      return "rgb(#{r}, #{g}, #{b})"
    else
      nil
    end
  end
end
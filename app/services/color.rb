class Color
  attr_reader :color

  def initialize(color)
    @color = color
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

    return [r, g, b]
  end

  def hsl_array
    r, g, b = rgb_array

    r /= 255.0;
    g /= 255.0;
    b /= 255.0;
    
    max = [r, g, b].max
    min = [r, g, b].min

    chroma = max - min
    hue, saturation = 0

    if chroma > 0
      case max
      when r
        hue = ((g - b) / chroma) % 6
      when g
        hue = (b - r) / chroma + 2
      when b
        hue = (r - g) / chroma + 4
      end
    end

    hue = (hue * 60).round
    hue += 360 if hue < 0

    luminance = (max + min) / 2
    saturation = chroma / (1 - (2 * luminance - 1).abs) if chroma > 0

    saturation = (saturation * 100).round(1)
    luminance = (luminance * 100).round(1)

    [hue, saturation, luminance]
  end

  
end
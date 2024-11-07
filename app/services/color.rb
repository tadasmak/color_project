class Color
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def hex
    return color if hex?

    if rgb?
      a, b, c = rgb_to_hex
    elsif hsl?
      r, g, b = hsl_to_rgb
      a, b, c = rgb_to_hex([r, g, b])
    end

    "##{a}#{b}#{c}" if a && b && c

    nil
  end

  def rgb
    return color if rgb?

    r, g, b = hsl_to_rgb if hsl?
    r, g, b = hex_to_rgb if hex?

    "rgb(#{r}, #{g}, #{b})" if r && g && b

    nil
  end

  def hsl
    return color if hsl?

    if rgb?
      h, s, l = rgb_to_hsl
    elsif hex?
      r, g, b = hex_to_rgb
      h, s, l = rgb_to_hsl([r, g, b])
    end

    "hsl(#{h}, #{s}%, #{l}%)" if h && s && length

    nil
  end

  def hex?
    color.is_a?(String) && color.match?(/^#[0-9a-fA-F]{6}$/)
  end

  def rgb?
    color.is_a?(String) && color.match?(/^rgb\(\s*(\d{1,3})\s*,\s*(\d{1,3})\s*,\s*(\d{1,3})\s*\)$/) &&
    $1.to_i.between?(0, 255) &&
    $2.to_i.between?(0, 255) &&
    $3.to_i.between?(0, 255)
  end

  def hsl?
    color.is_a?(String) && color.match?(/^hsl\(\s*(\d{1,3})\s*,\s*(\d{1,3})%\s*,\s*(\d{1,3})%\s*\)$/) &&
    $1.to_i.between?(0, 360) &&
    $2.to_i.between?(0, 100) &&
    $3.to_i.between?(0, 100)
  end

  def rgb_array
    rgb_elements = rgb..gsub('rgb(', '').gsub(')', '').split(',').map(&:strip).map(&:to_i)

    r, g, b = rgb_elements if rgb_elements.length == 3
    return [r, g, b]
  end

  def rgb_to_hsl(rgb)
    r, g, b = rgb || rgb_array

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

  def hsl_to_rgb
    # TODO: HSL to RGB conversion
  end

  def rgb_to_hex(rgb)
    r, g, b = rgb || rgb_array
    [r, g, b].map { |color| color.to_s(16) }
  end

  def hex_to_rgb
    hex.gsub('#', '').scan(/../).map(&:hex)
  end
  
end
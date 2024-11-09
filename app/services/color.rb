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
    color.is_a?(String) && color.match?(/^hsl\(\s*(\d{1,3})\s*,\s*(\d{1,2}(?:\.\d+)?|100)%\s*,\s*(\d{1,2}(?:\.\d+)?|100)%\s*\)$/) &&
    $1.to_i.between?(0, 360) &&
    $2.to_f.between?(0, 100) &&
    $3.to_f.between?(0, 100)
  end

  def hex_array
    color.gsub('#', '').scan(/../).map(&:to_i) if hex?
  end

  def rgb_array
    color.gsub('rgb(', '').gsub(')', '').split(',').map(&:strip).map(&:to_i) if rgb?
  end

  def hsl_array
    color.gsub('hsl(', '').gsub(')', '').split(/[,\s]+/).map(&:strip).map(&:to_f) if hsl?
  end

  def rgb_to_hsl(rgb)
    return nil unless rgb?

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
    return nil unless hsl?

    hue, saturation, luminance = hsl_array

    saturation /= 100.0
    luminance /= 100.0

    chroma = (1 - (2 * luminance - 1).abs) * saturation
    x = chroma * (1 - ((hue / 60.0) % 2 - 1).abs)
    m = luminance - chroma / 2.0

    if (0 <= hue && hue < 60)
      r = chroma
      g = x
      b = 0
    elsif (60 <= hue && hue < 120)
      r = x
      g = chroma
      b = 0
    elsif (120 <= hue && hue < 180)
      r = 0
      g = chroma
      b = x
    elsif (180 <= hue && hue < 240)
      r = 0
      g = x
      b = chroma
    elsif (240 <= hue && hue < 300)
      r = x
      g = 0
      b = chroma
    elsif (300 <= hue && hue < 360)
      r = chroma
      g = 0
      b = x
    end

    r = ((r + m) * 255).round
    g = ((g + m) * 255).round
    b = ((b + m) * 255).round

    [r, g, b]
  end

  def rgb_to_hex(rgb)
    return nil unless rgb?

    r, g, b = rgb || rgb_array
    [r, g, b].map { |color| color.to_s(16) }
  end

  def hex_to_rgb
    return nil unless hex?

    hex_array.map(&:hex)
  end
end
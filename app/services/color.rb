class Color
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def hex
    return color if hex?

    rgb if hsl?
    a, b, c = rgb_to_hex

    @color = "##{a}#{b}#{c}" if a && b && c
    @color
  end

  def rgb
    return color if rgb?

    r, g, b = hsl_to_rgb if hsl?
    r, g, b = hex_to_rgb if hex?

    @color = "rgb(#{r}, #{g}, #{b})" if r && g && b
    @color
  end

  def hsl
    return color if hsl?

    rgb if hex?
    h, s, l = rgb_to_hsl

    @color = "hsl(#{h}, #{s}%, #{l}%)" if h && s && l
    @color
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
    color.is_a?(String) && color.match?(/^hsl\(\s*(\d{1,3}(?:\.\d+)?)\s*,\s*(\d{1,2}(?:\.\d+)?|100(?:\.0+)?)%\s*,\s*(\d{1,2}(?:\.\d+)?|100(?:\.0+)?)%\s*\)$/) &&
    $1.to_i.between?(0, 360) &&
    $2.to_f.between?(0, 100) &&
    $3.to_f.between?(0, 100)
  end

  def hex_array
    hex
    color.gsub('#', '').scan(/../) if hex?
  end

  def rgb_array
    rgb
    color.gsub('rgb(', '').gsub(')', '').split(',').map(&:strip).map(&:to_i) if rgb?
  end

  def hsl_array
    hsl
    color.gsub('hsl(', '').gsub(')', '').split(/[,\s]+/).map(&:strip).map(&:to_f) if hsl?
  end

  def rgb_to_hsl
    return nil unless rgb?

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
        hue = ((g - b) / chroma) % 6.0
      when g
        hue = (b - r) / chroma + 2.0
      when b
        hue = (r - g) / chroma + 4.0
      end
    end

    hue = (hue * 60).round(1)
    hue += 360 if hue < 0

    luminance = (max + min) / 2.0
    saturation = chroma / (1 - (2.0 * luminance - 1).abs) if chroma > 0

    saturation = (saturation * 100).round(1)
    luminance = (luminance * 100).round(1)

    [hue, saturation, luminance]
  end

  def hsl_to_rgb
    return nil unless hsl?

    hue, saturation, luminance = hsl_array

    saturation /= 100.0
    luminance /= 100.0

    chroma = (1.0 - (2.0 * luminance - 1).abs) * saturation
    x = chroma * (1.0 - ((hue / 60.0) % 2.0 - 1).abs)
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

    r = ((r + m) * 255.0).round
    g = ((g + m) * 255.0).round
    b = ((b + m) * 255.0).round

    [r, g, b]
  end

  def rgb_to_hex
    return nil unless rgb?

    r, g, b = rgb_array
    [r, g, b].map do |color|
      hex = color.to_s(16)
      hex = hex.insert(0, '0') if hex.length == 1
      color = hex
    end
  end

  def hex_to_rgb
    return nil unless hex?

    hex_array.map(&:hex)
  end
end
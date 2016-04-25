class String
  def capital_case
    split(' ').map(&:capitalize).join(' ')
  end

  def slugify
    strip.downcase.gsub(/\s+/, '_').gsub(/\W/, '').tr('_', '-')
  end

  def is_downcase?
    self == downcase
  end

  def is_upcase?
    self == upcase
  end

  def is_number?
    if self =~ /^-?\d+[,.]?\d*(e-?\d+)?$/
      true
    else
      false
    end
  end

  def is_integer?
    to_i.to_s == self
  end
end

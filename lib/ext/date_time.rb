class DateTime
  def rfc822
    strftime '%a, %d %b %Y %H:%M:%S %z'
  end
end

class String

  def chunk_string(average_segment_size = 40, sclice_on = /\s+/)
    out = []
    slices_estimate = self.size.divmod(average_segment_size)
    slice_count = (slices_estimate[1] > 0 ? slices_estimate[0] + 1 : slices_estimate[0])
    slice_guess = self.size / slice_count
    previous_slice_location = 0
    (1..slice_count - 1).each do |i|
      slice_location = self.nearest_split(slice_guess * i, sclice_on)
      out << self.slice(previous_slice_location..slice_location)
      previous_slice_location = slice_location + 1
    end
    out << self.slice(previous_slice_location..self.size)
    out
  end

  def nearest_split(slice_start, slice_on)
    left_scan_location  = (self.slice(0..slice_start).rindex(slice_on)).to_i
    right_scan_location = (self.slice((slice_start+1)..self.size).index(slice_on)).to_i + slice_start
    ((slice_start - left_scan_location) < (right_scan_location - slice_start) ? left_scan_location : right_scan_location)
  end

  def force_utf8
    encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
  end

  def to_bool
    return true   if self == true   || self =~ (/(true|t|yes|y|1)$/i)
    return false  if self == false  || self.blank? || self =~ (/(false|f|none|no|n|0)$/i)
    raise ArgumentError.new("invalid value for Boolean: \"#{self}\"")
  end

end

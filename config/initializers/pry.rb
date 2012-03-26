if Rails.env == "development"
  silence_warnings do
    begin
      require 'pry'
      require 'pry-doc'
      IRB = Pry
    rescue LoadError
      # Fallback to IRB
    end
  end
end


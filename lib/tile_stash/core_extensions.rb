class Hash
  unless self.instance_methods.include?('symbolize_keys') || self.instance_methods.include?(:symbolize_keys)
    def symbolize_keys
      inject({}) do |options, (key, value)|
        options[(key.to_sym rescue key) || key] = value
        options
      end
    end
  end

  unless self.instance_methods.include?('symbolize_keys!') || self.instance_methods.include?(:symbolize_keys!)
    def symbolize_keys!
      self.replace(self.symbolize_keys)
    end 
  end
end


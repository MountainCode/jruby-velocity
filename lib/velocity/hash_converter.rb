module Velocity
  class HashConverter
    def to_hash obj
      hash = {}
      if(obj.is_a? Hash)
        string_key_hash = {}
        obj.each do |key, value|
          string_key_hash[key.to_s] = to_hash value
        end
        string_key_hash
      elsif obj.is_a? Array
        obj.each_with_index { |item, i| obj[i] = to_hash item }
      elsif 0 == obj.instance_variables.length
        obj
      else
        obj.instance_variables.each do |var|
          hash[var.to_s.delete '@'] = to_hash(obj.instance_variable_get var)
        end
        hash
      end
    end
  end
end

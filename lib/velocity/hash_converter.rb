module Velocity
  class HashConverter
    def to_hash obj
      hash = {}
      if(obj.is_a? Hash)
        to_add = {}
        to_delete = []
        obj.each do |key, value|
          to_add[key.to_s] = to_hash value
          to_delete << key if key.is_a? Symbol
        end
        to_add.each { |k,v| obj[k] = v }
        to_delete.each { |it| obj.delete it }
        obj
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

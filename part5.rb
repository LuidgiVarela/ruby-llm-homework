class Class
  def attr_accessor_with_history(attr_name)
    attr_name = attr_name.to_s
    attr_reader attr_name

    define_method("#{attr_name}_history") do
      history_variable = "@#{attr_name}_history"
      instance_variable_set(history_variable, [nil]) unless instance_variable_defined?(history_variable)
      instance_variable_get(history_variable)
    end

    define_method("#{attr_name}=") do |value|
      send("#{attr_name}_history") << value
      instance_variable_set("@#{attr_name}", value)
    end
  end
end

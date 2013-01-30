class Car
  ALLOWED = [:engine, :size, :turbo]

  def initialize(args = {}, &block)
    if block_given?
      instance_eval &block
    else
      args.each { |k, v| ALLOWED.include?(k) ? instance_variable_set("@#{k}", v) : raise("the variable '@#{k}' is not allowed") }
    end
  end

  def method_missing name, *args, &block
    name = name.to_s
    name.chop! if name =~ /=$/
    if ALLOWED.include? name.to_sym
      self.class.send(:define_method, name, proc { attr_accessor name.to_sym} )
      instance_variable_set("@#{name}", args[0])
    else
      super
    end
  end

  def engine_info
    puts "#{'Turbo ' if @turbo}#{@size.to_f} #{@engine} engine".capitalize
  end
end

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
      #instance_variable_set("@#{name}", args[0])
      #self.class.send(:define_method, "#{name}=" proc { instance_variable_set("@#{name}", args[0]) } )
      #self.class.send(:define_method, name, proc { instance_variable_get("@#{name}") } )
      self.class.send(:define_method, "#{name}=") do
        instance_variable_set("@#{name}", args[0])
      end
      self.class.send(:define_method, name) do
        instance_variable_get("@#{name}")
      end
    else
      super
    end
  end

  def engine_info
    raise 'car is failed' if instance_variables.empty?
    puts "#{'Turbo ' if @turbo}#{@size.to_f} #{@engine} engine".capitalize
  end
end

a = Car.new
a.engine = :diesel
a.size = 1.6
a.engine= :gas

p a.respond_to? 'engine'  # => true
p a.respond_to? 'engine=' # => true
p a.engine  # returns :diesel instead of :gas

#-----------------------------------------------------------
#p a.engine #should return :diesel
#p a.size #should return 1.6
#a.engine_info #should print "1.6 Diesel engine"
#Car.new(:engine => :gas, :size => 1.6).engine_info
#should print "1.6 Gas engine"
#Car.new.engine_info #should fail
#Car.new(asdasd: true) #should fail
#Car.new(engine: :diesel, size: 2, turbo: true).engine_info
#prints "Turbo diesel engine 2.0"
#a = Car.new do
#  self.engine= :diesel
#  self.size= 3
#end
#a.engine_info #prints "3.0 Diesel engine"
#a = Car.new do
#  engine :diesel
#  size 3
#end
#a.engine_info

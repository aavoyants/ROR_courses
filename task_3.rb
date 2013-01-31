class Car
  ALLOWED = [:engine, :size, :turbo]

  def initialize(args = {}, &block)
    instance_eval &block if block_given?
    args.each { |k, v| ALLOWED.include?(k) ? instance_variable_set("@#{k}", v) : raise("the variable '@#{k}' is not allowed") }
  end

  def method_missing(name, *args)
    name = name.to_s
    name.chop! if name =~ /=$/
    value = args[0]

    raise "Try to set variable @#{name} first" unless value
    super unless ALLOWED.include? name.to_sym

    self.class.send :attr_accessor, name
    instance_variable_set("@#{name}", value)
  end

  def engine_info
    raise 'car is failed' if instance_variables.empty?
    puts "#{'Turbo ' if @turbo}#{@size.to_f} #{@engine} engine".capitalize
  end
end

#a = Car.new
#a.engine = :diesel
#a.size = 1.6
#p a.engine #should return :diesel
#p a.size #should return 1.6
#a.engine_info #should print "1.6 Diesel engine"
#Car.new(:engine => :gas, :size => 1.6).engine_info #should print "1.6 Gas engine"
#Car.new.engine_info #should fail
#Car.new(asdasd: true) #should fail
#Car.new(engine: :diesel, size: 2, turbo: true).engine_info #prints "Turbo diesel engine 2.0"
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

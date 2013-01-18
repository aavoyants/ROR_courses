class Week
  def today
    Time.now.strftime("%A")
  end
end

def shorten(cls, method_name)
  if cls.method_defined? method_name
    cls.send :define_method, method_name do
      Time.now.strftime("%a")
    end
  end
end

curr_week = Week.new
p "Today is #{curr_week.today}"
shorten(Week, :today)
p "Today is #{curr_week.today}"

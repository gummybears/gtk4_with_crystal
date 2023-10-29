class A
  def f(func1, param11,func2, param21, param22)
    puts "in f(func1)"
    func1.call(param11)
    func2.call(param21,param22)
  end
end

def a(s : String, i : Int32)
  puts s + " #{i}"
end

def b(s : String, i : Int32)
  puts "function b #{s} : #{i}"
end

def c(s : String)
  puts "function c : #{s}"
end

a = A.new.f(->c(String),"hello",->b(String,Int32),"world",42)

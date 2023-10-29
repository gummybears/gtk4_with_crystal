def a(s : String, i : Int32)
  puts s + " #{i}"
end

def b(s : String, i : Int32)
  puts s + " #{i}"
end

def f(callback1,callback2)
end

f(a("x+y",1),b("y+z",2))

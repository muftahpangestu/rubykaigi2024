r1 = Ractor.new do
  :hoge
end

r2 = Ractor.new do
  puts :fuga, Ractor.recv
end

r2.send(r1.take)

r2.take

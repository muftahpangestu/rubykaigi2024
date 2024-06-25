require 'pbt'

describe `sort` do
  context 'property based testing with ractor' do
    Pbt.assert(verbose: true, worker: :ractor) do
      # 入力値が整数であることを指定
      Pbt.property(Pbt.array(Pbt.integer)) do |numbers|
        def self.sort(array)
          return array if array.size <= 2 #バグだ！これは１のはず！
          pivot, *rest = array
          left, right = rest.partition { |n| n <= pivot }
          sort(left) + [pivot] + sort(right)
        end
        
        result = sort(numbers)
        result.each_cons(2) do |x, y|
          raise "Sort algorithm is wrong." unless x <= y
        end
      end
    end
  end
end

require 'pbt'

class PropertyBasedTest
  def self.sort(array)
    return array if array.size <= 2 #バグだ！これは１のはず！
    pivot, *rest = array
    left, right = rest.partition { |n| n <= pivot }
    sort(left) + [pivot] + sort(right)
  end
end

RSpec.describe PropertyBasedTest do
  describe `sort` do
    context 'example based testing' do
      it do
        expect(described_class.sort([3, 2, 1])).to eq([1, 2, 3])
      end
    end
    context 'property based testing' do
      Pbt.assert(verbose: true) do
        # 入力値が整数であることを指定
        Pbt.property(Pbt.array(Pbt.integer)) do |numbers|
          result = described_class.sort(numbers)
          result.each_cons(2) do |x, y|
            raise "Sort algorithm is wrong." unless x <= y
          end
        end
      end
    end
  end
end


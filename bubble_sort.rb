# non-destructive sorting algorithm, intended for numeric values
# will be destructive on arrays with string elements as this does not do a deep copy
def bubble_sort(arr)
  sorted_arr = arr.clone
  sorted = false
  until sorted
    sorted = true
    (1..arr.length - 1).each do |i|
      right = sorted_arr[i]
      left = sorted_arr[i - 1]
      if left < right then next end
      sorted_arr[i] = left
      sorted_arr[i - 1] = right
      sorted = false
    end
  end
  sorted_arr
end

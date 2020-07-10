# non-destructive sorting algorithm, intended for numeric values
# will be destructive on arrays with string elements as this does not do a deep copy
def bubble_sort(arr)
  sorted = false
  sorted_arr = arr.clone
  left = 0
  right = 0
  while not sorted
    sorted = true
    for i in 1..arr.length - 1 do
      right = sorted_arr[i]
      left = sorted_arr[i - 1]
      if left > right then
        sorted_arr[i] = left
        sorted_arr[i - 1] = right
        sorted = false
      end
    end
  end
  sorted_arr
end
  

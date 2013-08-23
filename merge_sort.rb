
arr1 = [1, 4, 3, 5, 2, 5, 3, 6, 7, 83, 23, 12, 32, 12, 3, 12, 53, 65, 12, 1, 3]
arr2 = [4, 2, 7]
def merge_sort array
	output = []
	if array.length != 1
		array_first_half = array[0..array.length/2-1]
		array_second_half = array[array.length/2..array.length-1]
		
		sorted_first_half = merge_sort(array_first_half)
		sorted_second_half = merge_sort(array_second_half)
		
		i = 0
		j = 0
		
		desired_output_length = sorted_first_half.length + sorted_second_half.length
		
		until output.length == desired_output_length do
			if sorted_first_half[i] == nil
				sorted_second_half[j..-1].each do |val|
					output.push(val)
					k += 1
				end
			elsif sorted_second_half[j] == nil
				sorted_first_half[i..-1].each do |val|
					output.push(val)
					k += 1
				end
			elsif sorted_first_half[i] < sorted_second_half[j]
				output.push(sorted_first_half[i])
				i += 1
				k += 1
			else
				output.push(sorted_second_half[j])
				j += 1
				k += 1
			end
		end
	else array.length == 1
		output = array
	end
	return output
end

sorted = merge_sort arr1
puts sorted.inspect
puts "Sorted is #{sorted.length} items long."
puts "Original is #{sorted.length} items long."
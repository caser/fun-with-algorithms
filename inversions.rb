arr1 = [1, 3, 5, 2, 4, 6]
arr2 = [1, 4, 3, 5, 2, 5, 3, 6, 7, 83, 23, 12, 32, 12, 3, 12, 53, 65, 12, 1, 3]
arr3 = [4, 2, 7]

file = File.open("IntegerArray.txt", "r")
contents = file.read

string_array = contents.split
array = []

string_array.each do |x|
	array.push(x.to_i)
end

def count array
	n = array.length
	if n == 1
		return array, 0
	else
		output = []
		array_left = array[0..n/2-1]
		array_right = array[n/2..n-1]
		
		sorted_1, count_left = count(array_left)
		sorted_2, count_right = count(array_right)
		
		count_split = 0
		i = 0
		j = 0
		k = 0
		desired_output_length = sorted_1.length + sorted_2.length
		
		until output.length == desired_output_length do
			if sorted_1[i] == nil
				sorted_2[j..-1].each do |val|
					output.push(val)
				end
			elsif sorted_2[j] == nil
				sorted_1[i..-1].each do |val|
					output.push(val)
				end
			elsif sorted_1[i] < sorted_2[j]
				output.push(sorted_1[i])
				i += 1
			else
				output.push(sorted_2[j])
				count_split += sorted_1.length - i
				j += 1
			end
		end
	total_count = count_left + count_right + count_split
	return output, total_count
	end
end

sorted, count = count array
puts "There are #{count} inversions!"

=begin

Task: 
Build an algorithm which calculates the closest pair in a set of points.
Algorithm should run in O(n log n) time.
Based on lecture from Stanford Algorithms course on Coursera.
https://class.coursera.org/algo-004/lecture/17

=end

points = [[0, 1], [2, 4], [4, 5], [3, 6], [1, 7], [5, 0], [6, 3], [7, 2]]

# Sort multi-dimensional array
px = points.sort_by{|p|p[0]}
py = points.sort_by{|p|p[1]}

def closest_pair px, py
	# puts "px is #{px.inspect}"
	# puts "py is #{py.inspect}"
	# puts "px[0] is #{px[0]} and px[1]: #{px[1]}"
	# Base case
	if px.length == 2
		# puts "Base case returning..."
		# puts "p1: #{px[0].inspect} and p2: #{px[1].inspect}"
		return px[0], px[1]
	elsif px.length == 3
		if euclid(px[0], px[1]) < euclid(px[1], px[2])
			return px[1], px[2]
		else
			return px[0], px[1]
		end
	#Recursive case
	else
		half = px.length/2
		
		# Split array into left and right half, sorted by X index
		qx = px.slice(0..half-1)
		rx = px.slice(half..-1)
		
		# Find q & r sorted by Y index
		qy = qx.sort_by{|p|p[1]}
		ry = rx.sort_by{|p|p[1]}
		
		# Calculate closest pairs in each half recursively
		p1, q1 = closest_pair qx, qy
		p2, q2 = closest_pair rx, ry
		
		# Calculate minimum distance
		delta = [euclid(p1, q1), euclid(p2, q2)].min
		
		# Calculate split pairs using 
		p3, q3 = closest_split_pair px, py, delta
		
		# Calculate which point is the best

		# Check case where p1, q1 were closer than p2, q2
		if delta == euclid(p1, q1)
			if p3
				if euclid(p1, q1) < euclid(p3, q3)
					# puts "Returning p1: #{p1.inspect} and q1 #{q1.inspect}"
					return p1, q1
				else
					# puts "Returning p3: #{p3.inspect} and q3 #{q3.inspect}"
					return p3, q3
				end
			else
				return p1, q1
			end
		# Else case is where p2, q2 closer than p1, q1
		else
			if p3
				if euclid(p2, q2) < euclid(p3, q3)
					# puts "Returning p2: #{p2.inspect} and q2 #{q2.inspect}"
					return p2, q2
				else
					# puts "Returning p3: #{p3.inspect} and q3 #{q3.inspect}"
					return p3, q3
				end
			else
				return p2, q2
			end
		end
	end
end

def closest_split_pair px, py, delta
	# puts "Entering closest_split_pair function, delta is #{delta}"
	# Create variables to keep track of minimum distances
	min_points = [nil, nil]
	min_dist = delta
	
	# Find x_bar, the right-most point in the left set of points
	half = px.length/2
	x_bar = px[half-1][0]
	# puts "x_bar is #{x_bar}"
	
	# Create the channel in which a split pair of points could possibly be found
	lower_bound = x_bar - delta
	upper_bound = x_bar + delta
	# puts "lower_bound is #{lower_bound}, upper_bound is #{upper_bound}"
	
	# puts "Full list is #{px.inspect}."
	# puts "Pruning list into sy..."
	# Prune the list of points, excluding points outside of the above channel
	sy = py.select{|x| x[0] > lower_bound && x[0] < upper_bound}
	# puts "sy is #{sy.inspect}"
	
	# Compute and compare distances of points in the channel
	sy.each_with_index do |point1, index|
		# Only need to check 7 points ahead due to definition of delta
		x = 1
		until x == 8 do
			if !sy[index + x]
				# We've overshot the array and should go to next iteration of outer loop
				x += 1
				next
			else
				# puts "Index is #{index} and index + x is #{index + x}"
				point2 = sy[index + x]
				dist = euclid point1, point2
				if dist < min_dist
					# Set minimums
					min_points = [point1, point2]
					min_dist = dist
					x += 1
					next
				else
					# Check next point
					x += 1
					next
				end
			end
		end
	end
	# puts "Returning min_point1: #{min_points[0]} and min_point2 #{min_points[1]}"
	return min_points[0], min_points[1]
end
	
#Calculate distance between two points based upon Euclidean distance
def euclid point1, point2
	return Math.sqrt((point1[0] - point2[0])**2 + (point1[1] - point2[1])**2)
end

p1, p2 = closest_pair px, py
puts "The closest pairs are #{p1.inspect} and #{p2.inspect}."
puts "Their euclidean distance is #{euclid p1, p2}."

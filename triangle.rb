# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#
def triangle(a, b, c)
  # WRITE THIS CODE
  raise TriangleError if (a <= 0) || (b <= 0) || (c <= 0)

  return :equilateral if (a == b) && (b == c) && (a == c)

  is_triangle = (a + b > c) &&
                (a + c > b) &&
                (b + c > a)

  raise TriangleError unless is_triangle

  return :isosceles if (a == b) || (b == c) || (a == c)

  :scalene
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

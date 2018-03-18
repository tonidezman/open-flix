module ApplicationHelper

  def array_of_star_ratings
    5.downto(1).map { |num| [pluralize(num, "star"), num]}
  end

end

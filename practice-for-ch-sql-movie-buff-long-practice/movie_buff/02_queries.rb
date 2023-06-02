def eighties_b_movies
  # List all the movies from 1980-1989 with scores falling between 3 and 5
  # (inclusive). Show the id, title, year, and score.
  Movie.select(:id,:title,:yr,:score).where(yr: 1980..1989).where(score: 3..5)
end

def bad_years
  # List the years in which no movie with a rating above 8 was released.
  Movie.select(:yr).group(:yr).having("MAX(score) <= 8").pluck(:yr)
end

def cast_list(title)
  # List all the actors for a particular movie, given the title.
  # Sort the results by starring order (ord). Show the actor id and name.
  Movie.joins(:actors).where(title: title).order("castings.ord ASC").select("actors.id,actors.name")
end

def vanity_projects
  # List the title of all movies in which the director also appeared as the
  # starring actor. Show the movie id, title, and director's name.

  # Note: Directors appear in the 'actors' table.
  Movie.joins(:actors).select(:id, :title, "actors.name").where("actor_id = director_id AND castings.ord = 1")
  
end

def most_supportive
  # Find the two actors with the largest number of non-starring roles.
  # Show each actor's id, name, and number of supporting roles.
  Actor.joins(:movies).select(:id,:name,"COUNT(movies.id) AS roles").where("castings.ord != 1").group(:id).order("COUNT(movies.id) DESC").limit(2)
end
class TopOneHundredMovies::CLI

#start is the main CLI instance method that the user manually interacts with to view, learn about, and save movies
  def start
    puts "Here's a list of IMDb's Top 100 Movies:"
    puts "\n"
    user_input = "y"
	scraper = TopOneHundredMovies::Scraper.new
	movie_list = scraper.print_movie_list
    
	while user_input == 'y'
	  movie = scraper.movie_initializer
      movie.print_basic_details
      puts "\nWould you like to know more information about #{movie.title}?" 
      puts "Please enter 'y' for yes or 'n' for no."
	  user_input = movie.valid_response
      watchlist_response = nil
      while user_input == 'y'
        movie.ask_user
        user_input = movie.detailed_valid_response
        if user_input == 1
          movie.print_tagline
        elsif user_input == 2
          movie.print_plot
        elsif user_input == 3
          movie.print_trivia
        elsif user_input == 4
          movie.print_quotes
		elsif user_input == 5
          movie.print_cast
        end
		if TopOneHundredMovies::Movie.my_watchlist.include?(movie) != true && watchlist_response == nil
			puts "\nWould you like to add this movie to your watchlist?"
			puts "Please enter 'y' for yes or 'n' for no"
			user_input = movie.valid_response
			if user_input == 'y'
				watchlist_response = 'y'
				movie.add_to_my_watchlist
			else
			    watchlist_response = 'n'
				puts "\nNoted. You do not want to add this movie to your watchlist."
			end	
		end
		puts "\nWould you like to know more about #{movie.title}?"
        puts "Please enter 'y' for yes or 'n' for no"
        user_input = movie.valid_response
      end
	  puts "Okay, exiting #{movie.title} now..."
	  puts "Would you like to research another movie?"
      puts "Please enter 'y' for yes or 'n' for no"
      user_input = movie.valid_response
	  if user_input == 'y'
		movie_list
	  end
	  end
	  puts "Would you like to view your watchlist?"
	  puts "Please enter 'y' for yes or 'n' for no"
      user_input = movie.valid_response
	  if user_input == 'y'
		movie_list
	  end
	  puts "Thank you for viewing IMDb's Top 100 Movie List!"
	end
  
#basic_generate_all is a CLI instance method that automatically initializes and prints all top 100 movies from IMDb. This method takes several minutes to finish due to the large number of movies that need to be initialized.

  def basic_generate_all
	 puts "Here are basic details about all the movies in IMDb's Top 100 Movie List!"
	 puts "Please wait. Scraping all 100 movies will take several minutes. Your patience is greatly appreciated!"
	 scraper = TopOneHundredMovies::Scraper.new
	 all_movies = scraper.initialize_all_movies
	 all_movies.each{|movie| movie.print_basic_details}
	 all_movies
  end

end
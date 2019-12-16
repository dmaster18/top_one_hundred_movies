class TopOneHundredMovies::Scraper
  
#Methods that interface directly with the IMDb HTML
  def self.index_page #Retrieves Nokogiri data from IMDb Index Page
    index_html = "https://www.imdb.com/list/ls055592025/"
    Nokogiri::HTML(open(index_html))
  end
  
  def movie_page_url(movie_object) #Generates selected movie's IMDb page HTML
	  index = movie_object.index
	  resource = self.class.index_page.css(".lister-item-header a")[index]["href"]
	  movie_page_url = "https://www.imdb.com" + resource
  end
  
  def movie_page(movie_object) #Retrieves Nokogiri data from selected movie's IMDb page
    movie_html = movie_page_url(movie_object)
    Nokogiri::HTML(open(movie_html))
  end
  
  def trivia_page_url(movie_object) #Generates selected movie's IMDb trivia page HTML
	  movie_page = movie_page(movie_object)
	  movie_page_url = movie_page_url(movie_object)
	  resource = movie_page.css("div#trivia a.nobr")[0]["href"].to_s
	  trivia_page_url = movie_page_url.to_s + resource
  end
  
  def trivia_page(movie_object) #Retrieves Nokogiri data from selected movie's IMDb trivia page
    trivia_html = trivia_page_url(movie_object)
    Nokogiri::HTML(open(trivia_html))
  end
  
  def quotes_page_url(movie_object) #Generates selected movie's IMDb trivia page HTML
	  movie_page = movie_page(movie_object)
	  movie_page_url = movie_page_url(movie_object)
	  resource = movie_page.css("div#quotes a.nobr")[0]["href"].to_s
	  quotes_page_url = movie_page_url.to_s + resource
  end
  
  def quotes_page(movie_object) #Retrieves Nokogiri data from selected movie's IMDb trivia page
    quotes_html = quotes_page_url(movie_object)
    Nokogiri::HTML(open(quotes_html))
  end
  

#self.print_movie_list is a class method that prints the titles of the top 100 movies relatively quickly for the user to view to 
	
  def self.print_movie_list #Prints an array of top 100 movies from IMDb Index Page
	all_titles = []
	i = 1
	self.index_page.css("h3.lister-item-header a").each {|title| 
		all_titles << "#{i}. #{title.text.strip}"
	    i+=1
	 }
	puts all_titles
  end
  

#Methods that initialize movie objects
    
  def movie_initializer #movie_initializer is an instance method that allows user to manually initialize one movie object at a time
    new_movie = TopOneHundredMovies::Movie.new
  end
  
  def initialize_all_movies #initialize_all_movies is an instance method that will automatically initialize all the top 100 movies
    i = 0 
    all_movies = []
    while i < 100
      new_movie = TopOneHundredMovies::Movie.new(i)
      all_movies << new_movie
      i+=1
    end
    all_movies
  end
  
end
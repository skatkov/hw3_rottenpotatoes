class DirectorColumn < ActiveRecord::Migration
	MORE_MOVIES = [
		{:title => 'Star Wars', :rating => 'PG', :director => 'George Lucas', :release_date => '1977-05-25'},
		{:title => 'Blade Runner', :rating => 'PG', :director => 'Ridley Scott', :release_date => '1982-06-25'},
		{:title => 'Alien', :rating => 'R', :director => '', :release_date => '1979-05-25'},
		{:title => 'THX-1138', :rating => 'R', :director => 'George Lucas', :release_date => '1971-03-11'},]
	def up
		add_column :movies, :director , :string

		MORE_MOVIES.each do |movie|
      		Movie.create!(movie)
    	end
	end

	def down
		remove_column :movies, :director
	end
end
require 'logger'
require "movie.rb"
log = Logger.new("steps.log")

MORE_MOVIES = [
  {:title => 'Aladdin', :rating => 'G', :release_date => '25-Nov-1992'},
  {:title => 'The Terminator', :rating => 'R', :release_date => '26-Oct-1984'},
  {:title => 'When Harry Met Sally', :rating => 'R', :release_date => '21-Jul-1989'},
  {:title => 'The Help', :rating => 'PG-13', :release_date => '10-Aug-2011'},
  {:title => 'Chocolat', :rating => 'PG-13', :release_date => '5-Jan-2001'},
  {:title => 'Amelie', :rating => 'R', :release_date => '25-Apr-2001'},
  {:title => '2001: A Space Odyssey', :rating => 'G', :release_date => '6-Apr-1968'},
  {:title => 'The Incredibles', :rating => 'PG', :release_date => '5-Nov-2004'},
  {:title => 'Raiders of the Lost Ark', :rating => 'PG', :release_date => '12-Jun-1981'},
  {:title => 'Chicken Run', :rating => 'G', :release_date => '21-Jun-2000'},
  {:title => 'Star Wars', :rating => 'PG', :director => 'George Lucas', :release_date => '1977-05-25'},
  {:title => 'Blade Runner', :rating => 'PG', :director => 'Ridley Scott', :release_date => '1982-06-25'},
  {:title => 'Alien', :rating => 'R', :director => '', :release_date => '1979-05-25'},  
  {:title => 'THX-1138', :rating => 'R', :director => 'George Lucas', :release_date => '1971-03-11'},
]

MORE_MOVIES.each do |movie|
  Movie.create!(movie)
end

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    assert false, "missing #{movie}" if Movie.find_by_title(movie[:title]).nil?
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  assert false, "Unimplmemented"
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  list = rating_list.split(",")
  uncheck.nil? ? list.each {|field| check("ratings[#{field.strip}]") } : list.each {|field| uncheck("ratings[#{field.strip}]")}
end

When /I press "([^"]*)"$/ do |button|
  click_button(button)
end

Then /I should( not)? see: (.*)/ do |onpage, movie_list|
  movie_list.split(",").each do |title|
    if onpage.nil? then
      if page.respond_to? :should
        page.should have_content(title), "missing movie " + title
      else
        assert page.has_content?(title), "missing movie " + title
      end 
    else
      if page.respond_to? :should_not
        page.should_not have_content(title), "this movies should be here " + title
      else
        assert_equal false, page.has_content?(title), "this movies should be here " + title
      end
    end
  end
end

Then /director of "(.*)" should be "(.*)"/ do |movie, director|
  assert Movie.find_by_title(movie).director.should == director, "The director of #{movie} it is not #{director}"
end

Then /I should see( all)? of the movies/ do |number|
  assert all("tr").count.eql?(MORE_MOVIES.count + 1), "Not all movies appear" if number.eql?("all")
end

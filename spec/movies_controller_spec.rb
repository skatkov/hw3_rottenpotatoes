require 'spec_helper'
require 'movies_controller'

describe MoviesController do
	describe "search by director" do
		before :each do
			@fake_result = [ mock("Movie"), mock("Movie") ]
		end

		it 'should return list of movies' do
			Movie.should_receive(:find_by_director).with(:director => "Alfred Hitchcock").
			and_return(@fake_result)
			get 'search/', {:director => "Alfred Hitchcock"}
		end		
	end
end
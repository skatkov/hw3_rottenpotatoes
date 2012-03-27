require 'spec_helper'
require 'movies_controller'

describe MoviesController do
	describe "search by director" do
		before :each do

			Movie.create!({:title => 'Star Wars', :rating => 'PG', :release_date => '1977-05-25', :director => 'George Lucas'})
			Movie.create!({:title => 'THX-1138', :rating => 'R', :release_date => '1971-03-11', :director => 'George Lucas'})
			Movie.create!({:title => 'Alien', :rating => 'PG', :release_date => '1982-06-25', :director => 'Ridley Scott'})

			@fake_result = [ mock("Movie"), mock("Terminator") ]
		end

		it 'should model and perform search' do
			Movie.should_receive(:find_all_by_director).with("Alfred Hitchcock").
			and_return(@fake_result)
			post :same_director , {:director => "Alfred Hitchcock" }
		end

		it 'should render proper template' do
			Movie.stub(:find_all_by_director).and_return(@fake_result)
			post :same_director, {:director => "Alfred Hitchcock"}
			response.should render_template('same_director')
		end

		it 'should provide results to template' do
			Movie.stub(:find_all_by_director).and_return(@fake_result)
			post :same_director, {:director => "Alfred Hitchcock"}
			assigns(:movies).should  == @fake_result
		end

		it 'should return correct number of records from DB' do			
			post :same_director, {:director => 'Ridley Scott'}
			assigns(:movies).count.should == 2
		end

		it 'should show flash if director is missing' do
			Movie.stub(:find_all_by_director).and_return(@fake_results)
			post :same_director, {:director => "Alfred Hitchcock"}
			flash[:notice].should == "no director info" 
		end
	end
end
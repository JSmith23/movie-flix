require 'rails_helper'

describe 'Viewing the list of movies' do 
  it "shows the movie" do 
    movie_1 = Movie.create(title: 'Avengers Infinity War', rating: 'PG-13', total_gross: 2955123987, description: 'Thanos comes in looking for the infinity stones', released_on: "2018-02-02")

    movie_2 = Movie.create(title: 'Avengers Endgame', rating: 'PG-13', total_gross: 2955123987643, description: "The end of Thanos's reign is over as the Avengers finally attain victory", released_on: "2018-02-02")

    movie_3 = Movie.create(title: 'Iron Man', rating: 'PG-13', total_gross: 'Flop', description: "The man made of iron!", released_on: "2019-05-24")


    visit movies_url

    expect(page).to have_text('3 Movies')
    expect(page).to have_text('Avengers Infinity War')
    expect(page).to have_text('Avengers Endgame')
    expect(page).to have_text('Iron Man')

    expect(page).to have_content(movie_1.rating)



  end

  it "shows an individual movie" do 

    movie_1 = Movie.create(title: 'Avengers Infinity War', rating: 'PG-13', total_gross: 2955123987, description: 'Thanos comes in looking for the infinity stones', released_on: "2018-02-02")

    visit movie_url(movie_1)

    expect(page).to have_content(movie_1.title)
    expect(page).to have_content(movie_1.rating)
    expect(page).to have_content(movie_1.description)
  end 

  it "shows the total gross if the total gross exceeds $50M" do 
    movie = Movie.create(total_gross: 60000000.00)

    visit movie_url(movie)

    expect(page).to have_content("$60,000,000.00")
  end 

  it "shows 'Flop!' if the total gross is less than $50M" do 
    movie = Movie.create(total_gross: 5.00)

    visit movie_url(movie)

    expect(page).to have_content("Flop!")
  end 

  it "updates the movie and shows the movie's updated details" do
    movie_1 = Movie.create(title: 'Avengers Infinity War', rating: 'PG-13', total_gross: 2955123987, description: 'Thanos comes in looking for the infinity stones', released_on: "2018-02-02")

    visit movie_url(movie_1)

    click_link 'Edit'

    expect(current_path).to eq(edit_movie_path(movie_1))

    expect(find_field('Title').value).to eq(movie_1.title)
  end

  it "updates the movie and shows the movie's updated details" do
    movie = Movie.create(title: 'Avengers Infinity War', rating: 'PG-13', total_gross: 2955123987, description: 'Thanos comes in looking for the infinity stones', released_on: "2018-02-02")

    visit movie_url(movie)

    click_link 'Edit'

    expect(current_path).to eq(edit_movie_path(movie))

    expect(find_field('Title').value).to eq(movie.title)

    fill_in 'Title', with: "Updated Movie Title"

    click_button 'Update Movie'

    expect(current_path).to eq(movie_path(movie))

    expect(page).to have_text('Updated Movie Title')
  end
  
  it "saves the movie and shows the new movie's details" do
    visit movies_url

    click_link 'Add New Movie'

    expect(current_path).to eq(new_movie_path)

    fill_in "Title", with: "New Movie Title"
    fill_in "Description", with: "Superheroes saving the world from villains"
    fill_in "Rating", with: "PG-13"
    fill_in "Total gross", with: "75000000"
    select (Time.now.year - 1).to_s, :from => "movie_released_on_1i"

    # If you're taking advantage of the HTML 5 date field in Chrome,
    # you'll need to use 'fill_in' rather than 'select'
    # fill_in "Released on", with: (Time.now.year - 1).to_s

    click_button 'Create Movie'

    expect(current_path).to eq(movie_path(Movie.last))

    expect(page).to have_text('New Movie Title')
  end
end

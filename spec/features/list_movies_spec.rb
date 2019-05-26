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
end

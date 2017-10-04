require 'pry'
require_relative('../models/albums')
require_relative('../models/artists')

artist1 = Artist.new({
  'name' => 'Oasis'
  })

artist2 = Artist.new({
  'name' => 'Blur'
  })

artist3 = Artist.new({
  'name' => 'The Rolling Stones'
  })

artist4 = Artist.new({
  'name' => 'The Chemical Brothers'
  })

artist1.save()
artist2.save()
artist3.save()
artist4.save()

album1 = Album.new({
  'title' => '(What\'s The Story) Morning Glory?',
  'genre' => 'Brit Pop',
  'artist_id' => artist1.id
  })

album2 = Album.new({
  'title' => 'Parklife',
  'genre' => 'Brit Pop',
  'artist_id' => artist2.id
  })

album3 = Album.new({
  'title' => 'Stripped',
  'genre' => 'Rock',
  'artist_id' => artist3.id
  })

album4 = Album.new({
  'title' => 'Surrender',
  'genre' => 'Electronic',
  'artist_id' => artist4.id
  })

album1.save()
album2.save()
album3.save()
album4.save()

binding.pry
nil

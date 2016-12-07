# Medium-Rare: A Blogging App
This blogging app allows users to maintain multiple blogs any topics they wish to post about. Posts are open to the public and can be starred and commented up. Additionally, posts can be tagged and searched for through a blog.

## Demo
A demo of the app can be found [here](https://vast-peak-35773.herokuapp.com/).

# Setup Instructions 
* Install Ruby, Rails 4+, and other dependencies
* Run `bundle install` to install gems
* Run `npm install` to install frontend dependencies
* If you mysql database connection requires a password, create a file called `.env` on the root folder and add the line `DB_PASSWORD="[your password]"`
* Run `rake db:create` to create the database
* Run `rake db:migrate` to update the schema
* Run `rake db:seed` to get default users and user roles
* Run `rails s` to start the server and visit `localhost:3000` in a browser

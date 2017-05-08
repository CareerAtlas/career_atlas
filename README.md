# [![map-marker-grey-icon.png](https://s15.postimg.org/p2cn1j797/map-marker-grey-icon.png)](https://postimg.org/image/zcf20rx4n/) [CareerAtlas](https://careeratlas.herokuapp.com/)

[CareerAtlas](https://careeratlas.herokuapp.com/), a location-based resource for jobs, uses WalkScore, GlassDoor, Indeed, and Google Maps APIs to provide job seekers a unique user experience and data set. The interface includes the ability to search for jobs via custom parameters, see job results populated on a map, and save jobs for future reference.

This project was built using [AngularJS](https://angularjs.org/) and [Sass](http://sass-lang.com/). [Grunt](http://gruntjs.com/) was used to automate the build process. Testing was done using [Mocha](https://mochajs.org/), [Chai](http://chaijs.com/), [Karma](https://karma-runner.github.io/0.13/index.html) and [RSpec](https://github.com/rspec/rspec). The database was built using [Ruby on Rails](http://rubyonrails.org/).

The live site for CareerAtlas can be found at [CareerAtlas](https://careeratlas.herokuapp.com/). This application was built as a capstone project for an engineering immersive bootcamp at [The Iron Yard](https://www.theironyard.com/) in Washington, DC.

![CA_movie 2.gif](https://s3.postimg.org/7wua0l3z7/CA_movie_2.gif)

## How to get [CareerAtlas](https://careeratlas.herokuapp.com/) running on your local machine ##

### Contributing to [CareerAtlas](https://careeratlas.herokuapp.com/) ###
If you fork this project to work on your own version, the backend files are in traditional rails structure with an angular application residing in `app/client`.

To get [CareerAtlas](https://careeratlas.herokuapp.com/) running, please follow the steps below.<br>
1. [Install git](http://git-scm.com)
2. [Install Ruby On Rails](http://rubyonrails.org/)
3. [Install Grunt](http://gruntjs.com)
4. Clone CareerAtlas to your own system
5. Navigate to the root directory of your clone and run `npm install` and `bin/update`
6. Navigate to the root directory of your clone and run `bin/rails server` or `bin/rails s` to start your server
7. Edit the code!
8. Navigate to the root directory of your clone, and run `grunt && grunt watch` to build your changes from whatever file you changed into the build directory.
9. Note: The `index.html` file in the build directory is the main html file for this site.

### Setting up your authorization for Google Maps API ###
This project utilizes the Google Maps API to show a map on the home site, and drop markers where jobs are located. You will need to put your own authorization script tag in order for the application to work. Request an API key from Google maps by following the directions [here](https://support.google.com/googleapi/answer/6158862). For more information on how to add a script tag to your project, check out this [link](https://developers.google.com/maps/documentation/javascript/adding-a-google-map). Once you have your own authorization key script tag, insert it into the `index.html` file at the bottom of the page. You will find a script tag that starts with the following `<script src='https://maps.googleapis.com/maps/api/`. Delete that particular line, and insert your own tag.

### Setting up the Indeed API ###
CareerAtlas uses the Indeed API to get job information based off of the user's specifications. In order to use the Indeed API you need to set up a publisher account [here](https://www.indeed.com/publisher) with Indeed. After you have created your account, Indeed will assign you a publisher ID that will need to be sent with every request. The best place to store this is in a `.env` file so you do not post your publisher ID on the internet.
This is how you would format your key in the `.env` file: INDEEDAPIKEY=YOURAPIKEY. Then, you would put ENV[INDEEDAPIKEY] as part of your query sent to Indeed.

### Setting up the Glassdoor API ###
All of the company review information for this project comes from the Glassdoor API. You can sign up for API access [here](https://www.glassdoor.com/developer/register_input.htm). After a successful sign up, Glassdoor will assign you a partner ID and partner key that has to be sent with every request. The best place to store this is in a `.env` file so you do not post your partner ID and key on the internet. You can go [here](https://www.glassdoor.com/developer/index.htm) for more documentation on using the Glassdoor API and [here](https://www.glassdoor.com/developer/companiesApiActions.htm) for an example request and response.
This is how you would format your key in the `.env` file: GLASSDOORID=YOURAPIID. Then, you would put ENV[GLASSDOORID] as part of your query sent to Glassdoor. You would also have to do the same setup for your partner key.


### Setting up the WalkScore API ###
This project uses the WalkScore API to get a composite score of the neighborhood for each job. You can request access to the API [here](https://www.walkscore.com/professional/api-sign-up.php), the free version should be enough for any starting project. WalkScore will give you an API key that must be sent with each request. The best place to store this is in a `.env` file so you do not post your API key on the internet. For more documentation regarding the WalkScore API you can go [here](https://www.walkscore.com/professional/api.php).
This is how you would format your key in the `.env` file: WALKSCOREAPIKEY=YOURAPIKEY. Then, you would put ENV[WALKSCOREAPIKEY] as part of your query sent to WalkScore.


### [CareerAtlas](https://careeratlas.herokuapp.com/) was built by the following developers:

* [Christine Ash](https://www.linkedin.com/in/christine-ash-5a21743b/) (Frontend - Angular)
* [Robby Dore](https://www.linkedin.com/in/robby-dore-61b88910b/) (Backend - Ruby On Rails)
* [Jennifer Oakes](https://www.linkedin.com/in/jennifernicoleoakes/) (Frontend - Angular)

### Acknowledgements ###

We would also like to thank our fellow classmates at the Iron Yard for their continued support throughout the cohort. We would also like to thank our instructors who guided us through the course and the final project.

Content Provided By: [Indeed](https://www.indeed.com), [Glassdoor](http://www.glassdoor.com), [Walk Score](https://www.walkscore.com/) and [Google Maps](http://www.googlemaps.com).

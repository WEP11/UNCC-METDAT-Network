# Weather Data Network
This contains work done I've done at UNC Charlotte in building their Campus Weather Portal (weather.uncc.edu). After 4 years of work, I have made the decision to contain my work here both to benefit the community and create a long-term repository in case someone at UNCC decides to take the helm on this large project. I am proud to say that the project was ultimately low-cost yet made a large impact on our university community.

TODO: A System Diagram would be cool

## Components:
1.) WeeWx (http://www.weewx.com/)
  The WeeWx package allows for a computer to recieve data from a few different consumer weather stations and push it to a database. In our  case it is pushed to a MySQL server. The package also generates neat tabular climate reports and can directly publish charts and even a webpage. We only use the climate reports and charts portions.
2.) The Website
  The website was put together by me. The university normally uses WordPress pages to ease usage by faculty and ensure the brand is being properly presented on an official page. Because I needed to make MySQL PHP requests and just wanted all-around flexibility, I was able to get an empty server space with the domain name weather.uncc.edu under the conditions that there would be no support from the university and that the university web standards were followed (i.e. the logo and color at the top). Here you will find the code used to build this masterpiece. Of course many thanks to the developers of the numerous packages used in the creation of the website.
3.) McEniry Building Weather Display
  In addition to the website, a six panel weather display sits on the first floor of the McEniry building. I had the honor of trying to figure out how to get live data into a 'slideshow' style presentation. Using BASH scripting and the Eye of Gnome application, I was able to complete this project fairly quickly. Contained are my scripts I made, bearing in mind the display uses three computers to power the 6 monitors.
4.) Automated Weather Research and Forecasting (WRF) System
  It sounds cooler than it is. But provided you compile the WRF properly, these scripts should be able to run the model regularly and create plots for you. For some reason I think people will be more interested in this than anything...
3.) Unidata LDM (http://www.unidata.ucar.edu/)
  Having a weather display isn't cool without live data, and that is just what the outstanding folks at Unidata have allowed the university community to do for many years. Bear in mind, the LDM is useless to you unless you are a university (thus you can connect to the IDD) or you have your own NOAAPort setup (A.K.A. You've got more funding than I ever did). Included are just our config files for LDM, the rest you can get from Unidata pretty easily.
4.) Unidata GEMPAK (http://www.unidata.ucar.edu/)
  I sense a trend here.. Plotting all of the cool live data is the GEMPAK program. Yeah, it's a little dated now, but there might be a second life for it through AWIPS-II (keep your faces pressed to the Met-News for that one). Here are my various plotting scripts.
5.) Python Python Python (https://www.python.org/)
  Python's pretty cool. Here are some more scripts I've used/been working on that provide even more cool stuff for our system.

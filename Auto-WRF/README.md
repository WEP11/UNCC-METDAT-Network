# Automated WRF Execution

I started this project my junior year of undergrad with big plans, then I got this idea to make a website, then I got this idea to go to grad school. This is still one of my favorite projects to date. The concept is simple: Automatically build the namelists, run the WRF, plot the output, check the system.

To properly use this I used what I've been calling the "Domains Strategy" and it used to be on the old WRF-NMM page. The idea is simple, and I believe most WRF'ers don't use the model otherwise. Basically, don't ever run the WRF in the test folder! Make a cool folder like "MyAwesomeModel" and place a WPS and WRF folder inside. Then in each of those folders link the required files to run WPS and WRF. The result is that you can have as many model configs as you want without getting too disorganized. Although, with this script you really only need a bunch of different scripts..

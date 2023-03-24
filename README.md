# Run instructions
There are two ways to run the project outlined below. 

Once it's running you can find it here  [http://localhost:3000/rooms](http://localhost:3000/rooms/)

### Run locally
`npm install`

`npm run dev`
<br>
<br>

### Run in a Docker container
`docker-compose up --build`
<br>
<br>

---

# Given additional time


-  fix placement and styling of elements inside of each room div

-  improve responsiveness and responsive design

-  improve Book! button @click to display a modal in the center of the page saying the room was booked, including a close button to close modal and the ability to click outside of the modal to exit
	> started this but didn't finish so currently there is an awkward notification of the booked room that pops up


- improve buttons on booked rooms by changing the color of the button so it appears disabled, disable the click event, and implement a pop-up on hover saying there are none available, OR remove button altogether when room is full

-  include a link on HomeView to route to `/rooms` - currently it's an empty view

-  display an error page in the event the `axios` call failed with a link to redirect them to try the page again

- delete unnecessary files and code within the vue project

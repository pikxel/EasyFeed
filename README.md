# EasyFeed

Development notes: 

- The project is using an MVC architectue with coodinators. Also we have a Common folder where we put all the Common elements which are used commonly in our application. I like to structure my project into logical groups called Modules. One modules represents a app feature. For instance we have a Post detail module in our app where we would put all the post related code(Making new post, editing post, deleting post etc.). The current projects may look a bit of an overkill, with many empty folders, or just with one files, but I tried to follow this architechture pattern so the project is scalable. 

- I decided not to a networking library for this project, so you can more deeply evalute my programming skills and my fit into the project and the team. Because of that I am using my own lightweight networking layer. It is an older solution I wrote a few years ago. Of course using Combine and reactive programming this networking layer could be improved and simplief, but unfortunatelly I did not had time for this recently, and I think it is out of the scope of this test.

- I used the DataManager class beucase we do not have a nicely design API which returns a grouped response which aligns with the app screen architacture.


Updates I would do, but becuase of the time frame of this small excercies I felt they are out of scope of this test: 

- The DataManager class should load the comments only when we need them. So it means only when we navigate to the PostDetailViewController. Currently all the data is fetched together.(Of course with a real appication and a good API design, we would not have this issues)

- Error handling: There is a very-very basic error handling but that could be improved in many ways. 

- The CommentsViewControlelr base view should be a SrollView, so when we have a long post, the user is able to scroll

- Currently the text in the application is static, but it is a way better pratice to have a LocalizationManager(which fetches the strings/texts from the BE) to handle that, so when we decide to introduce an other language in our app, the transition can be smooth.

- The app UI is really basic, that could be improved, better colors and a  few animation would be nice also :) 

- More tests :) 

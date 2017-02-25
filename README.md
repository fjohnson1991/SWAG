# SWAG4PI

### Overview
If you love reading and sharing books with your friends, but struggle to keep track of which friend has which exact book, then SWAG4PI is the perfect solution for you! Not only can you easily add new books to your collection, but you can also update the book's details to include which friend "checked out" the book and on what date. If you decide to give the book away, you can delete the book from your collection. Sharing books with your friends is fun and easy, and with SWAG4PI keeping track of those books is now fun and easy too!

<img
src="https://cloud.githubusercontent.com/assets/20174612/23333759/63139984-fb5f-11e6-80d9-557906d8e215.png" width = "200">    <img src="https://cloud.githubusercontent.com/assets/20174612/23333512/b85ee02e-fb5a-11e6-9032-c904265207fe.png" width = "200">    <img src="https://cloud.githubusercontent.com/assets/20174612/23333556/500e07a6-fb5b-11e6-87f9-6560c717656f.png" width = "200">

<img src="https://cloud.githubusercontent.com/assets/20174612/23333527/ea2e0b02-fb5a-11e6-83da-1fa215a33c4c.png" width = "200">    <img src="https://cloud.githubusercontent.com/assets/20174612/23333537/1d3e7f40-fb5b-11e6-8a2d-98de78fc38fd.png" width = "200">    <img src="https://cloud.githubusercontent.com/assets/20174612/23333550/3f38db40-fb5b-11e6-86b4-28a4940d406c.png" width = "200">

#### Implementation Details
SWAG4PI's architectural pattern is MVC. BooksTableViewController manages NoDataView, BookTableViewCell and ClearBooksView. DetailViewController manages DetailView and ShareDropDownView. AddBookViewController manages AddBookView. All three controllers interact with the Book model.

I opted to use a singleton creational pattern to handle the data from the server in order to organize the app’s data in one place (BookDataStore). I marked the class as final to ensure that BookDataStore would not be changed or subclassed. I also set sharedInstance as static in order to prevent its methods from being overridden. Finally, the singleton's initializer is marked as private to prevent other objects from creating their own instances of the BookDataStore class.

I chose to make the Book model a class instead of a struct because any changes made to an instance of Book I wanted to be reflected throughout the app; therefore, I determined that a reference type, rather than a value type, was better suited. BookAPICalls, by contrast, I made a struct because its primary purpose is to encapsulate the functions interacting with the server; therefore, there was no need for reference semantics. Marking the functions in BookAPICalls as static allowed me to call these functions without creating an instance of BookAPICalls.

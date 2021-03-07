# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app 
  # All controller classes inherit from Sinatra::Base
- [x] Use ActiveRecord for storing information in a database
  # Database was created in environment file
  # All models inherit from ActiveRecord to store and relate their information in the database
  # Migrations were written to create tables that accurately reflect model relationships
- [x] Include more than one model class (e.g. User, Post, Category)
  # There are six model classes based on the four main models and two join tables
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
  # There are six has_many and six has_many, through relationships among the models; e.g., Teacher has_many :courses
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
  # There are six belongs_to relationships among the models, e.g., Course belongs_to Teacher
- [x] Include user accounts with unique login attribute (username or email)
  # The database is seeded with three unique users who have different emails
  # The Teacher model validates for unique email address upon signup
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
  # Example: Course, which belongs_to :teacher, has all CRUD routes
- [x] Ensure that users can't modify content created by other users
  # Helper methods were written for views to authenticate user before displaying; they check first whether someone is logged in and second whether that person owns the requested resource
  # Helper methods are kept in their own class AuthenticationHelper
- [x] Include user input validations
  # Each object has required inputs that are validated, e.g., teacher email or student name
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
  # Validation failures are sent back to try again with a flash[:message] about the failure, e.g., not using a valid email upon signup returns the user to '/signup' with the flash[:message] "Signup failed. All fields are required."
- [ ] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [ ] You have a large number of small Git commits
- [ ] Your commit messages are meaningful
- [ ] You made the changes in a commit that relate to the commit message
- [ ] You don't include changes in a commit that aren't related to the commit message
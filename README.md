# Expense Management System with Authentication and Devise Invitable

The Expense Management System is a web-based application designed to help users manage their personal and group expenses. This version of the application comes with the added security of authentication using Devise, a popular Ruby on Rails authentication solution. Users can add their personal expenses with support for expense type and medium, and also add group expenses with a splitting option to split the bills.

## Features

- Authentication with Devise for secure access
- Add personal expenses
- Add group expenses with support for splitting bills
- Categorize expenses by type
- Specify expense medium (Cash, Credit Card, Debit Card, etc.)
- Invitable module from Devise to support invitation in group expenses

## Technologies Used

The Expense Management System is built using the following technologies:

- **Backend**: Ruby on Rails
- **Database**: PostgreSQL
- **Authentication**: Devise
- **Invitation**: Devise Invitable

## Installation

1. Clone the repository using the following command:

```
git clone https://github.com/iamwaleediqbal/expensemanagementsystem.git
```


2. Install the required dependencies using bundle:

```
cd expensemanagementsystem
bundle install
```


3. Set up the database:

```
rails db:create
rails db:migrate
```

4. Start the server:

```
rails s
```

5. Open the application in a web browser at http://localhost:3000

## Usage

1. To access the application, you need to sign up first by clicking on the "Sign up" link on the home page. After signing up, you can log in using your credentials.

2. To add a personal expense, click on the "Add Personal Expense" link on the home page. Fill out the expense details such as expense name, amount, type, and medium.

3. To add a group expense, click on the "Add Group Expense" link on the home page. Fill out the expense details such as expense name, amount, type, medium, and split options. You can invite other users to join the group expense using the Invitable module from Devise.

4. To view all expenses, click on the "View Expenses" link on the home page. You can filter the expenses by type or medium.

## Future Enhancements

Some possible enhancements for the Expense Management System with Authentication and Devise Invitable are:

- Integration with third-party payment gateways
- Real-time expense tracking and notification
- Expense report generation
- Integration with mobile apps

## Conclusion

The Expense Management System with Authentication and Devise Invitable provides a secure and efficient way for users to manage their personal and group expenses. With added support for expense type and medium, and splitting options for group expenses, it makes expense management hassle-free. The application can be further improved with additional features such as integration with third-party payment gateways and expense report generation.

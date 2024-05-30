# Secret Santa Assignment Service

This project is a Secret Santa assignment service built with Ruby on Rails. It ensures that all rules are respected while assigning Secret Santa pairs, such as not assigning the same person within the last three years and not assigning immediate family members to each other.

## Technologies Used

- Ruby 3.1.0
- Rails 7.0.8
- PostgreSQL

## Setup and Installation

### Steps to Setup

1. Install the required gems:

    ```sh
    bundle install
    ```

2. Setup the database:

    ```sh
    bundle exec rails db:setup
    ```

3. Start the Rails server:

    ```sh
    bundle exec rails server
    ```

Visit `http://localhost:3000` to view the application.

### Models

- **Family:** Represents a family unit. This model groups related people together.
- **Person:** Represents an individual person. Each person belongs to a family and can have relationships with other people.
- **Relationship:** Represents the relationships between people (parent, child, sibling, spouse). This model helps in ensuring the rules are respected when assigning Secret Santa pairs.
- **GiftAssigment:** Stores the Secret Santa assignments. This model keeps track of who is giving a gift to whom and in which year.

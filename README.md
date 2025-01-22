# README

# Festival Manager API

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Getting Started](#getting-started)
- [Routes](#routes)
- [Testing](#testing)
- [Technologies Used](#technologies-used)
- [Contributors](#contributors)

## Introduction
The Festival Manager API is a tool designed to help attendees organize their personal schedules for a music festival. By providing endpoints to manage users, schedules, and shows, this API enables administrators to facilitate a better experience for festival-goers.

## Features

- Retrieve all festival schedules
- View a specific user's schedule, including associated shows
- Remove a show from a specific schedule
- Provides structured JSON responses using the `jsonapi-serializer` gem
- Designed to follow RESTful principles

## Getting Started

1. Clone the repository: [festival-manager-be](https://github.com/bwillett2003/festival-manager-be)
2. Install Dependencies:
```bundle install```
3. Set up the database: 
```rails db:create```,
```rails db:migrate```,
```rails db:seed```
4. Start Your rails server: 
```rails server```
(should be localhost:3000)

## Routes

```GET http://localhost:3000/api/v1/schedules```
- Lists all schedules.
- Example Response:
```
{
  "data": [
    {
      "id": "1",
      "type": "schedule",
      "attributes": {
        "title": "John's Schedule",
        "date": "2025-01-21",
        "shows": [
          {
            "id": 1,
            "artist": "Band A",
            "location": "Main Stage",
            "date": "2025-01-21",
            "time": "18:00:00"
          }
        ]
      }
    },
    {
      "id": "2",
      "type": "schedule",
      "attributes": {
        "title": "Jane's Schedule",
        "date": "2025-01-21",
        "shows": []
      }
    }
  ]
}
```

```GET http://localhost:3000/api/v1/schedules/:id```
- Displays a specific schedule based on the ID.
- Example Response:
```
{
  "data": {
    "id": "1",
    "type": "schedule",
    "attributes": {
      "title": "John's Schedule",
      "date": "2025-01-21",
      "shows": [
        {
          "id": 1,
          "artist": "Band A",
          "location": "Main Stage",
          "date": "2025-01-21",
          "time": "18:00:00"
        },
        {
          "id": 2,
          "artist": "Band B",
          "location": "VIP Stage",
          "date": "2025-01-21",
          "time": "20:00:00"
        }
      ]
    }
  }
}
```

```DELETE http://localhost:3000/api/v1/schedules/:schedule_id/shows/:show_id```
- Remove a specific show from a specific schedule.
- Example Response (Success):
```
{
  "message": "Show removed from schedule successfully"
}
```
- Example Response (Error):
```
{
  "error": "Show or schedule not found"
}
```

```GET http://localhost:3000/api/v1/users```
- Retrieve a list of all users, including their schedules.
- Example Response:
```
{
  "data": [
    {
      "id": "1",
      "type": "user",
      "attributes": {
        "first_name": "John",
        "last_name": "Doe",
        "email": "john.doe@example.com",
        "schedules": [
          {
            "id": 1,
            "title": "John's Schedule",
            "date": "2025-01-21",
            "shows": [
              {
                "id": 1,
                "artist": "Band A",
                "location": "Main Stage",
                "date": "2025-01-21",
                "time": "18:00:00"
              },
              {
                "id": 2,
                "artist": "Band B",
                "location": "VIP Stage",
                "date": "2025-01-21",
                "time": "20:00:00"
              }
            ]
          }
        ]
      }
    },
    {
      another user
    }
  ]
}
```

```GET http://localhost:3000/api/v1/users/:id```
- Retrieve details for a specific user, including their schedules and associated shows.
- Example Response:
```
{
  "data": {
    "id": "1",
    "type": "user",
    "attributes": {
      "first_name": "John",
      "last_name": "Doe",
      "email": "john.doe@example.com",
      "schedules": [
        {
          "id": 1,
          "title": "John's Schedule",
          "date": "2025-01-21",
          "shows": [
            {
              "id": 1,
              "artist": "Band A",
              "location": "Main Stage",
              "date": "2025-01-21",
              "time": "18:00:00"
            },
            {
              "id": 2,
              "artist": "Band B",
              "location": "VIP Stage",
              "date": "2025-01-21",
              "time": "20:00:00"
            }
          ]
        }
      ]
    }
  }
}
```

## Testing

Run command ```bundle exec rspec spec/models``` to test the Model validations and associations.

Run command ```bundle exec rspec spec/requests``` to test API endpoints.

## Technologies Used
- Ruby on Rails: Backend framework
- PostgreSQL: Database
- JSON:API Serializer: Formatting API responses

## Contributors

### Bryan Willett
- [LinkedIn Profile](https://www.linkedin.com/in/bryan--willett)
- [GitHub Profile](https://github.com/bwillett2003)

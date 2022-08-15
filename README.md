# aza-fx-api

A sample aza-fx api

**Author:** Michael Agboola

**Environments**

Ruby version - v2.7.6

**This application uses the following technologies:**

- Ruby
- Rspec
- SimpleCommand
- Jwt
- postgresql

Note: `run all commands in the applications root directory.`
`you must have docker running to be able to run this application.`

**Install all dependencies**

```
docker compose build
```

**Start the application**

```
docker compose up
```

>Once you have the app running, You run create database command in a separate terminal to create the database

**Create database**

```
docker compose run web rake db:create
```

**Stop the application**

```
docker compose down
```

**Test the application**

```
docker compose run web rspec
```

To view the Swagger API documentations visit the [localhost](http://localhost:3000/api-docs) or [deployed app](https://aza-fx-api.herokuapp.com/api-docs)

This code is deployed on heroku connecting it to github to enable continuous deployment. To access the application on AWS you can use this [link](https://aza-fx-api.herokuapp.com) as the base url.

><https://aza-fx-api.herokuapp.com>


## Aza fx APIs -

## Authentication endpoints

### Create a new user

**Endpoint** `http://localhost:3000/api/v1/register` - method (POST)

- Creates a new user

**Payload**

```json
{
  "email": "demo@gmail.com",
  "password": "password"
}
```

**Response format**

```json
{
    "id": 1,
    "email": "demo@gmail.com",
    "password_digest": "$2a$12$3rCA9FkpCnfZ7ytbX5jSw.m7KfSsXyHNbuvIxPB2be8J9qdnTyVXW",
    "user_id": "df857240-6ecf-4510-9352-90b000400c8f",
    "created_at": "2022-08-15T22:32:11.049Z",
    "updated_at": "2022-08-15T22:32:11.049Z",
}
```

### Authenticate a user

**Endpoint** `http://localhost:3000/api/v1/authenticate` - method (POST)

- Authenticates a user

**Payload**

```json
{
  "email": "demo@gmail.com",
  "password": "password"
}
```

**Response format**

```json
{
  "auth_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJkZjg1NzI0MC02ZWNmLTQ1MTAtOTM1Mi05MGIwMDA0MDBjOGYiLCJpYXQiOjE2NTMxNDU4NDksImV4cCI6MTY1MzE0OTQ0OX0.UxfmuvUcJqyVS0LKJG0CD_9oaDY8vQCKamdzNSdDrZk"
}
```

## Transaction endpoints

### Create transaction

> authentication needed

**Endpoint** `http://localhost:3000/api/v1/transactions` - method (POST)

- Creates a transaction

**Payload**

```json
{
  "input_amount": 100,
  "input_currency": "USD",
  "output_currency": "NGN"
}
```

**Response format**

```json
{
  "id": 2,
  "user_id": "8bff1719-d960-43d0-bdd5-59a2e5589c10",
  "transaction_id": "1f35c83a-0be4-4b1e-b98b-50f278dc874d",
  "input_amount": "100.0",
  "input_currency": "USD",
  "output_amount": "42331.89742",
  "output_currency": "NGN",
  "created_at": "2022-08-15T22:32:11.049Z",
  "updated_at": "2022-08-15T22:32:11.049Z"
}
```

### Get transaction by Id

> authentication needed

**Endpoint** `http://localhost:3000/api/v1/transactions/:transaction_id` - method (GET)

- Fetches single transaction detail by unique transaction id

**Response format**

```json
{
  "id": 2,
  "user_id": "8bff1719-d960-43d0-bdd5-59a2e5589c10",
  "transaction_id": "1f35c83a-0be4-4b1e-b98b-50f278dc874d",
  "input_amount": "100.0",
  "input_currency": "USD",
  "output_amount": "42331.89742",
  "output_currency": "NGN",
  "created_at": "2022-08-15T22:32:11.049Z",
  "updated_at": "2022-08-15T22:32:11.049Z"
}
```

### Get all transaction details for a particular user

> authentication needed

**Endpoint** `http://localhost:3000/api/v1/transactions` - method (GET)

- Retrieves all transaction info for a user from database

**Response format**

```json
[
    {
        "id": 1,
        "user_id": "8bff1719-d960-43d0-bdd5-59a2e5589c10",
        "transaction_id": "54f917r9-d08o-89d0-97yh-k9a2eij89c43",
        "input_amount": "100.0",
        "input_currency": "USD",
        "output_amount": "42331.89742",
        "output_currency": "NGN",
        "created_at": "2022-08-15T22:32:11.049Z",
        "updated_at": "2022-08-15T22:32:11.049Z"
    },
    {
        "id": 2,
        "user_id": "8bff1719-d960-43d0-bdd5-59a2e5589c10",
        "transaction_id": "1f35c83a-0be4-4b1e-b98b-50f278dc874d",
        "input_amount": "1000.0",
        "input_currency": "USD",
        "output_amount": "4233189.742",
        "output_currency": "NGN",
        "created_at": "2022-08-15T22:36:11.049Z",
        "updated_at": "2022-08-15T22:36:11.049Z"
    }
]
```

### application/json

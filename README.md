# Tea Subscription Service

### Jump To
- [About](#about)
- [Getting Started](#getting-started)
- [Setup](#setup)
- [Running the tests](#running-the-tests)
- [Database Schema](#database-schema)
- [Endpoint Documentation](#endpoint-documentation)

## About

This repo serves as a solo, final project for Mod 4 of [Turing School of Software & Design's Back-End program](https://backend.turing.io/).

This project was meant to simulate a take-home change we may face when entering the interview process. We were asked to block out 6 hours to complete this challenge to demonstrate our capability of time management, our planning process, and ability to create a well organized rails application. You can find the specific projects requirements [here](https://github.com/turingschool-examples/mod4-tech-challenges/blob/main/take-homes/be-take-home.md).

## Getting Started

These instructions will give you a copy of the project up and running on
your local machine for development and testing purposes.

### Setup

**Version Requirements**
* ruby 2.5.3
* rails 5.2

1. Clone this repo:

       $ git clone git@github.com:arikalea/tea-subscription.git
2. `cd` into `tea-subscription`
3. Run `bundle install`
4. Run `rails db:{create,migrate}`

## Running the tests

To check out my in-depth test suite, run:

    $ bundle exec rspec

## Endpoint Documentation

| HTTP verbs | Paths  | Used for | Output |
| ---------- | ------ | -------- | ------:|
| GET | /api/v1/customer/:customer_id/subscriptions | Get all subscriptions for a user | json |
| POST | /api/v1/customer/:customer_id/subscriptions | Create a new subscription for a user | json |
| PUT | /api/v1/customer/:customer_id/subscriptions/:subscription_id | Update status on subscription | json

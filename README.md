# README

This README would normally document whatever steps are necessary to get the
application up and running.
# Rails Engine 
You are working for a company developing an E-Commerce Application. Your team is working in a service-oriented architecture, meaning the front and back ends of this application are separate and communicate via APIs. Your job is to expose the data that powers the site through an API that the front end will consume.

## Areas of exploration and learning on this project included:
- Expose an API ⭐ ⭐ ⭐
- Use serializers to format JSON responses ⭐ ⭐ ⭐
- Test API exposure ⭐ ⭐ ⭐
- Compose advanced ActiveRecord queries to analyze information stored in SQL databases ⭐ ⭐
- Write basic SQL statements without the assistance of an ORM ⭐

## Ruby version
-Ruby 2.5.3
-Rails 5.2.5

## Getting Started 
1. Clone this repo to your machine
2. Install gem packages: `bundle install`
3. Set up your local database: `rails db:{drop,create,migrate,seed}`
4. To run the Test Suite Use: `bundle exec rspec` 
5. Start your local server `rails s`
6. Start visiting the endpoints listed below starting with: `localhost:3000//api/v1/......

## Schema 
![Database Design Document](https://i.imgur.com/71d6gUU.png)

## Available Endpoints 
### Get all merchants 
`GET /api/v1/merchants` 

*This endpoint allows you to retrieve all merchants from the database and has optional query params of per_page and page*

Example JSON Response for `GET /api/v1/merchants?per_page=2page=1` 
```{
  "data": [
    {
      "id": "1",
        "type": "merchant",
        "attributes": {
          "name": "Mike's Awesome Store",
        }
    },
    {
      "id": "2",
      "type": "merchant",
      "attributes": {
        "name": "Store of Fate",
      }
    }
    }
  ]
}```
### Get one merchant
`GET /api/v1/merchants/#{merchant_id}` 
*This endpoint allows your to retreive a specific merchant merchant their information*

Example JSON Response for `GET /api/v1/merchant/1` 
`{
  "data": {
    "id": "1",
    "type": "item",
    "attributes": {
      "name": "Super Widget",
      "description": "A most excellent widget of the finest crafting",
      "unit_price": 109.99
    }
  }
}`

### Create one Item
*This endpoint allows you to create an item resource*
`Post http://localhost:3000/api/v1/items`
Example JSON RESPONSE for `post /api/v1/items`
`{
  "name": "value1",
  "description": "value2",
  "unit_price": 100.99,
  "merchant_id": 14
}`

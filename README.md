# README

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
5. Start your local server: `rails s`
6. Start visiting the endpoints listed below starting with: `localhost:3000//api/v1/......

## Schema 
![Database Design Document](https://i.imgur.com/71d6gUU.png)

## Available Endpoints 
### Get all resources Merchant or Items 
`GET /api/v1/merchants` 

*This endpoint allows you to retrieve all merchants from the database and has optional query params of per_page and page.*

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
}
```
### Get one resource--Item or Merchant

`GET /api/v1/merchants/#{merchant_id}` 

*This endpoint allows your to retreive a specific merchant merchant their information.*

Example JSON Response for `GET /api/v1/merchant/1` 

```{
  "data": {
    "id": "1",
    "type": "item",
    "attributes": {
      "name": "Super Widget",
      "description": "A most excellent widget of the finest crafting",
      "unit_price": 109.99
    }
  }
}
```

### Create a resource Item or Merchant

*This endpoint allows you to create an item resource.*

`Post http://localhost:3000/api/v1/items`

Example JSON RESPONSE for `post /api/v1/items`

```{
  "name": "value1",
  "description": "value2",
  "unit_price": 100.99,
  "merchant_id": 14
}
```

### Get an Items Merchant or Merchants Items 

*This endpoint allows you to grab and items merchant or grab all the items of a specific merchant based on associations.* 

`GET http://localhost:3000/api/v1/items/{{item_id}}/merchant` 

### Update an Item resource 
*This endpoint allows your to update an item resource based on headers that your pass into your request.*

`PUT http://localhost:3000/api/v1/items/{{item_id}}`

*Accepted JSON* 

```
{
  "name": "value1",
  "description": "value2",
  "unit_price": 100.99,
  "merchant_id": 14
}
```

### Destroy an Item 

*This endpoint will destroy the record based on id passed in and also destroy any invoices where only that item is on them*

*No JSON will be returned from this response* 


### Get one Merchant based on name fragment

*This endpoint will get on merchant based on name fragment. If multiple records exist it will return the first based on alphabetical order.* 

Example JSON response to `http://localhost:3000/api/v1/merchants/find?name=iLl`

``` 
{
"data": {
"id": "28",
"type": "merchant",
"attributes": {
"name": "Schiller, Barrows and Parker"
}
}
}
```

### Get all Items based on min and max price or name fragment 

*This endpoint will return all the records based on min and max price or a name fragment. You can also pass in each param individually.* 

Example JSON response of `http://localhost:3000/api/v1/items/find_all?max_price=54&min_price=53` 
```
{
"data": [
{
"id": "478",
"type": "item",
"attributes": {
"name": "Item Quibusdam Consequatur",
"description": "Modi distinctio autem commodi ut officiis sunt consequatur. Mollitia officiis repellendus asperiores eius odit et est. Aperiam hic velit sit dolores quia. Quis veniam facere harum iusto. Odio libero aliquam accusamus voluptas eligendi incidunt.",
"unit_price": 53.84,
"merchant_id": 24
}
},
{
"id": "1061",
"type": "item",
"attributes": {
"name": "Item Doloremque Enim",
"description": "Dignissimos impedit deleniti qui. Id praesentium aliquam illum nam. Rerum dicta illo quia ut saepe commodi quis.",
"unit_price": 53.17,
"merchant_id": 47
}
}
]
}
```

## Business Intelligence Endpoints 

### Get all Merchants based on revenue sorted by highest revenue

*This endpoint will retreive all the merchants based on revenue. You can pass in an optional param of how many merchants you would like returned.* 

Example JSON respone of `http://localhost:3000/api/v1/revenue/merchants?quantity=2` 

```
{
"data": [
{
"id": "14",
"type": "merchant_name_revenue",
"attributes": {
"name": "Dicki-Bednar",
"revenue": 1148393.7399999984
}
},
{
"id": "89",
"type": "merchant_name_revenue",
"attributes": {
"name": "Kassulke, O'Hara and Quitzon",
"revenue": 1015275.1500000001
}
}
]
}
```

### Get merchants who sold the most items 

*This endpoint will return the merchants based on items sold. This endpoint has an optional parameter determining merchants returned.* 

Example JSON response of `http://localhost:3000/api/v1/merchants/most_items?quantity=1` 

```
{
"data": [
{
"id": "89",
"type": "merchant_item_count",
"attributes": {
"name": "Kassulke, O'Hara and Quitzon",
"count": 1653
}
}
]
}
```

### Get revenue of a single merchant 

*This endpoint returns the revenue of a specific merchant.* 

Example JSON of `GET http://localhost:3000/api/v1/revenue/merchants/1` 

```
{
"data": {
"id": "1",
"type": "merchant_revenue",
"attributes": {
"revenue": 528774.6400000004
}
}
}
```

### Get Items with the most revenue 

*This endpoint returns the items with the most revenue. You can pass an optional paramater of how many you would like returned. 

Example JSON response of `http://localhost:3000/api/v1/revenue/items?quantity=2` 

```
{
"data": [
{
"id": "227",
"type": "item_revenue",
"attributes": {
"name": "Item Dicta Autem",
"description": "Fugiat est ut eum impedit vel et. Deleniti quia debitis similique. Sint atque explicabo similique est. Iste fugit quis voluptas. Rerum ut harum sed fugiat eveniet ullam ut.",
"unit_price": 853.19,
"merchant_id": 14,
"revenue": 1148393.7399999984
}
},
{
"id": "2174",
"type": "item_revenue",
"attributes": {
"name": "Item Nam Magnam",
"description": "Eligendi quibusdam eveniet temporibus sed ratione ut magnam. Sit alias et. Laborum dignissimos quos impedit excepturi molestiae.",
"unit_price": 788.08,
"merchant_id": 89,
"revenue": 695086.5599999998
}
}
]
} 
``` 

### Get all Invoices that are unshipped and are potential revenue 

Example JSON response of `http://localhost:3000/api/v1/revenue/unshipped` 

```
{
"data": [
{
"id": "4844",
"type": "unshipped_order",
"attributes": {
"potential_revenue": 1504.08
}
}
]
}
```

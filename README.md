# Tea Subscription Service

This is a Rails API for a Tea Subscription Service. The API provides endpoints to manage tea subscriptions for customers.

## Endpoints

### Subscribe a Customer to a Tea Subscription

Endpoint:
`POST /api/v0/subscriptions`


This endpoint allows a customer to subscribe to a tea subscription. JSON Response:

 ```
  {data:
    {id:"91", 
    type:"subscription", 
    attributes:
      {tea_id:109, 
      customer_id:77, 
      price:55.0, 
      frequency:8, 
      status:"active"}
      }
  }
  ```

### Cancel a Customer's Tea Subscription

Endpoint:
`patch /api/v0/subscriptions/:id`


This endpoint allows a customer to cancel their tea subscription. JSON Response: 
```
  {data:
    {id:"92",
    type:"subscription",
    attributes:
      {tea_id:110, 
      customer_id:78, 
      price:55.0, 
      frequency:8, 
      status:"cancelled"}
    }
  }
```
### Retrieve a Customer's Subscriptions

Endpoint:
` get /api/v0/customers/subscriptions`

This endpoint retrieves all of a customer's subscriptions, including both active and cancelled subscriptions. JSON Response: 
```
  {:data=>
  {:subscriptions=>
    {:active=>
      [{:id=>94,
        :title=>"White Tea",
        :price=>20.0,
        :status=>"active",
        :frequency=>4,
        :customer_id=>79,
        :tea_id=>112,
        :created_at=>"2024-05-04T21:38:55.096Z",
        :updated_at=>"2024-05-04T21:38:55.096Z"},
       {:id=>95,
        :title=>"Yellow Tea",
        :price=>29.99,
        :status=>"active",
        :frequency=>6,
        :customer_id=>79,
        :tea_id=>113,
        :created_at=>"2024-05-04T21:38:55.098Z",
        :updated_at=>"2024-05-04T21:38:55.098Z"}],
     :cancelled=>
      [{:id=>93,
        :title=>"Black Tea",
        :price=>8.2,
        :status=>"cancelled",
        :frequency=>2,
        :customer_id=>79,
        :tea_id=>111,
        :created_at=>"2024-05-04T21:38:55.093Z",
        :updated_at=>"2024-05-04T21:38:55.093Z"}]}}}
```

## Database Schema

```ruby
ActiveRecord::Schema[7.1].define(version: 2024_05_02_164818) do
  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "address"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "title"
    t.float "price"
    t.integer "status"
    t.integer "frequency"
    t.bigint "customer_id", null: false
    t.bigint "tea_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_subscriptions_on_customer_id"
    t.index ["tea_id"], name: "index_subscriptions_on_tea_id"
  end

  create_table "teas", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "temp"
    t.integer "brew_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "subscriptions", "customers"
  add_foreign_key "subscriptions", "teas"
end
```
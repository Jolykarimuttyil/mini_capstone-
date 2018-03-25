require "unirest"
# print "enter email: "
# email = gets.chomp
# print "enter password: "
# password = gets.chomp
email = "joe@email.com"
password = "password"

# Login and set jwt as part of Unirest requests
response = Unirest.post(
  "http://localhost:3000/user_token",
  parameters: {
    auth: {
      email: email,
      password: password
    }
  }
)
jwt = response.body["jwt"]
Unirest.default_header("Authorization", "Bearer #{jwt}")


system "clear"
puts "Your jwt is #{jwt}"
puts "Welcome to Products app! choose an option:"
puts "[1] See all Products"
puts " [1.1] search by name"
puts "[2] Pick a Product"
puts "[3] Create a product"
puts "[4] update a product"
puts "[5] destory a product"
puts "[signup] create a new user"
puts "[order]" 
puts "[7] See all orders"
puts "[8] add item to cart"
puts "[9] view all carted items"

input_option = gets.chomp
if input_option == "1"
  response = Unirest.get("http://localhost:3000/v1/products")
  product = response.body 
  puts JSON.pretty_generate(product)
  elsif input_option == "1.1"
    response = Unirest.get("http://localhost:3000/v1/products?q=LED")
    product = response.body 
    puts JSON.pretty_generate(product)
      

  elsif input_option == "2"
    print "Enter a product id: "
    product_id = gets.chomp 
    response = Unirest.get("http://localhost:3000/v1/products/#{product_id}")
    product = response.body 
    if product["errors"] 
      puts "Un oh! Something went wrong.. "
      p product["errors"]
    else 
      puts " Here is your product information"
      puts JSON.pretty_generate(product)
    end 

  elsif input_option == "3"
    print "name: "
    name = gets.chomp
    print "price:"
    price = gets.chomp
    print "description:"
    description = gets.chomp

    params = {
      "name" => name,
      "price" => price,
      "description" => description
      
    } 
    response = Unirest.post("http://localhost:3000/v1/products", parameters: params)
    product = response.body 
    puts JSON.pretty_generate(product)
 
  elsif input_option == "4"
    print "Enter a product id: "
    product_id = gets.chomp 
    params = {}
    print "Name: " 
    params ["input_name"] = gets.chomp 
    print "price: "
    params ["input_price"] = gets.chomp 
    print "description: "
    params ["input_description"] = gets.chomp 
    params.delete_if { |_key,value | value.empty?}
    response = Unirest.patch("http://localhost:3000/v1/products/#{product_id}", parameters: params)
    product = response.body 
    if product["errors"]
      puts "Un Oh! Something went wrong..."
      p product["errors"]
    else 
      puts "Here is product information"
      puts JSON.pretty_generate(product)
    end

  elsif input_option == "5"
    print "Enter a product id: "
    product_id = gets.chomp 
    response = Unirest.delete("http://localhost:3000/v1/products/#{product_id}")
    body = response.body 
    puts JSON.pretty_generate(body)

  elsif input_option == "signup"
    params = {}
    print "enter name: "
    params["name"] = gets.chomp
    print "enter a email: "
    params["email"] = gets.chomp
    print "enter a password: "
    params["password"] = gets.chomp
    print "password_conformation: "
    params["password_conformation"] = gets.chomp

    response = Unirest.post("http://localhost:3000/v1/users", parameters: params)
    p response.body    

  elsif input_option == "order"
    params = {
    product_id: 2,
    quantity: 4
  }
    response = Unirest.post("http://localhost:3000/v1/orders", parameters: params)
    order = response.body
    puts JSON.pretty_generate(order)

  elsif input_option == "7"
    puts "Here are all your orders"
    response = Unirest.get("http://localhost:3000/v1/orders")
    orders = response.body
    puts JSON.pretty_generate(orders)

   elsif input_option == "8"
    params = {}
    print "enter product id: "
    params["product_id"] = gets.chomp
    print "enter quantity: "
    params["quantity"] = gets.chomp

    response = Unirest.post("http://localhost:3000/v1/carted_product", parameters: params)
    carted_product = response.body
    puts JSON.pretty_generate(carted_product)

    elsif input_option == "9"
      response = Unirest.get("http://localhost:3000/v1/carted_product")
      carted_product = response.body 
      puts JSON.pretty_generate(carted_product)
    
end 

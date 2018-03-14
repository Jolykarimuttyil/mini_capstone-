require "unirest"
system "clear"

puts "Welcome to Products app! choose an option:"
puts "[1] See all Products"
puts "[2] Pick a Product"
puts "[3] Create a product"
puts "[4] update a product"
puts "[5] destory a product"

input_option = gets.chomp
 if input_option == "1"
   response = Unirest.get("http://localhost:3000/v1/products")
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
      puts render JSON.pretty_generate(product)
    end 

  elsif input_option == "3"
    print "name: "
    name = gets.chomp
    print "price:"
    price = gets.chomp
    print "description:"
    description = gets.chomp

    params = {
      "input_name" => name,
      "input_price" => price,
      "input_description" => description
      
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
    puts JSON.pretty_generate(product)

    
 end 

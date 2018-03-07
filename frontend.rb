require "unirest"
system "clear"

response = Unirest.get("http://localhost:3000/product_url")
product = response.body
puts JSON.pretty_generate(product)

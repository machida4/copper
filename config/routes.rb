# example:
# get "top", to: {controller: "top", action: "index"}

# top
get "/", to: {controller: "top", action: "index"}

# user
get "/users", to: {controller: "user", action: "index"}
post "/users/create", to: {controller: "user", action: "create"}

# example:
# get "top", to: {controller: "top", action: "index"}

# top
get "/", to: {controller: "top", action: "index"}

# user
get "/users", to: {controller: "user", action: "index"}
get "/users/:id", to: {controller: "user", action: "show"}
post "/users/create", to: {controller: "user", action: "create"}

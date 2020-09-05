# example:
# get "top", to: {controller: "top", action: "index"}

# top
get "/", to: {controller: "top", action: "index"}

# user
get "/users", to: {controller: "user", action: "index"}
get "/users/:id", to: {controller: "user", action: "show"}
post "/users", to: {controller: "user", action: "create"}
post "/users/:id", to: {controller: "user", action: "update"}
post "/users/delete/:id", to: {controller: "user", action: "destroy"}

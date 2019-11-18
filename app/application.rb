class Application
    @@items = []

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            name_of_item = req.path.split("/items/").last
            find_item = @@items.find{|i| i.name == name_of_item}
            if find_item
                resp.write(find_item.price)
            else
                resp.write "Item not found"
                resp.status = 400
            end
        else
            resp.write "Route not found"
            resp.status = 404
        end

        resp.finish
    end
end
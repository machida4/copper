module Processing
  class Processor
    CONTENT_TYPE = 'text/html;charset=utf-8'

    attr_reader :req

    def initialize(req)
      @req = req
    end

    def process
      con = ::Routing::Router.new(req).processed_controller

      ::Rack::Response.new do |r|
        r.status = con.status
        r.write(con.body)
        r.content_type = CONTENT_TYPE
      end
    end
  end
end
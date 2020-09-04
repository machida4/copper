module Controller
  class Template
    attr_reader :req, :name, :action, :location
    attr_accessor :status, :body

    def initialize(req: nil, name: nil, action: nil)
      @req = req
      @name = name
      @action = action
    end

    def call(action)
      send(action)
      self.status ||= 200
      self.body = template.render(self)
      self
    end

    private

    def redirect_to(loc)
      @location = loc
      self.status = 301
    end

    # あとで別のクラスに分ける
    def template
      Tilt.new(view_path, :format => :html5)
    end

    def view_path
      file_paths = Pathname.glob(Copper.root.join("app", "views", "#{self.name}", "#{self.action}.*"))
      raise NoViewFileError if file_paths.empty?
      raise PluralViewFileError unless file_paths.one?

      file_paths.first
    end

    # TODO: symbolize_keysとか作ってsupportモジュール的なものを用意して隔離したい
    def params
      req.params.transform_keys { |key| key.to_sym rescue key }
    end
  end

  class NoViewFileError < StandardError
    def initialize(msg="No View File Found")
    end
  end

  class PluralViewFileError < StandardError
    def initialize(msg="Plural View File Found (expected only one)")
    end
  end
end

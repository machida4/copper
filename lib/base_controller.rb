class BaseController
  attr_reader :req, :name, :action
  attr_accessor :status, :body

  def initialize(req: nil, name: nil, action: nil)
    @req = req
    @name = name
    @action = action
  end

  def call(action)
    send(action)
    self.status = 200
    self.body = template.render(self)
    self
  end

  # あとで別のクラスに分ける
  def template
    Haml::Engine.new(read_view, :format => :html5)
  end

  private

  def read_view
    view_path.read
  end

  def view_path
    Copper.root.join("app", "views", "#{self.name}", "#{self.action}.html.haml")
  end

  # TODO: symbolize_keysとか作ってsupportモジュール的なものを用意して隔離したい
  def params
    req.params.transform_keys { |key| key.to_sym rescue key }
  end
end
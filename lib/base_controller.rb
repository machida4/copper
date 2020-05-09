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

  private

  # あとで別のクラスに分ける
  def template
    Tilt.new(view_path, :format => :html5)
  end

  def view_path
    file_paths = Pathname.glob(Copper.root.join("app", "views", "#{self.name}", "#{self.action}.*"))
    raise TwoViewFileError unless file_paths.one?

    file_paths.first
  end

  # TODO: symbolize_keysとか作ってsupportモジュール的なものを用意して隔離したい
  def params
    req.params.transform_keys { |key| key.to_sym rescue key }
  end
end
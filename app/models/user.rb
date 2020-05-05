module Relations
  class Users < ROM::Relation[:sql]

    # schemaをROM::Relationの継承クラスの中で使うことでデータベースのスキーマを定義できる
    # MySQLなどのデータベースを使っていれば、`schema(infer: true)`の一文でスキーマ推論を有効化できる

    schema(:users) do
      attribute :id, Types::Serial
      attribute :name, Types::String
      attribute :age, Types::Integer
      attribute :has_car, Types::Bool
    end

    # インスタンスメソッドを定義することで、Relationが持つメソッドを追加できる
    # ここでは、Relationが対象としているアダプタ（例えばこのコードの場合はSQLite）
    # に定義された固有の操作が行える。whereはSQLiteアダプタの中で定義されている。

    def all
      where()
    end

    def has_car
      where(has_car: true)
    end

    # デフォルトではすべてのカラムが返り値のレコードに含まれて返されるが
    # それを変更したければdatasetを定義することができる。
    # この例の場合はhas_carを意図的にレコードに含めないようにしている。

    dataset do
      select(:id, :name, :age)
    end

  end
end
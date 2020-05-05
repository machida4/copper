# Copper

Ruby製オレオレWebフレームワーク

## Usage

gemインストール

- ```$ bundle install```

起動

- ```$ bundle exec rackup -s puma```

DBセットアップ

- `config/database.yml`に設定を記述

- `$ bundle exec db:setup`でDBセットアップ

- `$ bundle exec db:create_migration[create_users]`にようにするとmigrationファイルが作成される

- `bundle exec rake db:migrate`でmigrationファイルを適用

## つかってるもの

- Rack
- Puma
- Haml
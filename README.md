# specmon

Monitor your specs runtime.

[Try it out](https://specmon-demo.herokuapp.com/)

[![Screenshot](https://raw.githubusercontent.com/instacart/specmon/master/doc/screenshot.png)](https://libraries.io/rubygems/specmon)

:tangerine: Battle-tested at [Instacart](https://www.instacart.com/opensource)

:envelope: [Subscribe to releases](https://libraries.io/rubygems/specmon)

## Docs

- [Installation](#installation)
- [Configuration](#configuration)
- [Adapters Configuration](#adapters)
- [Owners](#owners)
- [Fetching data](#fetching-data)

## Installation

Add this line to your application’s Gemfile:

```ruby
gem 'specmon'
```

Run:

```sh
rails g specmon:install
rake db:migrate
```

And mount the dashboard in your `config/routes.rb`:

```ruby
mount Specmon::Engine, at: "specmon"
```

Add to `assets/javascript/application.js`

```
//= require specmon/application
```

Add to `assets/stylesheet/application.scss`

```
 *= require specmon/application
```

## Configuration

Specmon supports multiple projects :tada:

Add additional projects in `config/specmon.yml`:

```yml
projects:
  project-1-master:
    url: <%= ENV["SPECMON_DATABASE_URL"] %>
    name: <%= ENV["PROJECT_1_CIRCLE_NAME"] %>
    username: <%= ENV["PROJECT_1_CIRCLE_USERNAME"] %>
    token: <%= ENV["PROJECT_1_CIRCLE_TOKEN"] %>
    branch: master
    show_owners: true
    adapter: circleci
  project-2-master:
    url: <%= ENV["SPECMON_DATABASE_URL"] %>
    name: <%= ENV["PROJECT_2_CIRCLE_NAME"] %>
    username: <%= ENV["PROJECT_2_CIRCLE_USERNAME"] %>
    token: <%= ENV["PROJECT_2_CIRCLE_TOKEN"] %>
    branch: master
    show_owners: false
    adapter: circleci

# change the time zone
# time_zone: "Pacific Time (US & Canada)"
```

## Adapters

Specmon supports CircleCI

Override test section in your `circle.yml` file to generate a `rspec.xml` file

```yaml
test:
  override:
    - bundle exec rspec --backtrace --color --profile --format documentation --format RspecJunitFormatter --out $CIRCLE_TEST_REPORTS/rspec.xml
```

And in your `Gemfile`

```ruby
group :test do
  gem 'rspec_junit_formatter', github: 'instacart/rspec_junit_formatter'
end
```

## Owners

By using `show_owners` and `instacart/rspec_junit_formatter`, you can assign a `owner`to your spec and display runtime per `owner`.

```ruby
describe 'team1', owner: :team1 do
  it 'It success' do
     expect(true).to eq(true)
  end
end
```

## Fetching data

You can fetch data from circle by adding in your `cron` file:

```
*/5 * * * * rake specmon:project-1-master:recent_builds
*/5 * * * * rake specmon:project-2-master:recent_builds
```

## Thanks

Specmon uses a number of awesome, open source projects.

- [Rails](https://github.com/rails/rails)
- [chartkick](https://github.com/ankane/chartkick)
- [bootstrap](http://getbootstrap.com)
- [bootstrap-select](https://silviomoreto.github.io/bootstrap-select)
- [RspecJunitFormatter](https://github.com/sj26/rspec_junit_formatter)

Created by [rahilsondhi](https://github.com/rahilsondhi) and [kwent](https://github.com/kwent)

## Want to Make Specmon Better?

That’s awesome! Here are a few ways you can help:

- [Report bugs](https://github.com/instacart/specmon/issues)
- Fix bugs and [submit pull requests](https://github.com/instacart/specmon/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features

# Darp


## Discontinued

The gem is discontinued. There are some issues with it not respecting the database pool allocations of active record, resulting in random database pool errors through out the rails projekt. That has to be addressed before darp can be used for production purposes.

Further, I yanked darp (0.1.0) from rubygems as I got some security alerts due to some of its dependencies.

In my company we currently have no need for this gem. If that changes I might resurrect it at that point.

# Previous description

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'darp'
```

And then execute:
```bash
$ bundle
$ rails darp:install:migrations
$ rails db:migrate
```

## Usage

### View

    = DARP_async_download 'Generate report (gets class disabled while processing)', report_path(@report)
    = DARP_async_download 'Generate report (replaced with text while processing)', report_path(@report), replace_with: 'please wait'
    = DARP_async_download 'Generate report (replaced with spinner)', report_path(@report), class: 'btn', replace_with: :spinner

### Controller

```ruby
def show
  DARP_enqueue(MyGenerator, report_params, 'report.jpg')
end
```

### Job

In `/app/jobs/` make your job wich inherits from `Darp::GeneratorJob` and has a function called generate which returns file data:

```ruby
class MyGenerator < Darp::GeneratorJob
  def generate(job_params)
   require 'open-uri'

   sleep 5
   open('https://upload.wikimedia.org/wikipedia/commons/e/ee/Billede_084.jpg').read
  end
end
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

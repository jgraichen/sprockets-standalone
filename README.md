# Sprockets::Standalone

Rack task library for using Sprockets standalone.

## Installation

Add this line to your application's Gemfile:

    gem 'sprockets-standalone'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sprockets-standalone

## Usage

Require sprockets-standalone in your Rakefile and define the task:

```
require 'sprockets/standalone'

Sprockets::Standalone::RakeTask.new(:assets) do |task, sprockets|
  task.assets   = %w(app.js app.css *.png *.svg *.woff)
  task.sources  = %w(app/assets vendor/assets)
  task.output   = File.expand_path('../assets', __FILE__)
  task.manifest_name  = 'manifest.json'

  sprockets.js_compressor  = :uglifier
  sprockets.css_compressor = :sass
end
```

You can give a name to the task that will be used for namespacing. The example above will generate the rake tasks`assets:compile`, `assets:clobber` and `assets:clean`. Default value for name is `assets`.

If you pass a block you can configure additional parameters:

1)	`task.assets` - Defines the list of assets that should be compiled for you. By default it contains `application.js`, `application.css` and `*.png`, `*.jpg`, `*.gif`.

2)	`task.source` - Defines a list of source directories. The specified paths will be added to sprockets' include path. If you want a sprockets directory structure similar to Rails you need to add all paths: `task.sources = %w(app/assets/javascripts app/assets/stylesheets app/assets/images)`.

3)	`task.output` - Define output directory. Default is `dist`.

4)	`task.manifest_name` - Set the name to be used for the `manifest.json`

5)	`task.environment` - Set custom sprockets environment.

You can also customize the sprockets environment in the block to configure additional preprocessors or compressors.

Note: Sprockets-standalone will always use a manifest.json even when asset digests are turned off. The manifest.json will be used to track changes. If you manually change the generated assets that will not be override when compiling assets unless there is also a change if the matching source files.

You will need to remove generated assets (`rake assets:clobber`) to force regeneration of all assets.

## Contributing

1. Fork it ( http://github.com/jgraichen/sprockets-standalone/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

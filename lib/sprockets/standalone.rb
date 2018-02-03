require "sprockets/standalone/version"
require "rake"
require "rake/tasklib"
require "sprockets"

module Sprockets
  module Standalone
    class RakeTask < ::Rake::TaskLib
      # List of sprocket file targets that
      # should be compiled.
      attr_accessor :assets

      # List of source directories. This is a convenience
      # method as it will add all available sub-directories
      # like `stylesheets`, `javascripts` to sprockets
      # include path.
      #
      # Example: If you have a typical sprockets directory
      # layout like `src/assets/stylesheets`,
      # `src/assets/javascripts` all you need to add to
      # `source` is `src/assets`.
      attr_accessor :sources

      # Set output directory. Defaults to `dist` in current
      # working directory.
      attr_accessor :output

      # `Environment` instance used for finding assets.
      attr_accessor :environment

      # Full path to the manifest json file
      attr_accessor :manifest_name

      def index
        @index ||= environment.index if environment
      end

      def manifest
        @manifest ||= Sprockets::Manifest.new index, File.join(output, manifest_name)
      end

      def initialize(*args)
        @namespace   = args.shift || :assets
        @assets      = %w(application.js application.css *.png *.jpg *.gif)
        @sources     = []
        @output      = File.expand_path('dist', Dir.pwd)
        @manifest_name    = 'manifest.json'

        @environment = Sprockets::Environment.new(Dir.pwd) do |env|
          env.logger = Logger.new $stdout
          env.logger.level = Logger::INFO
        end

        yield self, environment if block_given?

        Array(sources).each { |source| environment.append_path source }

        namespace @namespace do
          desc 'Compile assets'
          task :compile do
            manifest.compile *Array(assets)
          end

          desc 'Remove all assets'
          task :clobber do
            manifest.clobber
          end

          desc 'Clean old assets'
          task :clean do
            manifest.clean
          end
        end
      end
    end
  end
end

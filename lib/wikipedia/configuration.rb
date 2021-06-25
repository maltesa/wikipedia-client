module Wikipedia
  class Configuration
    DEFAULT = {
      protocol: 'https',
      domain: 'en.wikipedia.org',
      path: 'w/api.php',
      user_agent: 'wikipedia-client/1.7 (https://github.com/kenpratt/wikipedia-client)'
    }

    def initialize(configuration = DEFAULT)
      configuration.each { |args| self.send(*args) }
    end

    def [](directive)
      send(directive)
    end

    def self.directives(*directives)
      directives.each do |directive|
        define_method directive do |*args|
          return instance_variable_get("@#{directive}") if args.empty?

          instance_variable_set("@#{directive}", args.first)
        end
      end
    end

    directives :protocol, :domain, :path, :user_agent
  end
end

module PuppetX
  module BSD
    class Util
      def self.normalize_config(config)
        raise ArgumentError,
          "Config object must be a Hash" unless config.is_a? Hash
        config.reject!{|k,v| k == :undef or v == :undef }
      end

      def self.validate_config(config,required_items,optional_items)
        raise ArgumentError,
          "Config object must be a Hash" unless config.is_a? Hash
        required_items.each do |k,v|
          unless config.keys.include? k
            raise ArgumentError, "#{k} is a required configuration item"
          end
        end

        config.each do |k,v|
          unless required_items.include? k or optional_items.include? k
            raise ArgumentError, "unknown configuration item found: #{k}"
          end
        end
      end
    end
  end
end

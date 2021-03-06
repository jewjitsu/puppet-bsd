# Module: PuppetX::Hostname_if::Vlan
#
# Responsible for processing the vlan(4) interfaces for hostname_if(5)
#

require 'puppet_x/bsd/hostname_if/inet'

module PuppetX
  module BSD
    class Hostname_if
      class Vlan

        attr_reader :content

        def initialize(config)
          @config = config
          validate_config()
        end

        def validate_config

          # compensate for puppet oddities
          @config.reject!{ |k,v|
            k == :undef or v == :undef or v.length == 0
          }

          required_config_items = [
            :id,
            :device,
          ]

          available_config_items = [
            :address,
          ]

          # verify we have the required configuration items
          required_config_items.each do |k,v|
            unless @config.keys.include? k
              raise ArgumentError, "#{k} is a required configuration item"
            end
          end

          @config.each do |k,v|
            all_options = [available_config_items,required_config_items].flatten
            unless all_options.include? k
              raise ArgumentError, "unknown configuration item found: #{k}"
            end
          end
        end

        # Return an array of values to place on each line
        def values
          inet  = []
          if @config[:address]
            PuppetX::BSD::Hostname_if::Inet.new(@config[:address]).process {|i|
              inet << i
            }
          end

          data = []
          data << vlan_string()
          data << inet if inet
          data.flatten
        end

        def content
          values().join("\n")
        end

        def vlan_string
          vlanstring = []
          vlanstring << 'vlan' << @config[:id]
          vlanstring << 'vlandev' << @config[:device]
          vlanstring.join(' ')
        end
      end
    end
  end
end

# Puppet BSD

[![Build Status](https://travis-ci.org/puppetlabs-operations/puppet-bsd.png)](https://travis-ci.org/puppetlabs-operations/puppet-bsd)

A Puppet module for BSD.

## bsd::network:interface

Declaring an interface is easy, and fun.

    bsd::network::interface { 're0':
      description => 'Primary interface',
      values      => [ 'dhcp' ],
    }



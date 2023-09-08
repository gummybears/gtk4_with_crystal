![Build Status](https://github.com/hugopl/gio.cr/actions/workflows/ci.yml/badge.svg?branch=main)

# Pango.cr

Crystal bindings for [GIO](https://docs.gtk.org/gio/) library

Currently this shard only exists to be shared between [GTK4](https://github.com/hugopl/gtk4.cr) and
[GTK3](https://github.com/phil294/gtk3.cr) shards.

Some usage examples can be found in [GTK4 Crystal bindings examples](https://github.com/hugopl/gtk4.cr/tree/master/examples).

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     gio:
       github: hugopl/gio.cr
   ```

2. Run `shards install`

## Usage

```crystal
require "gio"
```

## Contributing

1. Fork it (<https://github.com/hugopl/gio.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Hugo Parente Lima](https://github.com/hugopl) - creator and maintainer

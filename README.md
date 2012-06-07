# Lifeguard Random Data Source

This is an example of a plugin for Lifeguard that implements a data source.
The data source in this example simply generates random numbers.

## Installation

To install the plugin, compile it and generate the release folder:

    $ make deps
    $ make rel

There will now be a folder `rel/lifeguard_random`. Copy this folder
into your Lifeguard plugin directory and add `lifeguard_random` to the
list of enabled plugins for Lifeguard. That's it!

## Usage

Once the plugin is installed, you can use the random data source with your
watches. To do this, enable the plugin and add a new data source to your
`sys.config` file. Example:

```erlang
{data_sources, [
    {"random", lifeguard_ds_random, []}
  ]},
{plugins, [lifeguard_random]}
```

Then, you can query it like this from a watch:

```javascript
// Get one random number (in an array)
var data = Lifeguard.get("random");

// Get 10 random numbers
var data = Lifeguard.get("random", 10);
```

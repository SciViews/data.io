# data.io News

## Changes in data.io 1.2.2

- The example iris_sidecar.csv.R wrongly referred to data::read() instead of
  data.io::read().


## Changes in data.io 1.2.1

- The French translation for the trees dataset had no as_labelled() argument


## Changes in data.io 1.2.0

- It is now possible to specify the default language to use for read() with
  the option `data.io-lang`.

- `lang` and `lang_encoding` are now recoarde as attributes of the comment of
  the imported object.


## Changes in data.io 1.1.0

- A basic version of write() is now available.

- data_types() function added to easily get information about data types that
  can be read() or write()

- Description added into "read_write" options.


## Changes in data.io 1.0.1

- Bug corrected: forgot to change 'data' -> 'data.io' in 'read_write' options.


## Changes in data.io 1.0.0

First version of the package on Github.

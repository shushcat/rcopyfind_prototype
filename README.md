# RCopyfind

This program compares pairs of text files to determine whether a source text is likely to have influenced the author of a target text.  The algorithm used to compare texts is inspired by [WCopyfind](http://plagiarism.bloomfieldmedia.com/wordpress/software/wcopyfind/), but there are a few significant differences.  First, RCopyfind is implemented in Ruby with C-extensions, so is portable across platforms, whereas WCopyfind and it's command-line cousin Copyfind both only run on Windows as of September 2018.  Second, some additional functionality has been added to RCopyfind, making it somewhat more suitable to studies involving large corpora in which there are many spelling variations.  Specifically, RCopyfind uses [an implementation of the Porter stemmer](https://github.com/romanbsd/fast-stemmer) to remove some spelling differences, allows for filtering matches using a [stop word](https://en.wikipedia.org/wiki/Stop_words) list, and has preliminary support for matching words based on [edit distance](https://en.wikipedia.org/wiki/Edit_distance) using [a modified Levenshtein distance module](https://github.com/GlobalNamesArchitecture/damerau-levenshtein).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rcopyfind'
```

And then execute:

    $ bundle

Or run it from the command line by executing:

    $ ruby -Ilib ./bin/rcopyfind.rb

from the RCopyfind directory.

Later, you will be able to install it using:

    $ gem rcopyfind

Once installation from Rubygems is possible, will be callable directly, i.e. with the command `rcopyfind`.

## Usage

To check for similar passages in a target and source text with the default parameters, run the command `rcopyfind.rb -t <target file> -s <source file>`.

Allowable parameters are viewable with the `-h` flag, and are as follows.

| Flag         | Description                                                                |
|--------------|----------------------------------------------------------------------------|
| -s <file>    | path to **s**ource file                                                    |
| -t <file>    | path to **t**arget file                                                    |
| -w           | **w**indow in which to check for shared words                              |
| -msw         | **m**inimum **s**hared **w**ords for a window to be considered a match     |
| -mwl         | **m**inimum **w**ord **l**ength for matched words                          |
| -no          | allow for window matches which are **n**ot **o**rdered                     |
| -stem        | **stem** all words in target and source texts before searching for matches |
| -stop <file> | filter all **stop**words in a specified file                               |

## TODO

- [ ] Convert `get_shared_word_clusters` and `highlight` functions to C extensions, using the document at https://github.com/ruby/ruby/blob/trunk/doc/extension.rdoc as a reference.
- [ ] Implement word comparison functions using the `damlev` function, enabling word matches by edit distance.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To manually install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/shushcat/rcopyfind.

## License

This project is loosely based on [WCopyfind](http://plagiarism.bloomfieldmedia.com/wordpress/software/wcopyfind/) by Lou Bloomfield.

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

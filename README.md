# Gabrake &mdash; Realtime Error Tracking with Google Analytics

[![Build Status](https://travis-ci.org/smolnar/gabrake.svg)](https://travis-ci.org/smolnar/gabrake)

Gabrake is a gem built on top of Google Analytics API and provides realtime server-side and client-side error tracking by using custom events. It uses a flexibility of Google Analytics API and handles server-side error server-side, without exposing any of your error messages or backtrace on client.

Let's have a look.

[Realtime Tracking by category](https://www.dropbox.com/s/k0bhpd1f90hhe6e/gabrake-realtime.png?dl=0)

[JavaScript Tracking by messages](https://www.dropbox.com/s/8pa1j5vujcma9oq/gabrake-js.png?dl=0)

[Overview by error message and location](https://www.dropbox.com/s/hrmyy9cgo1jkclw/gabrake-overview.png?dl=0)

[Overview by error message and browser](https://www.dropbox.com/s/q736nd92vzz5r4a/gabrake-overview-by-browser.png?dl=0)

Inspired by [garelic](https://github.com/jsuchal/garelic) &mdash; gem that tracks app performace by Google Analytics User Timing variables.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gabrake'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gabrake

## Usage

### 1. Set it up

Create an initializer `config/initializers/gabrake.rb` and add

```ruby
Gabrake.tracking_id = 'YOUR GA TRACKING ID'
```

In your javascript do

```coffeecript
#= require gabrake/analytics # if you haven't required analytics tracking code somewhere else
#= require gabrake
```

**Note**: *This library uses new analytics.js code &ndash; Universal Google Analytics. If you still have the old `_gaq` library and you use it (for tracking events and stuff), you have to [create a new property](http://stackoverflow.com/a/20690546/1691413) (get second tracking ID and use that one for Gabrake).*

### 2. Track errors

Go to Google Analytics page, hit **Real Time** > **Events** and track 'em.

**Pro Tip:** *Gabrake errors have two categories &ndash; Gabrake (Rails) and Gabrake (JavaScript). Click on one of the category to filter out events and see error message (action) along with error backtrace location (label).*

### 3. Analyze

Wait couple minutes.

1. Go to **Behaviour** > **Events** > **Overview**. 
2. Click on one of the Gabrake categories. On top of table, choose primary dimension as **Event Action**. 
3. Choose secondary dimension by your taste &mdash; *Event Label (backtrace location), Page, Browser.*

**Important**: *Make sure that the overview date includes TODAY! You'll save yourself a headache.*

## Advanced

### Tracking versions

If you want to compare errors by app versions, you need create a custom dimension. 

1. Go to **Admin** > Under **Property** tab (the big middle one) > hit **Custom Definitions** > **Custom Dimension** > create one.
2. Write down the name and the index. 
3. Set `Gabrake.custom_dimension_index = YOUR_INDEX`.
3. Go to **Behaviour** > **Events** > **Overview**. Click category. Choose **Event Action**. Search for secondary dimension, by the name. Choose it.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

### This code is free to use under the terms of the MIT license.

Copyright (c) 2015 Samuel Molnár

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

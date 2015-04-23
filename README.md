# Wrap templates in an AngularJS module for Brunch.IO<br/>[![Dependency Status](https://david-dm.org/kenhkan/angular-templates-brunch.png)](https://david-dm.org/kenhkan/angular-templates-brunch) [![Stories in Ready](https://badge.waffle.io/kenhkan/angular-templates-brunch.png)](http://waffle.io/kenhkan/angular-templates-brunch)

For each template, wrap around in a shared AngularJS module called
`appTemplates` by default with each template file's path as the template URL.
See [$templateCache](http://docs.angularjs.org/api/ng.$templateCache) for more
information.


## Installation

`npm install --save angular-templates-brunch`


## Usage

1. Set `joinTo` attribute for `templates` in `config.coffee`, e.g.

```coffee
templates:
  joinTo:
    'templates.js': /^app/
```

2. In your markup, include `templates.js`:

```coffee
<script type="text/javascript" src="/templates.js"></script>
```

3. Your app module must require an `appTemplates` module:

```coffee
angular.module('MyApp', [
  ...
  'appTemplates'
  ...
]);
```

4. Get a particular template by its path.

```coffee
$routeProvider.when('/home', { templateUrl: 'app/home/home.html' });
```

5. Run Brunch (e.g. `brunch build`)!


## Options

### module

Specify the module to place the templates in

Default: `appTemplates`

```coffee
plugins:
  ng_templates:
    module: 'MyModule'
```

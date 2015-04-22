path = require 'path'

module.exports = class NgTemplatesCompiler
  brunchPlugin: yes
  type: 'template'
  extension: 'js'
  # Add to this list of markup to wrap for AngularJS
  pattern: /\.(html|jade|eco|hbs|handlebars)$/

  constructor: (config) ->
    @module = config.plugins?.ng_templates?.module or 'appTemplates'
    @relativePath = config.plugins?.ng_templates?.relativePath
    @keepExt = config.plugins?.ng_templates?.keepExt ? true

  compile: (data, filepath, callback) ->
    console.log "compiling #{filepath}"

    if @relativePath
      filepath = path.relative(@relativePath, filepath);

    if not @keepExt
      filepath = filepath.replace /\.\w+$/, ''

    parseStringToJSArray = (str) ->
      stringArray = '['
      str.split('\n').map (e, i) ->
        stringArray += "\n'" + e.replace(/'/g, "\\'") + "',"
      stringArray += "''" + '].join("\\n")'

    callback null, """
      (function() {
        var module;

        try {
          // Get current templates module
          module = angular.module('#{@module}');
        } catch (error) {
          // Or create a new one
          module = angular.module('#{@module}', []);
        }

        module.run(['$templateCache', function($templateCache) {
          return $templateCache.put('#{filepath}', #{parseStringToJSArray(data)});
        }]);
      })();
    """

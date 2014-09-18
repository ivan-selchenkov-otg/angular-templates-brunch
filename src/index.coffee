module.exports = class NgTemplatesCompiler
  brunchPlugin: yes
  type: 'template'
  extension: 'js'
  # Add to this list of markup to wrap for AngularJS
  pattern: /\.(html|jade|eco|hbs|handlebars)$/

  constructor: (config) ->
    @module = config.plugins?.ng_templates?.module or 'appTemplates'
    @tplKey = config.plugins?.ng_templates?.tplKey
    @keepExt = config.plugins?.ng_templates?.keepExt ? true

  compile: (data, path, callback) ->
    if @tplKey
      path = @tplKey(path);

    if not @keepExt
      path = path.replace /\.\w+$/, ''

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

        module.run(function($templateCache) {
          // Force CommonJS to capture from preprocessors
          var define, module = { exports: true };

          // Include the data from preprocessor
          #{data}

          // Save the template content
          if (typeof module.exports === 'function') {
            $templateCache.put('#{path}', module.exports());
          } else {
            $templateCache.put('#{path}', module.exports);
          }
        });
      })();
    """

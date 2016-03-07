meshblu        = require 'meshblu'
debug          = require('debug')('meshblu-device-watcher:device-watcher')

class DeviceWatcher
  constructor: ({@meshbluConfig}) ->

  close: (callback) =>
    debug 'close'
    @meshblu?.close callback

  onConfig: (callback) =>
    debug 'connecting...'
    @meshblu = meshblu.createConnection @meshbluConfig

    @meshblu.on 'ready', =>
      debug 'connected'

      @meshblu.on 'config', (config) =>
        debug 'got config', config.uuid
        callback null, config

      @meshblu.on 'unregister', =>
        debug 'got unregister'
        callback null, null

    @meshblu.on 'notReady', (error) =>
      debug 'connection error', error
      callback error



module.exports = DeviceWatcher

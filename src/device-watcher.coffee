{EventEmitter} = require 'events'
meshblu        = require 'meshblu'
debug          = require('debug')('meshblu-device-watcher:device-watcher')

class DeviceWatcher extends EventEmitter
  constructor: ({@meshbluConfig}) ->

  close: (callback) =>
    debug 'close'
    @meshblu.close callback

  connect: (callback) =>
    debug 'connecting...'
    @meshblu = meshblu.createConnection @meshbluConfig

    @meshblu.on 'ready', =>
      debug 'connected'
      callback null

    @meshblu.on 'notReady', (error) =>
      debug 'connection error', error
      callback error

    @meshblu.on 'config', (data) =>
      debug 'config'
      @emit 'config', data

module.exports = DeviceWatcher

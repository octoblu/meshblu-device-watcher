MeshbluConfig = require 'meshblu-config'
MeshbluHttp   = require 'meshblu-http'
DeviceWatcher = require './'

class Tester
  run: =>
    meshbluConfig = new MeshbluConfig().toJSON()
    meshbluHttp   = new MeshbluHttp meshbluConfig
    watcher = new DeviceWatcher {meshbluConfig}
    setTimeout =>
      console.log 'updating device'
      meshbluHttp.update meshbluConfig.uuid, 'hello': true
    , 2000
    watcher.onConfig (error, config) =>
      return console.error error if error?
      console.log 'SUCCESS' if config.hello
      console.error 'Uh oh' unless config.hello
      process.exit 0

new Tester().run()

MeshbluConfig = require 'meshblu-config'
MeshbluHttp   = require 'meshblu-http'
DeviceWatcher = require './'

class Tester
  run: =>
    meshbluConfig = new MeshbluConfig().toJSON()
    meshbluHttp   = new MeshbluHttp meshbluConfig
    watcher = new DeviceWatcher {meshbluConfig}
    watcher.connect (error) =>
      return console.error error if error?
      meshbluHttp.update meshbluConfig.uuid, 'hello': true, =>
        watcher.on 'config', (device) =>
          return console.log 'SUCCESS' if device.hello
          console.error 'Uh oh' 

new Tester().run()

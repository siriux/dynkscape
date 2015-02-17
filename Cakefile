{spawn, exec} = require 'child_process'
fs = require 'fs'

task 'build', 'Build project from src/*.coffee to lib/build/*.js and main.js', ->
  coffee = spawn 'coffee', ['-cwb', '-o', 'lib/build', 'src/']
  catw = spawn 'catw', ['lib/**/*.js', '-o', 'main.js']

  dataPrint = (data) -> console.log data.toString()

  coffee.stderr.on 'data', dataPrint
  coffee.stdout.on 'data', dataPrint
  catw.stderr.on 'data', dataPrint
  catw.stdout.on 'data', dataPrint

task 'clean', 'Clean build', ->
  exec 'rm -r lib/build/* main.js', (err,stdout, stderr) ->
    console.log stdout


option '-i', '--input[FILE]', 'Svg input file'
option '-o', '--output[FILE]', 'Svg output file'
task 'embed', 'Embed the script into the svg file', (options) ->
  svgFile = fs.readFileSync(options.input).toString()
  jsFile = fs.readFileSync("main.js").toString()
  jsURL = "data:text/javascript;base64,#{new Buffer(jsFile).toString("base64")}"
  embedFile = svgFile.replace(/main\.js/, jsURL)
  fs.writeFileSync(options.output, embedFile)

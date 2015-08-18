path = require "path"

module.exports = {
    cache: false
    progress: true
    entry:
      app: "./src/client/index"
    output:
      publicPath: "webpack/"
      path: path.join __dirname, "./build/public/webpack/"
      filename: "[name].bundle.js"
      chunkFilename: "[chunkhash].chunk.js"
    plugins: []
    resolve:
      extensions: ['','.js','.cjsx','.coffee','.jsx']
    module:
      loaders: [
        { test: /\.cjsx/, loaders: ['coffee-loader', 'cjsx-loader'] }
        { test: /\.coffee/, loaders: ['coffee-loader'] }
        { test: /\.css$/, loader: 'style!css' }
        { test: /\.scss$/, loader: 'style!sass' }
        { test: /\.js/, loader: 'jsx-loader' }
        { test: /\.jsx/, loader: 'jsx-loader' }
      ]
}

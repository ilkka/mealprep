var webpack = require('webpack');
var HtmlWebpackPlugin = require('html-webpack-plugin');
var ExtractTextPlugin = require('extract-text-webpack-plugin');

var name = 'Cycle!';

var vendorModules = /(node_modules|bower_components)/;

module.exports = {
  target: "web",
  entry: {
    app: "./app/index.js",
    vendor: require("./app/vendor.js"),
  },

  output: {
    path: "./build",
    filename: "[name]-[chunkhash].js",
    pathinfo: true,
    publicPath: "",
  },

  module: {
    preLoaders: [
      {test: /\.jsx?$/, loader: "eslint-loader", exclude: vendorModules},
    ],
    loaders: [
      {
        test: /\.jsx?$/,
        exclude: vendorModules,
        loader: "babel",
        query: {
          env: {
            development: {
              plugins: [
                "typecheck",
              ],
            },
          },
          presets: ['es2015', 'stage-2'],
        },
      },
      {
        test: /\.css$/,
        loader: ExtractTextPlugin.extract('style-loader', 'css-loader?modules&importLoaders=1&localIdentName=[name]__[local]___[hash:base64:5]!postcss-loader'),
      },
    ],
  },

  plugins: [
    new webpack.optimize.CommonsChunkPlugin(
      'vendor', 'vendor-[chunkhash].js', Infinity
    ),
    new HtmlWebpackPlugin({
      title: name,
      minify: process.env.NODE_ENV === 'production' ? {
        removeComments: true,
        removeCommentsFromCDATA: true,
        collapseWhitespace: true,
        conservativeCollapse: false,
        collapseBooleanAttributes: true,
        removeAttributeQuotes: true,
        removeRedundantAttributes: true,
        preventAttributesEscaping: true,
        useShortDoctype: true,
        removeEmptyAttributes: true,
        removeScriptTypeAttributes: true,
        removeStyleLinkTypeAttributes: true,
      } : false,
      template: './app/index.html',
    }),
    new ExtractTextPlugin('style.css', {allChunks: true}),
  ],
};

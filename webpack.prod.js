const { merge } = require('webpack-merge')
const webpack = require('webpack')
const path = require("path");
const commonConfig = require('./webpack.common')
const dotenv = require('dotenv').config({ path: __dirname + '/.env.prod' })
const prodConfig = {
    mode: 'production',
    devtool: 'source-map',
    output: {
        publicPath: process.env.BASE_URL+'dfa_public/',
        filename: "dfa.main.js",
        path: path.resolve(__dirname, 'dfa_public'),
    },
    plugins: [
        new webpack.DefinePlugin({
            'process.env': JSON.stringify(dotenv.parsed),
            'process.env.NODE_ENV': JSON.stringify('production'),
        })
    ]
}
module.exports = merge(commonConfig, prodConfig)
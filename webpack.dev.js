const { merge } = require('webpack-merge')
const webpack = require('webpack')
const path = require("path");
const commonConfig = require('./webpack.common')
const dotenv = require('dotenv').config({ path: __dirname + '/.env' })
const devConfig = {
    mode: 'development',
    output: {
        publicPath: process.env.BASE_URL,
        filename: "dfa.main.js",
    },
    plugins: [
        new webpack.DefinePlugin({
            'process.env': JSON.stringify(dotenv.parsed),
            'process.env.NODE_ENV': JSON.stringify('development'),
        })
    ]
}
module.exports = merge(commonConfig, devConfig)
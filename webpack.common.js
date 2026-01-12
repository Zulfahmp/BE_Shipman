const webpack = require('webpack')
const HtmlWebpackPlugin = require("html-webpack-plugin");
const ModuleFederationPlugin = require("webpack/lib/container/ModuleFederationPlugin");
const port = 1910; // KETIKA DEPLOY HARUS MENGGUNAKAN PORT 8080 (SECURITY ISSUE)
const path = require("path");
const deps = require('./package.json').dependencies;
module.exports = {
	// entry :'./src/index.js',
	devServer: {
		port: port,
		historyApiFallback: true,
	},
	performance: {
		hints: false,
		maxEntrypointSize: 512000,
		maxAssetSize: 512000
	},
	experiments:{
		topLevelAwait:true
	},
	optimization:{
		runtimeChunk:false,
		splitChunks:false
	},
	resolve: {
		alias: {
			"@app": path.resolve(__dirname, "app"),
			"@api": path.resolve(__dirname, "src/api"),
			"@components": path.resolve(__dirname, "src/components"),
		},
		extensions: [".tsx", ".ts", ".jsx", ".js", ".json"],
	},
	module: {
		rules: [
			{ test: /\.m?js/,type: "javascript/auto",resolve: {fullySpecified: false}},
			{ test: /\.m?js$/,exclude: /node_modules/,use: {loader: "babel-loader",options: {presets: ["@babel/preset-react", "@babel/preset-env"],plugins: ["@babel/plugin-transform-runtime"],}}},
			{ test: /\.jsx?$/,include: /node_modules/,enforce: "pre",use: ["source-map-loader"],},
			{ test: /\.css$/i, include: path.resolve(__dirname, "src"), use: ["style-loader", "css-loader", "postcss-loader"] },
			{ test: /\.css$/i, include: path.resolve(__dirname, "node_modules"), use: ["style-loader", "css-loader", "postcss-loader"] },
			{ test: /\.(png|jpg|jpeg|svg|gif|ico|webp)$/i, use: [{loader: "url-loader",options: {limit: 8192,},},],},
			{ test: /\.(pdf|doc|docx|xls|xlsx)$/i,use: [{loader: "file-loader",options: {limit: 8192,},},],},
		],
	},
	plugins: [
		new webpack.ProvidePlugin({
			"React": "react",
		 }),
		new HtmlWebpackPlugin({
			template: "./public/index.html"
		}),
		
	]
}

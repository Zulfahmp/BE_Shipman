const path = require('path');

module.exports = {
  entry: './src/index.js',  // Your entry point file
  output: {
    filename: 'bundle.js',  // The name of the output bundle
    path: path.resolve(__dirname, 'dist'),  // Output directory
  },
  mode: 'development',  // Set the mode to 'production' for production builds
};

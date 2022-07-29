const path = require('path');

const { ESBuildMinifyPlugin } = require('esbuild-loader');
const { VueLoaderPlugin } = require('vue-loader');
const WebpackObfuscator = require('webpack-obfuscator');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
    mode: 'production',
    entry: {
        nui: path.resolve(__dirname, 'nui/index.ts')
    },
    module: {
        rules: [
            {
                test: /\.tsx?$/,
                loader: 'esbuild-loader',
                options: {
                    loader: 'ts',
                    minify: true,
                    target: 'es2015'
                }
            },
            {
                test: /\.vue$/,
                loader: 'vue-loader'
            },
            {
                test: /\.html$/,
                exclude: /node_modules/,
                use: 'html-loader',
            },
            {
                test: /\.(png|jpe?g|gif|ogg)$/i,
                use: ['file-loader'],
            },
            {
                test: /\.(sa|sc|c)ss$/,
                use: ['style-loader', 'css-loader', 'sass-loader']
            }
        ]
    },
    plugins: [
        new VueLoaderPlugin(),
        new HtmlWebpackPlugin({
            template: 'nui/index.html',
            chunks: ['nui'],
            minify: {
                removeComments: true,
                collapseWhitespace: true,
                useShortDoctype: true,
                keepClosingSlash: true
            }
        }),
        new WebpackObfuscator({
            rotateStringArray: true
        }, ['[name].js'])
    ],
    optimization: {
        minimizer: [
            new ESBuildMinifyPlugin({
                target: 'es2015'
            })
        ]
    },
    resolve: {
        extensions: ['.ts', '.js', '.vue', '.json'],
        modules: ['node_modules']
    },
    output: {
        path: path.resolve(__dirname, 'dist'),
        filename: '[name].js'
    }
};

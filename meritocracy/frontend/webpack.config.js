{
    "mode": "development",
    "entry": "src/main.js",
    "output": {
        "path": __dirname+'/dist',
        "filename": "[name].[chunkhash:8].js"
    },
    "module": {
       "rules": [
            {
                "test": /\.vue$/,
                "exclude": /node_modules/,
                "use": "vue-loader"
            },
            {
                "test": /\.css$/,
                "use": [
                    "style-loader",
                    "css-loader"
                ]
            }
        ]
    }
}

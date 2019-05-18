module.exports = {
  lintOnSave: false,
  devServer: {
    clientLogLevel: 'info',
    public: "127.0.0.1:80",
    disableHostCheck: true,
    port: 80,
    proxy: {
      "/api": {
        target: "http://postgrest:3000",
        pathRewrite: {
          "^/api": ""
        },
        secure: false
      }
    }
  }
};

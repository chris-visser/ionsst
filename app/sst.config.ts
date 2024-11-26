/// <reference path="./.sst/platform/config.d.ts" />

export default $config({
  app(input) {
    return {
      name: "ionsst",
      removal: input?.stage === "production" ? "retain" : "remove",
      home: "aws",
    };
  },
  async run() {
    const TestFunction = new sst.aws.Function("ssr", {
      handler: "index.main",
      url: true,
    });

    new sst.aws.Router("router", {
      routes: {
        "/*": TestFunction.url,
      },
    });
  },
});

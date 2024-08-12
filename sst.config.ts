/// <reference path="./.sst/platform/config.d.ts" />

export default $config({
  app() {
    return {
      home: 'aws',
      name: 'bc-fe-sst-poc',
      removal: 'retain',
    }
  },
  async run() {
    const TestFunction = new sst.aws.Function('TestFunction', {
      handler: 'index.handler',
      role: 'arn:aws:iam::174382187256:role/bc-euc1-dev-aws-lambda-python-template',
      url: true,
    })

    new sst.aws.Router('PocRouter', {
      routes: {
        '/': TestFunction.url,
      },
    })
  },
})

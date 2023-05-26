import { createProxyMiddleware, fixRequestBody } from 'http-proxy-middleware';

const { proxyTarget } = useRuntimeConfig();

const proxyMiddleware = createProxyMiddleware({
  target: proxyTarget,
  changeOrigin: true,
  ws: true,
  pathRewrite: {
    '^/api': '/',
  },
  pathFilter: ['/api/**'],
  on: {
    proxyReq: fixRequestBody,
  },
  logger: console,
});

export default fromNodeMiddleware((req, res, next) => {
  proxyMiddleware(req, res, next);
});

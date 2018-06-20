module.exports = {
  extends: ["eslint:recommended", "prettier"],
  plugins: ["promise"],
  rules: {
    "no-console": 0
  },
  env: {
    browser: true,
    node: true,
    es6: true
  },
  parserOptions: {
    sourceType: "module",
    ecmaVersion: 2018
  }
};

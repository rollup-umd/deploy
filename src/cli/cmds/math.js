const debug = require('debug')('math');
exports.builder = (yargs) => yargs
  .option('sign', {
    describe: 'Choose a math sign',
    default: '+',
    choices: ['+', '-'],
  });
exports.command = 'math <a> <b>';
exports.desc = 'Discover rollup-umd CLI declination by doing math!';
exports.handler = (argv) => {
  const { a, b } = argv;
  let res;
  // eslint-disable-next-line default-case
  switch (argv.sign) {
    case '+':
      res = a + b;
      break;
    case '-':
      res = a - b;
      break;
  }
  debug(res);
  return res;
};

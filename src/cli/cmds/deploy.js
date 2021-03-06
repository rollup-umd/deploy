const deploy = require('../..');

exports.command = ['*', 'deploy'];
exports.desc = 'run deploy job';
exports.builder = (yargs) => yargs
  .option('yarn', {
    type: 'boolean',
    alias: 'y',
    describe: 'Use yarn instead of npm',
  })
  .option('target-version', {
    type: 'text',
    alias: 't',
    describe: 'Target version',
  });

exports.handler = (args) => {
  deploy(args, (err, code) => {
    if (code !== 0) {
      console.log(`ps process exited with code ${code}`); // eslint-disable-line no-console
      process.exitCode = code;
    }
  });
};

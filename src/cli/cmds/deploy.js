const deploy = require('../..');

exports.command = ['*', 'deploy'];
exports.desc = 'run deploy job';
exports.handler = () => {
  deploy((err, code) => {
    if (code !== 0) {
      console.log(`ps process exited with code ${code}`); // eslint-disable-line no-console
      process.exitCode = code;
    }
  });
};

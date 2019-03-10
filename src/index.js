const path = require('path');
const { spawn } = require('child_process');

module.exports = (cb) => {
  const ls = spawn('bash', [path.join(__dirname, 'deploy.sh')], { stdio: 'inherit' });
  ls.on('close', (code) => {
    if (cb) {
      cb(null, code);
    }
  });
};

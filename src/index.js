const path = require('path');
const { spawn } = require('child_process');

module.exports = ({ yarn, version }, cb) => {
  const args = [];
  if (yarn) {
    args.push('--yarn');
  }
  if (version)  {
    args.push(`--version ${version}`);
  }
  const ls = spawn('bash', [path.join(__dirname, 'deploy.sh')].concat(args), { stdio: 'inherit' });
  ls.on('close', (code) => {
    if (cb) {
      cb(null, code);
    }
  });
};

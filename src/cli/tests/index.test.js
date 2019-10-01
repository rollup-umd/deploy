import path from 'path';
import execa from 'execa';

describe('CLI', () => {
  it('CLI should show help', async () => {
    const { stdout: help } = await execa(`node_modules/.bin/babel-node ${path.join(__dirname, '../index')} --help`, { shell: true });
    expect(help).toContain('--version');
  });
});

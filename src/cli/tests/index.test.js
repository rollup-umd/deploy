import path from 'path';
import execa from 'execa';

describe('CLI', () => {
  it('CLI should show help', async () => {
    const { stdout: help } = await execa.shell(`node_modules/.bin/babel-node ${path.join(__dirname, '../index')} --help`);
    expect(help).toContain('--version');
  });
});

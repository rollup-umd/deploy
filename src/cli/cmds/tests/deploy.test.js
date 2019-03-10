import {
  builder,
  command,
  desc,
  handler,
} from '../deploy';

describe('deploy', () => {
  it('builder should be defined', () => {
    expect(builder).toBeDefined();
  });
  it('command should be defined', () => {
    expect(command).toBeDefined();
  });
  it('desc should be defined', () => {
    expect(desc).toBeDefined();
  });
  it('handler should be defined', () => {
    expect(handler).toBeDefined();
  });
});

import {
  builder,
  command,
  desc,
  handler,
} from '../math';

describe('math example', () => {
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
  it('builder should be called with', () => {
    const yargs = {
      option: jest.fn(),
    };
    builder(yargs);
    expect(yargs.option).toHaveBeenCalledWith('sign', {
      choices: ['+', '-'],
      default: '+',
      describe: 'Choose a math sign',
    });
  });
  it('3 + 5 should be 8', () => {
    expect(handler({ sign: '+', a: 3, b: 5 })).toEqual(8);
  });
  it('3 - 5 should be -2', () => {
    expect(handler({ sign: '-', a: 3, b: 5 })).toEqual(-2);
  });
});

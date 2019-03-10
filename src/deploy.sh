#!/usr/bin/env bash
set -e

DECLINATION_ID=$(node -p "require('./package.json').declinationId")

if [[ $VERSION ]]; then
  git fetch --tags
  git checkout refs/tags/${VERSION}
fi

if [[ ! -e $PWD/node_modules  ]]; then
  echo "[Documentation] installing dependencies"
  npm install
fi
if [[ "$DECLINATION_ID" = cli  ]]; then
  echo "[Documentation] generating CLI documentation"
  npx @yeutech-lab/rollup-umd-documentation-cli
fi
if [[ -e $PWD/styleguide/jsdoc.sh ]]; then
  echo "[Documentation] running jsdoc"
  chmod +x $PWD/styleguide/jsdoc.sh
  $PWD/styleguide/jsdoc.sh
fi
if [[ -e $PWD/styleguide/prepare.sh ]]; then
  echo "[Documentation] running prepare"
  chmod +x $PWD/styleguide/prepare.sh
  $PWD/styleguide/prepare.sh
fi
if [[ ! -e $PWD/public ]]; then
  echo "[Documentation] build documentation"
  npm run styleguide:build
fi

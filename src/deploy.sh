#!/usr/bin/env bash
set -e
[ -v DEBUG ] && set -x

DECLINATION_ID=$(node -p "require('./package.json').declinationId")

function die() {
 echo $1
 exit 1;
}

# Initialize all the option variables.
# This ensures we are not contaminated by variables from the environment.
installer=npm
targetVersion=

while :; do
  case $1 in
    -y|--yarn)
      installer=yarn
      ;;
    -t|--target-version)       # Takes an option argument; ensure it has been specified.
      if [ "$2" ]; then
        targetVersion=$2
        shift
      else
        die 'ERROR: "--target-version" requires a non-empty option argument.'
      fi
      ;;
    --target-version=?*)
      targetVersion=${1#*=} # Delete everything up to "=" and assign the remainder.
      ;;
    --target-version=)         # Handle the case of an empty --target-version=
      die 'ERROR: "--target-version" requires a non-empty option argument.'
      ;;
    --)              # End of all options.
      shift
      break
      ;;
    -?*)
      printf 'WARN: Unknown option (ignored): %s\n' "$1" >&2
      ;;
    *)               # Default case: No more options, so break out of the loop.
      break
  esac

  shift
done

if [[ ! -z ${targetVersion} ]]; then
  git fetch --tags
  git checkout refs/tags/${targetVersion}
  echo "[Documentation] target version ${targetVersion}"
fi

if [[ ! -d $PWD/node_modules ]]; then
  echo "[Documentation] installing dependencies with ${installer}"
  if [[ ${installer} = yarn ]]; then
    [[ $(which yarn) = "" ]] && curl -o- -L https://yarnpkg.com/install.sh | bash
    yarn
  else
    npm install
  fi
else
  echo "Skipping ${installer} install"
fi

if [[ "$DECLINATION_ID" = cli  ]]; then
  echo "[Documentation] generating CLI documentation"
  if [[ ${NO_NPX} = true ]]; then
    npm install -g @yeutech-lab/rollup-umd-documentation-cli
    rollup-umd-documentation-cli
    npm uninstall -g @yeutech-lab/rollup-umd-documentation-cli
  else
    npx @yeutech-lab/rollup-umd-documentation-cli
  fi
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

# remove prerequesite section if no peer dependencies are found
if [[ $(cat package.json | jq '.peerDependencies | length') = 0 ]]; then
  # look for prerequisite file path
  prerequesiteFile=$(jq '.sections |= map(select(.name == "Prerequisite")) | .sections[0].content' styleguide/styleguide.ext.json)
  if [[ "$prerequesiteFile" != "null" ]]; then
    # remove prerequesite if found and $PACKAGE_PEERS is present in file
    if [[ -f "$prerequesiteFile" ]] && [[ $(grep "\$PACKAGE_PEERS" "$prerequesiteFile") ]]; then
      echo "Remove page prerequesite as no peer dependencies were found"
      jq '.sections |= map(select(.name != "Prerequisite"))' styleguide/styleguide.ext.json > styleguide/styleguide.ext.json.tmp$$
      mv styleguide/styleguide.ext.json.tmp$$ styleguide/styleguide.ext.json
    fi
  fi
fi

if [[ ! -e $PWD/public ]]; then
  echo "[Documentation] build documentation"
  npm run styleguide:build
fi

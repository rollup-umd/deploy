You can pass the version you want to deploy to the script:

```bash
$ npx $PACKAGE_NAME --target-version ${releaseVersion}
```

You can tell the script to use `yarn` for installation:

```bash
$ npx $PACKAGE_NAME --yarn
```

Set `DEBUG` environment variable to enable debug output.
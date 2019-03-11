@yeutech/rollup-umd-ci-deploy contain the job deploy stage for all rollup-umd project.

You can run the deploy stage by doing:

```bash
$ npx $PACKAGE_NAME
```

It should be installed as a `devDependencies` so we can follow the version used by the rollup-umd project.

It is also automatically removed if the package goes public.

To use it, just use the script within your `.gitlab-ci.yml`:


```yml
# Pages
pages:
  stage: deploy
  script:
    - npx $PACKAGE_NAME
  artifacts:
    paths:
    - public
  only:
    - tags
  tags:
    - docker
```

If it exist, it will call `styleguide/prepare.sh` within your project to do build operation of your documentation.

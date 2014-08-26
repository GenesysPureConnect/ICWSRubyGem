# Releasing ICWS

There're no particular rules about when to release ICWS. Release bug fixes frequenty, features not so frequently and breaking API changes rarely.

### Release

Run tests, check that all tests succeed locally.

```
bundle install
rake test
```

Check that the last build succeeded in [Travis CI](https://travis-ci.org/tim-vandecasteele/grape-swagger) for all supported platforms.

Increment the version, modify [icws.gemspec](icws.gemspec).

*  Increment the third number if the release has bug fixes and/or very minor features, only (eg. change `0.7.1` to `0.7.2`).
*  Increment the second number if the release contains major features or breaking API changes (eg. change `0.7.1` to `0.8.0`).

Change "Next Release" in [CHANGELOG.md](CHANGELOG.md) to the new version.

```
### 0.7.2 (February 6, 2014)
```

Commit your changes.

Release.

```
$ rake release
```

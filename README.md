# Spec

Spec is a framework in Pharo for describing user interfaces.

[![Build Status](https://travis-ci.com/pharo-spec/Spec.svg?branch=master)](https://travis-ci.com/pharo-spec/Spec)

## Install Spec

It is possible to load the latest version of Spec in Pharo 9 with following script:

Please note: although it is also possible to load latest version of
Spec into Pharo 8, such combination will not work well and you will
probably hit various strange looking issues. How long it'll take to
hit those depends on the complexity of your code. As a result any
usage of this code in Pharo 8 is highly discouraged.

```Smalltalk
    Metacello new
        githubUser: 'pharo-spec' project: 'Spec' commitish: 'master' path: 'src';
        baseline: 'Spec2';
        onConflict: [ :e | e useIncoming ];
        onUpgrade: [ :e | e useIncoming ];
        ignoreImage;
        load
```

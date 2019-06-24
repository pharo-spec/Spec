# Spec

Spec is a framework in Pharo for describing user interfaces.

[![Build Status](https://travis-ci.org/pharo-spec/Spec.svg?branch=master)](https://travis-ci.org/pharo-spec/Spec)

## Install Spec

It is possible to load the latest version of Spec in Pharo 7 with this script:

```Smalltalk
    Metacello new
        githubUser: 'pharo-spec' project: 'Spec' commitish: 'master' path: 'src';
        baseline: 'Spec2';
        onConflict: [ :e | e useIncoming ];
        onUpgrade: [ :e | e useIncoming ];
        ignoreImage;
        load
```
# Spec

Spec is a framework in Pharo for describing user interfaces.

[![Spec-Pharo-Integration](https://github.com/pharo-spec/Spec/actions/workflows/spec-all.yml/badge.svg)](https://github.com/pharo-spec/Spec/actions/workflows/spec-all.yml)  
[![Spec-dev](https://github.com/pharo-spec/Spec/actions/workflows/spec.yml/badge.svg)](https://github.com/pharo-spec/Spec/actions/workflows/spec.yml)


## Install Spec

It is possible to load the latest version of Spec in Pharo 9 or Pharo 10 with following script:


```Smalltalk
    Metacello new
        repository: 'github://pharo-spec/Spec:Pharo10';
        baseline: 'Spec2';
        onConflict: [ :e | e useIncoming ];
        onUpgrade: [ :e | e useIncoming ];
        ignoreImage;
        load
```

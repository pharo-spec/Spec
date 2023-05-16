# Spec

Spec is a framework in Pharo for describing user interfaces.

[![Spec-Pharo-Integration](https://github.com/pharo-spec/Spec/actions/workflows/spec-all.yml/badge.svg)](https://github.com/pharo-spec/Spec/actions/workflows/spec-all.yml)  
[![Spec-dev](https://github.com/pharo-spec/Spec/actions/workflows/spec.yml/badge.svg)](https://github.com/pharo-spec/Spec/actions/workflows/spec.yml)


## Install Spec

Spec is included in any regular Pharo image.  
It is possible to load the latest version executing following script:


```Smalltalk
    Metacello new
        repository: 'github://pharo-spec/Spec';
        baseline: 'Spec2';
        onConflict: [ :e | e useIncoming ];
        onUpgrade: [ :e | e useIncoming ];
        ignoreImage;
        load
```

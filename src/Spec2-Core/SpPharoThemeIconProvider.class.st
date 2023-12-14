"
I'm a provider that redirects to the default Pharo icon provider.
"
Class {
	#name : 'SpPharoThemeIconProvider',
	#superclass : 'SpIconProvider',
	#category : 'Spec2-Core-IconProvider',
	#package : 'Spec2-Core',
	#tag : 'IconProvider'
}

{ #category : 'accessing' }
SpPharoThemeIconProvider >> iconNamed: aName [ 

	^ self 
		iconNamed: aName 
		ifAbsent: [ self noIcon ]
]

{ #category : 'accessing' }
SpPharoThemeIconProvider >> iconNamed: aName ifAbsent: aBlock [

	aName ifNil: [ ^ aBlock value ].

	^ ThemeIcons current 
		iconNamed: aName 
		ifNone: aBlock
]

{ #category : 'accessing' }
SpPharoThemeIconProvider >> noIcon [

	^ ThemeIcons current blankIcon
]

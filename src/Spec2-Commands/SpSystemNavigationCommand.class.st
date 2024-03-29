"
My subclasses implement commands related to system navigation.
I give a selector from a context that must:
- be a block
- evaluate to a string or symbol
"
Class {
	#name : 'SpSystemNavigationCommand',
	#superclass : 'SpToolCommand',
	#category : 'Spec2-Commands-Navigation',
	#package : 'Spec2-Commands',
	#tag : 'Navigation'
}

{ #category : 'default' }
SpSystemNavigationCommand class >> defaultIconName [
	^#smallSystemBrowser 
]

{ #category : 'default' }
SpSystemNavigationCommand class >> defaultName [
	^'Browse ', self shortName 
]

{ #category : 'documentation' }
SpSystemNavigationCommand class >> documentContextRequiredSelectors [
	"Using a String and not a Symbol because `RBBrowserEnvironmentTest>>#testMatches` fails 
	 if answering a symbol (because it detects the referenced selector)"

	^ #('environment')
]

{ #category : 'default' }
SpSystemNavigationCommand class >> shortName [
	^self subclassResponsibility 
]

{ #category : 'accessing' }
SpSystemNavigationCommand >> environment [

	^ self context environment
]

{ #category : 'accessing' }
SpSystemNavigationCommand >> selector [

	^ self target trimBoth asSymbol
]

{ #category : 'accessing' }
SpSystemNavigationCommand >> systemNavigation [

	^ self context systemNavigation
		environment: self environment;
		yourself
]

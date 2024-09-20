Class {
	#name : 'SpSearchInputFieldOptionsPresenterTest',
	#superclass : 'SpBasePresenterTest',
	#category : 'Spec2-Tests-Common-Widgets',
	#package : 'Spec2-Tests',
	#tag : 'Common-Widgets'
}

{ #category : 'accessing' }
SpSearchInputFieldOptionsPresenterTest >> classToTest [
	
	^ SpSearchInputFieldOptionsPresenter
]

{ #category : 'tests' }
SpSearchInputFieldOptionsPresenterTest >> testSelectBlockExactCaseInsensitive [

	presenter exactOptionButton click.
	self 
		assert: (presenter selectBlock value: 'ABC' value: 'abc')
		description: 'It checks that exact and case-insensitive returns true for same letters with different case'
]

{ #category : 'tests' }
SpSearchInputFieldOptionsPresenterTest >> testSelectBlockExactCaseSensitive [

	presenter exactOptionButton click.
	presenter caseCheckBox click.
	self 
		deny: (presenter selectBlock value: 'ABC' value: 'abc')
		description: 'It checks that exact and case-insensitive returns false for same letters with different case'.
		
	self 
		assert: (presenter selectBlock value: 'ABC' value: 'ABC')
		description: 'It checks that exact and case-insensitive returns false for same letters with equal case'.
]

{ #category : 'tests' }
SpSearchInputFieldOptionsPresenterTest >> testSelectBlockRegexCaseInsensitive [

	presenter regexpOptionButton click.
		
	self 
		assert: (presenter selectBlock value: 'ABC' value: 'ABC')
		description: 'It checks that exact and case-insensitive returns false for same letters with equal case'.
		
	self 
		assert: (presenter selectBlock value: 'AbCD' value: '^AB(.*)$')
		description: 'It checks that exact and case-insensitive returns false for same letters with equal case'.
]

{ #category : 'tests' }
SpSearchInputFieldOptionsPresenterTest >> testSelectBlockRegexCaseSensitive [

	presenter regexpOptionButton click.
	presenter caseCheckBox click.

	self 
		deny: (presenter selectBlock value: 'AbCD' value: '^AB(.*)$')
		description: 'It checks that regular expression and case-insensitive returns false for same letters with different case'.
		
	self 
		assert: (presenter selectBlock value: 'ABC' value: '^AB(.*)$')
		description: 'It checks that regular expression and case-insensitive returns true for matching pattern with equal case'.
]

{ #category : 'tests' }
SpSearchInputFieldOptionsPresenterTest >> testSelectBlockSubstringCaseInsensitive [

	presenter substringBox click.

	self 
		deny: (presenter selectBlock value: 'AbCDef' value: 'pspsp')
		description: 'It checks that substring and case-insensitive returns false for different substring'.
		
	self 
		assert: (presenter selectBlock value: 'ABCdef' value: 'cde')
		description: 'It checks that substring and case-insensitive returns true for existing substring pattern'.
]

{ #category : 'tests' }
SpSearchInputFieldOptionsPresenterTest >> testSelectBlockSubstringCaseSensitive [

	presenter substringBox click.
	presenter caseCheckBox click.

	self 
		deny: (presenter selectBlock value: 'AbCDef' value: 'cdE')
		description: 'It checks that substring and case-sensitive returns false for same substring with different case'.
		
	self 
		assert: (presenter selectBlock value: 'ABCdef' value: 'Cde')
		description: 'It checks that substring and case-sensitive returns true for existing substring pattern with same case'.
]

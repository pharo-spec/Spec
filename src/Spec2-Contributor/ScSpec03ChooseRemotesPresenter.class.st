Class {
	#name : 'ScSpec03ChooseRemotesPresenter',
	#superclass : 'ScPagePresenter',
	#instVars : [
		'helpText'
	],
	#category : 'Spec2-Contributor',
	#package : 'Spec2-Contributor'
}

{ #category : 'as yet unclassified' }
ScSpec03ChooseRemotesPresenter class >> helpText [

	^ 'Choosing main (base) repository and your working repository. 
You will need two repositories: 
1. the pharo-spec repository, where you will submit your PR.
2. your working repository: your github fork, where you will create a branch to commit your changes, before submiting a PR.'

]

{ #category : 'initialization' }
ScSpec03ChooseRemotesPresenter >> initializePresenters [

	self layout: (SpBoxLayout newTopToBottom
		add: (helpText := self newText);
	"	add: (SpGridLayout new
			beColumnNotHomogeneous;
			column: 1 withConstraints: [ :c | c hAlignEnd ];
			add: 'Main (base) Repository' at: 1@1; add: (self newDropList) at: 2@1;
			add: 'Working Repository' at: 1@2; add: (self newDropList) at: 2@2;
			yourself);"
		yourself).
		
	helpText 
		beNotEditable;
		text: self class helpText
]

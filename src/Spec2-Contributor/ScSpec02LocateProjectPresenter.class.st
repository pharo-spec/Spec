Class {
	#name : #ScSpec02LocateProjectPresenter,
	#superclass : #ScPagePresenter,
	#instVars : [
		'helpText'
	],
	#category : #'Spec2-Contributor'
}

{ #category : #'as yet unclassified' }
ScSpec02LocateProjectPresenter class >> helpText [

	^ 'Your pharo-spec project is not pointing to an existing repository.
Before proceeding, you need "repair" this project by locating its local repository (or cloning it).'

]

{ #category : #initialization }
ScSpec02LocateProjectPresenter >> initializePresenters [

	self layout: (SpBoxLayout newTopToBottom
		add: (helpText := self newText) expand: false;
		add: (self instantiate: (ScSpecRepairRepositoryPresenter onRepository: self repository))
		yourself).

	helpText 
		beNotEditable;
		propagateNaturalHeight: true;
		text: self class helpText
]

{ #category : #testing }
ScSpec02LocateProjectPresenter >> isVisible [

	^ self repository isMissing
]

{ #category : #accessing }
ScSpec02LocateProjectPresenter >> repository [

	^ IceRepository registry 
		detect: [ :each | each name = self repositoryName ]
]

{ #category : #accessing }
ScSpec02LocateProjectPresenter >> repositoryName [

	^ 'pharo-spec2'
]

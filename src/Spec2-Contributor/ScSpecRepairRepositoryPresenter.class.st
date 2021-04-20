Class {
	#name : #ScSpecRepairRepositoryPresenter,
	#superclass : #IceTipRepairRepositoryDialog,
	#instVars : [
		'helpText'
	],
	#category : #'Spec2-Contributor'
}

{ #category : #specs }
ScSpecRepairRepositoryPresenter class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: #optionsList;
		add: #detailPanel;
		yourself
]

{ #category : #actions }
ScSpecRepairRepositoryPresenter >> accept [
	
	selectedOption executeWith: self model.
	self halt.
	
]

{ #category : #initialization }
ScSpecRepairRepositoryPresenter >> initializePresenters [

	super initializePresenters.
	self layout: (SpBoxLayout newTopToBottom
		add: self class defaultSpec;
		add: (SpBoxLayout newLeftToRight
			hAlignCenter;
			add: (self newButton 
						label: 'Repair';
						action: [ self accept ];
						yourself)
					expand: false;
				yourself)
			expand: false;
		yourself)
]

{ #category : #initialization }
ScSpecRepairRepositoryPresenter >> refreshDialogButtons [

]

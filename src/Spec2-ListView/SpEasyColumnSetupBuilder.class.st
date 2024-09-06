"
Used to create the setup presenter for an ""easy"" column.
"
Class {
	#name : 'SpEasyColumnSetupBuilder',
	#superclass : 'SpEasyColumnVisitor',
	#category : 'Spec2-ListView',
	#package : 'Spec2-ListView'
}

{ #category : 'visiting' }
SpEasyColumnSetupBuilder >> visitCheckboxColumn: aColumn [

	^ self presenter newSwitch
]

{ #category : 'visiting' }
SpEasyColumnSetupBuilder >> visitCompositeColumn: aColumn [
	| compositePresenter layout lastColumn |
	
	compositePresenter := self presenter newPresenter.
	compositePresenter addStyle: 'easy_composite_cell'.
	layout :=  SpBoxLayout newLeftToRight.
	
	lastColumn := aColumn columns last.
	aColumn columns do: [ :each | 
		layout 
			add: (each acceptColumnVisitor: self)
			withConstraints: [ :c | 
				each hasFixedWidth 
					ifTrue: [ c width: each width ]
					ifFalse: [ c expand: (each isExpandable "or: [ each = lastColumn ]") ] ] ].
		
	compositePresenter layout: layout.
	^ compositePresenter 
]

{ #category : 'visiting' }
SpEasyColumnSetupBuilder >> visitImageColumn: aColumn [

	^ self presenter newImage
]

{ #category : 'visiting' }
SpEasyColumnSetupBuilder >> visitLinkColumn: aColumn [

	^ self presenter newLink
]

{ #category : 'visiting' }
SpEasyColumnSetupBuilder >> visitStringColumn: aColumn [

	^ self presenter newLabel
]

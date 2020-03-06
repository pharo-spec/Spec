Extension { #name : #SpTabManagerPresenter }

{ #category : #'*Spec2-Deprecated' }
SpTabManagerPresenter class >> adapterName [

	^ #TabManagerAdapter
]

{ #category : #'*Spec2-Deprecated' }
SpTabManagerPresenter >> addDependent: aMorph [

	self myDependents add: aMorph
]

{ #category : #'*Spec2-Deprecated' }
SpTabManagerPresenter >> addTab: aTab [

	"BEWARE: this code is an exception. One should never access directly a value holder contents"
	"I do this here for optimisation. No need to trigger the whole collection changed. Only the added element is interesting "
	tabs value add: aTab.
	aTab owner: self.
	self selectedTab ifNil: [ selectedTab value: aTab ].
	self changed: #addTab: with: { aTab }
]

{ #category : #'*Spec2-Deprecated' }
SpTabManagerPresenter >> basicRemoveTab: aTab [
	"BEWARE: this code is an exception. One should never access directly a value holder contents"

	"I do this here for optimisation. No need to trigger the whole collection changed. Only the added element is interesting "

	"This method simply removes the tab from the collection without triggering further updates. It is useful for Adapters if there are different mechanisms of tab removal."

	(tabs value remove: aTab ifAbsent: [ ^ self ]) owner: nil
]

{ #category : #'*Spec2-Deprecated' }
SpTabManagerPresenter >> initialize [
	"Initialization code for TabManagerPresenter"

	super initialize.
	tabs := OrderedCollection new asValueHolder.
	tabSelectedAction := [  ] asValueHolder.
	selectedTab := nil asValueHolder.
	self myDependents: WeakSet new.

	tabs whenChangedDo: [ :new | self widget ifNotNil: [ :w | w tabs: self getTabs value ] ].
	selectedTab whenChangedDo: [ :newTab | tabSelectedAction value cull: newTab cull: self ]
]

{ #category : #'*Spec2-Deprecated' }
SpTabManagerPresenter class >> isDeprecated [
	^ true
]

{ #category : #'*Spec2-Deprecated' }
SpTabManagerPresenter >> removeTab: aTab [
	self basicRemoveTab: aTab.
	self changed: #removeTab: with: {aTab}
]

{ #category : #'*Spec2-Deprecated' }
SpTabManagerPresenter >> removeTabNumber: anIndex [

	self removeTab: (tabs at: anIndex)
]

{ #category : #'*Spec2-Deprecated' }
SpTabManagerPresenter >> selectTabModel: tabModel [

	tabSelectedAction value cull: tabModel cull: self
]

{ #category : #'*Spec2-Deprecated' }
SpTabManagerPresenter >> selectedTab [

	^ selectedTab value
]

{ #category : #'*Spec2-Deprecated' }
SpTabManagerPresenter >> selectedTab: aTab [

	selectedTab value: aTab
]

{ #category : #'*Spec2-Deprecated' }
SpTabManagerPresenter >> tabSelectedAction [

	^ tabSelectedAction value
]

{ #category : #'*Spec2-Deprecated' }
SpTabManagerPresenter >> tabs [

	^ tabs value
]

{ #category : #'*Spec2-Deprecated' }
SpTabManagerPresenter >> tabs: aCollection [

	tabs value: aCollection
]

{ #category : #'*Spec2-Deprecated' }
SpTabManagerPresenter >> whenTabSelected: aBlock [

	tabSelectedAction value: aBlock
]

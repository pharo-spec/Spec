Extension { #name : #SpTabPresenter }

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter >> actions [

	^ actionsHolder value
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter >> actions: aCollection [

	actionsHolder value: aCollection
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter >> actionsHolder [

	^ actionsHolder
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter class >> adapterName [

	^ #TabAdapter
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter >> closeable [

	^ closeableHolder value
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter >> closeable: aBoolean [

	closeableHolder value: aBoolean
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter >> closeableHolder [

	^ closeableHolder
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter >> contents [

	^ morphHolder value
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter >> contents: aMorph [

	morphHolder value: aMorph
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter >> defaultIcon [

	^ self iconNamed: #blankIcon
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter >> icon [

	^ iconHolder value
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter >> icon: aForm [

	iconHolder value: aForm
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter >> iconHolder [

	^ iconHolder
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter >> iconName: aSymbol [

	iconHolder value: (self iconNamed: aSymbol)
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter >> initialExtent [

	^ 200@25
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter >> initialize [
	"Initialization code for TabPresenter"

	super initialize.

	labelHolder := '' asValueHolder.
	iconHolder := self defaultIcon asValueHolder.
	morphHolder := nil asValueHolder.
	retrievingBlockHolder := nil asValueHolder.
	menuHolder := nil asValueHolder.
	actionsHolder := OrderedCollection new asValueHolder.
	closeableHolder := true asValueHolder.
	tabSelectedActionHolder := [  ] asValueHolder.
	selectedHolder := false asValueHolder
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter class >> isDeprecated [
	^ true
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter >> label [

	^ labelHolder value
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter >> label: aString [

	labelHolder value: aString
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter >> labelHolder [

	^ labelHolder
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter >> menu [

	^ menuHolder value
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter >> menu: aBlock [

	menuHolder value: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter >> menuHolder [

	^ menuHolder
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter >> morphHolder [

	^ morphHolder
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter >> presenter: aPresenter [
	aPresenter owner: self.
	self retrievingBlock: [ aPresenter buildWithSpec ]
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter >> retrievingBlock [

	^ retrievingBlockHolder value
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter >> retrievingBlock: aBlock [

	retrievingBlockHolder value: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter >> retrievingBlockHolder [

	^ retrievingBlockHolder
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter >> selected: aBoolean [

	selectedHolder value: aBoolean
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter >> selectedHolder [

	^ selectedHolder
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter >> tabSelected [ 

	tabSelectedActionHolder value cull: self
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter >> tabSelectedAction [

	^ tabSelectedActionHolder value
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter >> tabSelectedActionHolder [

	^ tabSelectedActionHolder
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenter >> whenTabSelected: aBlock [

	tabSelectedActionHolder value: aBlock
]

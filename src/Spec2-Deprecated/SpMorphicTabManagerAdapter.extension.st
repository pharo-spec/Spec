Extension { #name : #SpMorphicTabManagerAdapter }

{ #category : #'*Spec2-Deprecated' }
SpMorphicTabManagerAdapter >> addTab: aTab [
	self widgetDo: [ :w | w addTab: (self buildTab: aTab) ]
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTabManagerAdapter >> buildTab: aTab [
	^ aTab buildWithSpec
		when: #tabDeleted send: #tabDeleted: to: self;
		yourself
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTabManagerAdapter >> buildWidget [
	^ TabManagerMorph new
		model: self model;
		setTabs: self getTabs;
		when: #tabSelected send: #tabSelected: to: self;
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		yourself
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTabManagerAdapter >> getTabs [
	^ [ self model tabs collect: [ :each | self buildTab: each ] ]
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTabManagerAdapter class >> isDeprecated [
	^ true
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTabManagerAdapter >> removeTab: aTab [
	"In Morphic, Tab removal is triggered on Tab, on TabManager."

	aTab adapter delete
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTabManagerAdapter >> tabDeleted: aTab [
	"Tab removal notification triggered from Morphic world."

	self model basicRemoveTab: aTab model
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTabManagerAdapter >> tabSelected: aTab [

	self model selectedTab: aTab model
]

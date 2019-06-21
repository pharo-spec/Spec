Extension { #name : #SpComposablePresenter }

{ #category : #'*Spec2-Deprecated' }
SpComposablePresenter >> aboutText: aString [
	self
		deprecated:
			'With Spec 2, ComposablePresenter was refactored to move all window management to WindowPresenter.
	From now on, if you want to interact with a window you need to:
	- Implement #initializeWindow: method (#initializeDialog: for dialogs) to manage window elements before the presenter is opened
	- Use the method #window or #withWindowDo: to interact with windows after it has been opened.'.
	self window ifNil: [ aboutText value: aString ] ifNotNil: [ :window | window aboutText: aString ]
]

{ #category : #'*Spec2-Deprecated' }
SpComposablePresenter >> askOkToClose: aBoolean [
	self
		deprecated:
			'With Spec 2, ComposablePresenter was refactored to move all window management to WindowPresenter.
	From now on, if you want to interact with a window you need to:
	- Implement #initializeWindow: method (#initializeDialog: for dialogs) to manage window elements before the presenter is opened
	- Use the method #window or #withWindowDo: to interact with windows after it has been opened.'.
	self window ifNil: [ askOkToClose value: aBoolean ] ifNotNil: [ :window | window askOkToClose: aBoolean ]
]

{ #category : #'*Spec2-Deprecated' }
SpComposablePresenter >> defaultWindowModelClass [ 
	self deprecated: 'Use #defaultWindowPresenterClass instead' transformWith: '`@receiver defaultWindowModelClass' -> '`@receiver defaultWindowPresenterClass'.
	
	^ self defaultWindowPresenterClass
]

{ #category : #'*Spec2-Deprecated' }
SpComposablePresenter >> icon: aSymbol [
	self deprecated: 'Use #iconNamed: instead' transformWith: '`@receiver icon: `@statements' -> '`@receiver iconNamed: `@statements'.
	^ self iconNamed: aSymbol
]

{ #category : #'*Spec2-Deprecated' }
SpComposablePresenter >> instantiateModels: aCollectionOfPairs [
	
	self deprecated: 'Use #instantiatePresenters: instead' transformWith: '`@receiver instantiateModels: `@statement' -> '`@receiver instantiatePresenters: `@statement'.

	^ self instantiatePresenters: aCollectionOfPairs
]

{ #category : #'*Spec2-Deprecated' }
SpComposablePresenter >> newIconList [
	self deprecated: 'Please use #newList instead.' transformWith: '`@receiver newIconList' -> '`@receiver newList'.
	^ self instantiate: SpIconListPresenter
]

{ #category : #'*Spec2-Deprecated' }
SpComposablePresenter >> newMultiColumnList [
	self deprecated: 'Use newTable instead' on: '2019-02-05' in: #Pharo8.
	^ self instantiate: SpMultiColumnListPresenter
]

{ #category : #'*Spec2-Deprecated' }
SpComposablePresenter >> newTab [

	self 
		deprecated: 'Use newNotebook instead' 
		on: '2019-01-24' 
		in: #Pharo8.
	^ self instantiate: SpTabPresenter
]

{ #category : #'*Spec2-Deprecated' }
SpComposablePresenter >> newTabManager [
	
	
	self 
		deprecated: 'Use newNotebook instead' 
		on: '2019-01-24' 
		in: #Pharo8.
	
	^ self instantiate: SpTabManagerPresenter
]

{ #category : #'*Spec2-Deprecated' }
SpComposablePresenter >> newTree [
	
	self deprecated: 'Use #newTreeTable instead'.

	^ self instantiate: SpTreePresenter
]

{ #category : #'*Spec2-Deprecated' }
SpComposablePresenter >> on: aShortcut do: aBlock [

	self 
		deprecated: 'Use #bindKeyCombination:toAction: instead.' 
		transformWith: '`@receiver on: `@statements1 do: `@statements2' 
						-> '`@receiver bindKeyCombination: `@statements1 toAction: `@statements2'.

	self bindKeyCombination: aShortcut toAction: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpComposablePresenter >> setModal: aWindow [

	self 
		deprecated: 'Do not use this directly. Use #openModalWithSpec (and family) instead.' 
		on: '2019-02-26' 
		in: #Pharo8.
	
	self changed: #setModal: with: { aWindow }
]

{ #category : #'*Spec2-Deprecated' }
SpComposablePresenter >> title: aString [
	self
		deprecated:
			'With Spec 2, ComposablePresenter was refactored to move all window management to WindowPresenter.
	From now on, if you want to interact with a window you need to:
	- Implement #initializeWindow: method (#initializeDialog: for dialogs) to manage window elements before the presenter is opened
	- Use the method #window or #withWindowDo: to interact with windows after it has been opened.'.
	self window ifNil: [ titleHolder value: aString ] ifNotNil: [ :window | window title: aString ]
]

{ #category : #'*Spec2-Deprecated' }
SpComposablePresenter >> widget [
	"I return the adapter responsible of building my widget"
	
	self deprecated: 'Should use #adapter instead'
		transformWith: '`@receiver widget' -> '`@receiver adapter'.
	
	^ self spec
]

{ #category : #'*Spec2-Deprecated' }
SpComposablePresenter >> windowIcon: aForm [
	self
		deprecated:
			'With Spec 2, ComposablePresenter was refactored to move all window management to WindowPresenter.
	From now on, if you want to interact with a window you need to:
	- Implement #initializeWindow: method (#initializeDialog: for dialogs) to manage window elements before the presenter is opened
	- Use the method #window or #withWindowDo: to interact with windows after it has been opened.'.
	self window ifNil: [ windowIcon value: aForm ] ifNotNil: [ :window | window windowIcon: aForm ]
]

"
Test class for DynamicPresentersListBuilder.
"
Class {
	#name : #DynamicPresentersListBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : #'Spec-Tests-Dynamic-Builder'
}

{ #category : #running }
DynamicPresentersListBuilderTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	super setUp.
	builder := DynamicPresentersListBuilder new
]

{ #category : #tests }
DynamicPresentersListBuilderTest >> testGenerateNullPresentersInstVarNames [
	builder
		modelObjects: { 1 . 2 . 3 }.
	
	self
		assertCollection: (builder generateNullPresentersInstVarNames: 3) equals: #(var4 var5 var6)
]

{ #category : #tests }
DynamicPresentersListBuilderTest >> testGenerateUniqueInstanceVariableName [
	1 to: 10 do: [ :i |
		self assert: builder generateUniqueInstanceVariableName equals: (#var , i asString) asSymbol ]
]

{ #category : #tests }
DynamicPresentersListBuilderTest >> testInstVarNames [
	builder
		modelObjects: { 3 . 2 . 1 }.
		
	self
		assertCollection: builder instVarNames hasSameElements: #(var1 var2 var3)
]

{ #category : #tests }
DynamicPresentersListBuilderTest >> testInstVarNamesAndPresenterNamesArray [
	builder
		modelObjects: { 3 . 2 . 1 };
		presenterBlock: [ :o | SpButtonPresenter ].
		
	self
		assertCollection: builder instVarNamesAndPresenterNamesArray hasSameElements: #(var1 #SpButtonPresenter var2 #SpButtonPresenter var3 #SpButtonPresenter)
]

{ #category : #tests }
DynamicPresentersListBuilderTest >> testModelObjects [
	builder
		modelObjects: { 3 . 2 . 1 }.
		
	self
		assertCollection: builder instVarToModelObject hasSameElements: { #var1 -> 3. #var2 -> 2. #var3 -> 1 }
]

{ #category : #tests }
DynamicPresentersListBuilderTest >> testNullPresentersInstVarNamesAndPresenterNamesArray [
	builder
		modelObjects: { 1 . 2 . 3 };
		presenter: SpCheckBoxPresenter configuredAs: [ :presenter :modelObject | ];
		buildDynamicPresenter;
		createNullPresenters: 3.
	
	self
		assertCollection: builder nullPresentersInstVarNamesAndPresenterNamesArray equals: #(var4 #SpNullPresenter var5 #SpNullPresenter var6 #SpNullPresenter)
]

{ #category : #tests }
DynamicPresentersListBuilderTest >> testPresenterConfiguredAs [
	| block |
	self
		assert: builder presenterBlock isNil;
		assert: builder configurationBlock isNil.
	
	block := [ :p :m | ].
	builder
		presenter: SpButtonPresenter configuredAs: block.
		
	self
		assert: (builder presenterBlock value: nil) equals: SpButtonPresenter; "Any value can be provided to the block in this case, always the same presenter is returned."
		assert: builder configurationBlock equals: block
]

{ #category : #tests }
DynamicPresentersListBuilderTest >> testPresenterProvidedByConfiguredAs [
	| block |
	self
		assert: builder presenterBlock isNil;
		assert: builder configurationBlock isNil.
	
	block := [ :p :m | ].
	builder
		presenterProvidedBy: [ :integer |
			integer even
				ifTrue: [ SpButtonPresenter ]
				ifFalse: [ SpLabelPresenter ] ] configuredAs: block.
		
	self
		assert: (builder presenterBlock value: 1) equals: SpLabelPresenter;
		assert: (builder presenterBlock value: 2) equals: SpButtonPresenter;
		assert: builder configurationBlock equals: block
]

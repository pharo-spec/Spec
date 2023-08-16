Class {
	#name : #SpCodePresenterTest,
	#superclass : #SpTextPresenterTest,
	#category : #'Spec2-Code-Tests'
}

{ #category : #accessing }
SpCodePresenterTest >> classToTest [

	^ SpCodePresenter
]

{ #category : #testing }
SpCodePresenterTest >> expectedFailures [

	"This test do not pass on CI because headless image has display size = 0@0 and then 
	 morphic behaves weird. PropagateNaturalHeight/Width is weak on Morphic because of 
	 this (if not, see the algoritm I was forced to do), but for now passes (just, not on CI :)"
	Smalltalk isHeadless ifTrue: [ ^ #() ].

	"This test will not work on SpCodePresenter because it uses a monospaced font (and this 
	 fails in morphic)"
	^ #(testPropagateNaturalWidth)
]

{ #category : #initialization }
SpCodePresenterTest >> initializeTestedInstance [

	super initializeTestedInstance.
	presenter environment: self newEnvironment
]

{ #category : #'instance creation' }
SpCodePresenterTest >> newEnvironment [
	| environment |
	
	environment := SystemDictionary new.
	self class withAllSuperclassesDo: [ :each |
		environment at: each name put: each ].
	
	^ environment
]

{ #category : #tests }
SpCodePresenterTest >> testChangingEditingModeDoesNotTriggersTextChanged [
	| changed |
	
	changed := false.
	presenter whenTextChangedDo: [ changed := true ].
	presenter beForBehavior: Object.
	self deny: changed	
]

{ #category : #tests }
SpCodePresenterTest >> testContextKeyBindings [
	| contextKeyBindings |
	
	contextKeyBindings := presenter contextKeyBindings.
	self assert: contextKeyBindings notNil.
	self assert: (contextKeyBindings isKindOf: KMCategory).
	
]

{ #category : #tests }
SpCodePresenterTest >> testContextMenu [
	| menu changed |
	
	self assert: presenter contextMenu isNotNil. "The code presenter comes with a menu by default"
	menu := SpMenuPresenter new.
	changed := false.
	presenter whenMenuChangedDo: [ 
		changed := true. ].
	presenter contextMenu: menu.
	self assert: changed
]

{ #category : #'tests - commands' }
SpCodePresenterTest >> testDoBrowseClass [
	| navigation |
	
	navigation := SpCodeSystemNavigationMock new.
	presenter systemNavigation: navigation.
	self openInstance.
	
	presenter text: 'SpCodePresenterTest'.
	"Selection"
	presenter selectionInterval: (1 to: 19).
	presenter doBrowseClass.
	
	self assert: navigation browseClass equals: SpCodePresenterTest.
	
	navigation reset.
	"Line"
	presenter cursorPositionIndex: 1.
	presenter selectionInterval: (1 to: 0).
	presenter doBrowseClass.
	self assert: navigation browseClass equals: SpCodePresenterTest.
	
	"Middle of line"
	presenter cursorPositionIndex: 5.
	presenter selectionInterval: (5 to: 4).
	presenter doBrowseClass.
	self assert: navigation browseClass equals: SpCodePresenterTest.

	"End of line"
	presenter cursorPositionIndex: 14.
	presenter selectionInterval: (14 to: 13).
	presenter doBrowseClass.
	self assert: navigation browseClass equals: SpCodePresenterTest.
]

{ #category : #'tests - commands' }
SpCodePresenterTest >> testDoBrowseClassNotFound [
	| navigation |
	
	"in fact, compiling a non existing class is popping a a dialog to choose what 
	 to do (I hate that). Until that is fixed, this test is useless."
	self skip.
	
	navigation := SpCodeSystemNavigationMock new.
	presenter systemNavigation: navigation.
	self openInstance.
	
	presenter text: 'ClassThatDoesNotExits'.
	presenter doBrowseClass.
	
	self assert: navigation messageList isNil
]

{ #category : #'tests - commands' }
SpCodePresenterTest >> testDoBrowseClassReferences [
	| navigation |
	
	navigation := SpCodeSystemNavigationMock new.
	presenter systemNavigation: navigation.
	self openInstance.
	
	presenter text: 'SpCodePresenterTest'.
	"Selection"
	presenter selectionInterval: (1 to: 19).
	presenter doBrowseClassReferences.
	
	self assert: navigation messageList notNil.
	self assert: navigation messageList notEmpty
]

{ #category : #'tests - commands' }
SpCodePresenterTest >> testDoBrowseHierarchy [
	| navigation |
	
	navigation := SpCodeSystemNavigationMock new.
	presenter systemNavigation: navigation.
	self openInstance.
	
	presenter text: 'SpCodePresenterTest'.
	"Selection"
	presenter selectionInterval: (1 to: 19).
	presenter doBrowseHierarchy.
	
	self assert: navigation browseClass equals: SpCodePresenterTest
]

{ #category : #'tests - commands' }
SpCodePresenterTest >> testDoBrowseImplementors [
	| navigation |
	
	navigation := SpCodeSystemNavigationMock new.
	presenter systemNavigation: navigation.
	self openInstance.
	
	presenter text: 'testDoBrowseImplementors'.
	presenter doBrowseImplementors.
	
	self 
		assert: navigation messageList asArray
		equals: { SpCodePresenterTest>>#testDoBrowseImplementors }
]

{ #category : #'tests - commands' }
SpCodePresenterTest >> testDoBrowseMethodReferences [
	| navigation |
	
	navigation := SpCodeSystemNavigationMock new.
	presenter systemNavigation: navigation.
	presenter environment add: SpCodePresenterTest binding.
	presenter environment add: SpCodeSystemNavigationMock binding.
	self openInstance.
	
	presenter text: 'Object'.
	presenter doBrowseMethodReferences.
	
	self assert: navigation messageList isNil.
	
	navigation reset.
	presenter text: 'SpCodeSystemNavigationMock'.
	presenter doBrowseMethodReferences.
	
	self assert: navigation messageList notEmpty.
	self assert: (navigation messageList includes: SpCodePresenterTest >> #testDoBrowseMethodReferences)
]

{ #category : #'tests - commands' }
SpCodePresenterTest >> testDoBrowseMethodsContainingString [
	| navigation |
	
	navigation := SpCodeSystemNavigationMock new.
	presenter systemNavigation: navigation.
	self openInstance.
	
	"Restrict environment to make things faster"
	presenter environment: (SystemDictionary new 
		at: #SpCodePresenterTest put: SpCodePresenterTest;
		yourself).
	presenter text: 'testDoBrowseMethodsContainingString'.
	presenter doBrowseMethodsContainingString.
	
	self assert: navigation messageList notEmpty.
	self assert: (navigation messageList includes: SpCodePresenterTest >> #testDoBrowseMethodsContainingString)
]

{ #category : #'tests - commands' }
SpCodePresenterTest >> testDoBrowseMethodsMatchingStringInsensitive [
	| navigation |
	
	navigation := SpCodeSystemNavigationMock new.
	presenter systemNavigation: navigation.
	self openInstance.
	
	"Restrict environment to make things faster"
	presenter environment: (SystemDictionary new 
		at: #SpCodePresenterTest put: SpCodePresenterTest;
		yourself).
		
	"no matter what I put, it will find it in this method"
	"First find it even if is not same case (case insensitive)"
	presenter text: 'MatchTextToFind' asLowercase. 
	presenter doBrowseMethodsMatchingStringInsensitive.
	
	self assert: navigation messageList notEmpty.
	self assert: (navigation messageList includes: SpCodePresenterTest >> #testDoBrowseMethodsMatchingStringSensitive).
	
	"Now find it matching if sensitive"
	navigation reset.
	presenter text: 'MatchTextToFind'. 
	presenter doBrowseMethodsMatchingStringSensitive.
	
	self assert: navigation messageList notEmpty.
	self assert: (navigation messageList includes: SpCodePresenterTest >> #testDoBrowseMethodsMatchingStringSensitive).
	
]

{ #category : #'tests - commands' }
SpCodePresenterTest >> testDoBrowseMethodsMatchingStringSensitive [
	| navigation |
	
	navigation := SpCodeSystemNavigationMock new.
	presenter systemNavigation: navigation.
	self openInstance.
	
	"Restrict environment to make things faster"
	presenter environment: (SystemDictionary new 
		at: #SpCodePresenterTest put: SpCodePresenterTest;
		yourself).
		
	"no matter what I put, it will find it in this method"
	"First do not find it (case sensitive)"
	presenter text: 'MatchTextToFind' asLowercase. 
	presenter doBrowseMethodsMatchingStringSensitive.
	
	self assert: navigation messageList isEmpty.
	
	"Now find it"
	navigation reset.
	presenter text: 'MatchTextToFind'. 
	presenter doBrowseMethodsMatchingStringSensitive.
	
	self assert: navigation messageList notEmpty.
	self assert: (navigation messageList includes: SpCodePresenterTest >> #testDoBrowseMethodsMatchingStringSensitive).
	
]

{ #category : #'tests - commands' }
SpCodePresenterTest >> testDoBrowseOnAMethodSelectorOpensAnImplementor [
	
	| navigation |
	navigation := SpCodeSystemNavigationMock new.
	presenter systemNavigation: navigation.
	self openInstance.
	
	presenter text: '#Point'.
	"Selection"
	presenter selectionInterval: (1 to: 6).
	presenter doBrowseClass.
	
	self assert: navigation browseClass equals: Point.
	
	navigation reset.
	"Line"
	presenter cursorPositionIndex: 1.
	presenter selectionInterval: (1 to: 0).
	presenter doBrowseClass.
	self assert: navigation browseClass equals: Point.
	
	"Middle of line"
	presenter cursorPositionIndex: 5.
	presenter selectionInterval: (5 to: 4).
	presenter doBrowseClass.
	self assert: navigation browseClass equals: Point.

	"End of line"
	presenter cursorPositionIndex: 14.
	presenter selectionInterval: (14 to: 13).
	presenter doBrowseClass.
	self assert: navigation browseClass equals: Point.
]

{ #category : #'tests - commands' }
SpCodePresenterTest >> testDoBrowseOnSymbolRepresentingAClassBrowsesTheClass [

	| navigation |
	navigation := SpCodeSystemNavigationMock new.
	presenter systemNavigation: navigation.
	self openInstance.
	
	presenter text: '#Point'.
	"Selection"
	presenter selectionInterval: (1 to: 6).
	presenter doBrowseClass.
	
	self assert: navigation browseClass equals: Point.
	
	navigation reset.
	"Line"
	presenter cursorPositionIndex: 1.
	presenter selectionInterval: (1 to: 0).
	presenter doBrowseClass.
	self assert: navigation browseClass equals: Point.
	
	"Middle of line"
	presenter cursorPositionIndex: 5.
	presenter selectionInterval: (5 to: 4).
	presenter doBrowseClass.
	self assert: navigation browseClass equals: Point.

	"End of line"
	presenter cursorPositionIndex: 14.
	presenter selectionInterval: (14 to: 13).
	presenter doBrowseClass.
	self assert: navigation browseClass equals: Point.
]

{ #category : #'tests - commands' }
SpCodePresenterTest >> testDoBrowseSenders [
	| navigation |
	
	navigation := SpCodeSystemNavigationMock new.
	presenter systemNavigation: navigation.
	self openInstance.
	
	presenter text: 'doBrowseSenders'.
	presenter doBrowseSenders.
	
	self assert: navigation messageList notEmpty.
	self assert: (navigation messageList includes: SpCodePresenterTest >> #testDoBrowseSenders)
]

{ #category : #'tests - commands' }
SpCodePresenterTest >> testDoBrowseSendersOfClassNameShouldNotFindIfNotInEnvironment [
	| navigation |
	
	navigation := SpCodeSystemNavigationMock new.
	presenter systemNavigation: navigation.
	self openInstance.
	
	presenter text: 'NonExistingClassPleaseFindNothingXXXXXX'.
	presenter doBrowseSenders.
	
	self assert: navigation messageList isEmpty
]

{ #category : #'tests - commands' }
SpCodePresenterTest >> testDoBrowseSendersOfClassNameShouldSelectClassUsers [
	| navigation theClass |
	
	navigation := SpCodeSystemNavigationMock new.
	presenter systemNavigation: navigation.
	self openInstance.
	
	"Add the binding to the testing environment so we can look for users of it"
	presenter environment add: SpNavigationMockClass binding.
	presenter text: 'SpNavigationMockClass'.
	presenter doBrowseSenders.
	
	theClass := self class environment at: #SpNavigationMockClass.
	
	self assert: (navigation messageList includes: theClass >> #referenceToYourself)
]

{ #category : #'tests - commands' }
SpCodePresenterTest >> testDoBrowseSendersOfClassNameWhenInPlayground [
	| navigation theClass |
	
	navigation := SpCodeSystemNavigationMock new.
	presenter systemNavigation: navigation.
	
	"Add the binding to the testing environment so we can look for users of it"
	presenter environment add: SpNavigationMockClass binding.
	presenter interactionModel: SpCodeScriptingInteractionModel new.
	self openInstance.
	
	presenter text: 'SpNavigationMockClass'.
	presenter doBrowseSenders.
	
	theClass := self class environment at: #SpNavigationMockClass.
	
	self assert: (navigation messageList includes: theClass >> #referenceToYourself)
]

{ #category : #'tests - commands' }
SpCodePresenterTest >> testDoBrowseSendersOfClassNameWhenInPlaygroundAndEnvironmentIsNil [
	| navigation theClass |
	
	navigation := SpCodeSystemNavigationMock new.
	presenter systemNavigation: navigation.
	
	"Reproduce the case of the playground when the environment is nil. We should check on the environment of the tools?"
	presenter environment: nil.
	
	presenter interactionModel: SpCodeScriptingInteractionModel new.
	self openInstance.
	
	presenter text: 'SpNavigationMockClass'.
	presenter doBrowseSenders.
	
	theClass := self class environment at: #SpNavigationMockClass.
	
	self assert: (navigation messageList includes: theClass >> #referenceToYourself)
]

{ #category : #'tests - commands' }
SpCodePresenterTest >> testDoBrowseSendersOfClassNameWhenInPlaygroundButNotAvailable [
	| navigation |
	
	navigation := SpCodeSystemNavigationMock new.
	presenter systemNavigation: navigation.
	presenter interactionModel: SpCodeScriptingInteractionModel new.
	self openInstance.
	
	presenter text: 'NonExistingClassPleaseFindNothingXXXXXX'.
	presenter doBrowseSenders.
	
	self assert: navigation messageList isEmpty
]

{ #category : #'tests - commands' }
SpCodePresenterTest >> testDoBrowseSendersOfClassPoolVariableShouldSelectClassPoolVariableUsersWhenInDebugger [
	| navigation theClass methodInContext evaluationContext |

	theClass := self class environment at: #SpNavigationMockClass.
	methodInContext := theClass >> #referenceToTheClassVariable.
	evaluationContext := (Context newForMethod: methodInContext)
		pc: methodInContext initialPC;
		privRefreshWith: methodInContext;
		yourself.
	
	navigation := SpCodeSystemNavigationMock new.
	presenter systemNavigation: navigation.
	presenter interactionModel: (SpContextInteractionModel
		on: evaluationContext).
	self openInstance.
	
	"Add the binding to the testing environment so we can look for users of it"
	presenter text: 'SomeClassPoolVariable'.
	presenter doBrowseSenders.

	
	self assert: (navigation messageList includes: theClass >> #referenceToTheClassPoolVariable)
]

{ #category : #'tests - commands' }
SpCodePresenterTest >> testDoBrowseSendersOfClassPoolVariableShouldSelectClassPoolVariableUsersWhenInDebuggerButNotAvailable [
	| navigation theClass methodInContext evaluationContext |

	theClass := self class environment at: #SpNavigationMockClass.
	methodInContext := Object >> #yourself.
	evaluationContext := (Context newForMethod: methodInContext)
		pc: methodInContext initialPC;
		privRefreshWith: methodInContext;
		yourself.
	
	navigation := SpCodeSystemNavigationMock new.
	presenter systemNavigation: navigation.
	presenter interactionModel: (SpContextInteractionModel
		on: evaluationContext).
	self openInstance.
	
	"Add the binding to the testing environment so we can look for users of it"
	presenter text: 'SomeClassPoolVariable'.
	presenter doBrowseSenders.

	
	self assert: navigation messageList isEmpty
]

{ #category : #'tests - commands' }
SpCodePresenterTest >> testDoBrowseSendersOfClassVariableShouldSelectClassVariableUsersWhenInDebugger [
	| navigation theClass methodInContext evaluationContext |

	theClass := self class environment at: #SpNavigationMockClass.
	methodInContext := theClass >> #referenceToTheClassVariable.
	evaluationContext := (Context newForMethod: methodInContext)
		pc: methodInContext initialPC;
		privRefreshWith: methodInContext;
		yourself.
	
	navigation := SpCodeSystemNavigationMock new.
	presenter systemNavigation: navigation.
	presenter interactionModel: (SpContextInteractionModel
		on: evaluationContext).
	self openInstance.
	
	"Add the binding to the testing environment so we can look for users of it"
	presenter text: 'SomeClassVariable'.
	presenter doBrowseSenders.

	
	self assert: (navigation messageList includes: theClass >> #referenceToTheClassVariable)
]

{ #category : #'tests - commands' }
SpCodePresenterTest >> testDoBrowseSendersOfClassVariableShouldSelectClassVariableUsersWhenInDebuggerButNotAvailable [
	| navigation theClass methodInContext evaluationContext |

	theClass := self class environment at: #SpNavigationMockClass.
	methodInContext := Object >> #yourself.
	evaluationContext := (Context newForMethod: methodInContext)
		pc: methodInContext initialPC;
		privRefreshWith: methodInContext;
		yourself.
	
	navigation := SpCodeSystemNavigationMock new.
	presenter systemNavigation: navigation.
	presenter interactionModel: (SpContextInteractionModel
		on: evaluationContext).
	self openInstance.
	
	"Add the binding to the testing environment so we can look for users of it"
	presenter text: 'SomeClassVariable'.
	presenter doBrowseSenders.

	
	self assert: navigation messageList isEmpty
]

{ #category : #'tests - commands' }
SpCodePresenterTest >> testDoBrowseSendersOfClassVariableShouldSelectClassVariableUsersWhenInStaticContext [
	| navigation theClass |
	
	theClass := self class environment at: #SpNavigationMockClass.
	
	navigation := SpCodeSystemNavigationMock new.
	presenter systemNavigation: navigation.
	presenter interactionModel: (SpCodeBehaviorInteractionModel
		on: theClass).
	self openInstance.
	
	"Add the binding to the testing environment so we can look for users of it"
	presenter text: 'SomeClassVariable'.
	presenter doBrowseSenders.

	
	self assert: (navigation messageList includes: theClass >> #referenceToTheClassVariable)
]

{ #category : #'tests - commands' }
SpCodePresenterTest >> testDoBrowseSendersOfClassVariableShouldSelectClassVariableUsersWhenInStaticContextButNotAvailable [
	| navigation |
	
	navigation := SpCodeSystemNavigationMock new.
	presenter systemNavigation: navigation.
	presenter interactionModel: (SpCodeBehaviorInteractionModel
		on: Object).
	self openInstance.
	
	"Add the binding to the testing environment so we can look for users of it"
	presenter text: 'SomeClassVariable'.
	presenter doBrowseSenders.

	
	self assert: navigation messageList isEmpty
]

{ #category : #'tests - command support' }
SpCodePresenterTest >> testEnvironment [
	| environment navigation |
	
	"Since the environment is not actually working, this is hard to test for now"
	self skip.

	environment := self newEnvironment.
	navigation := SpCodeSystemNavigationMock new.
	
	presenter environment: environment.
	presenter systemNavigation: navigation.
	
	self openInstance.
	
	"we will find Object but not OrderedCollection"
	presenter text: 'Object'.
	presenter doBrowseClass.
	
	self assert: navigation browseClass equals: Object.
	
	navigation reset.
 	presenter text: 'OrderedCollection'.
	presenter doBrowseClass.
	
	self assert: navigation browseClass isNil

]

{ #category : #'tests - command support' }
SpCodePresenterTest >> testEvaluateOnCompileErrorOnError [

	self 
		assert: (presenter evaluate: 'Obj { }}' onCompileError: [ #compile ] onError: [ :e | #error ])
		equals: #compile.
		
	self 
		assert: (presenter evaluate: 'nil text' onCompileError: [ #compile ] onError: [ :e | #error ])
		equals: #error.	
		
	self 
		assert: (presenter evaluate: '42' onCompileError: [ #compile ] onError: [ :e | #error ])
		equals: 42.		
]

{ #category : #'tests - command support' }
SpCodePresenterTest >> testEvaluateSendAnnouncements [

	| willBeEvaluated succeed failed |
	presenter announcer
		when: SpCodeWillBeEvaluatedAnnouncement
		do: [ :ann | willBeEvaluated := true ]
		for: self;
		when: SpCodeEvaluationSucceedAnnouncement
		do: [ :ann | succeed := true ]
		for: self;
		when: SpCodeEvaluationFailedAnnouncement
		do: [ :ann | failed := true ]
		for: self.

	willBeEvaluated := false.
	succeed := false.
	failed := false.
	presenter
		evaluate: '42 factorial'
		onCompileError: [ #compileError ]
		onError: [ :e | #error ].
	self assert: willBeEvaluated.
	self assert: succeed.
	self deny: failed.

	willBeEvaluated := false.
	succeed := false.
	failed := false.
	presenter
		evaluate: 'Obj { }}'
		onCompileError: [ #compile ]
		onError: [ :e | #error ].
	self assert: willBeEvaluated.
	self deny: succeed.
	self assert: failed.

	willBeEvaluated := false.
	succeed := false.
	failed := false.
	presenter
		evaluate: 'nil text'
		onCompileError: [ #compile ]
		onError: [ :e | #error ].
	self assert: willBeEvaluated.
	self deny: succeed.
	self assert: failed
]

{ #category : #tests }
SpCodePresenterTest >> testNilTestSelectedSelectorDoesNotBreakExecution [
	"Code presenter has nil text for some reason"

	| selector |
	presenter text: nil.
	selector := presenter selectedSelector.
	self assert: selector isNil.
]

{ #category : #'tests - command support' }
SpCodePresenterTest >> testSelectedSelectorForMethodEditing [

	"Testing border cases to avoid breaking execution. The selector extraction logic should be tested in the extractor class"

	"Code presenter has nil text for some reason"

	| selector |
	presenter text: nil.
	selector := presenter selectedSelector.
	self assert: selector isNil.

	"Code presenter is empty"
	presenter text: ''.
	selector := presenter selectedSelector.
	self assert: selector isNil.

	"Code has valid code"
	selector := presenter text: 'aMethod do: 1 with: 2'.
	selector := presenter selectedSelector.
	self assert: selector equals: #aMethod.

	"Code has faulty code"
	selector := presenter text: 'aMethod do : 1 with: 2'.
	selector := presenter selectedSelector.
	self assert: selector equals: #aMethod.

	"Code depends on contextual information"
	selector := presenter text: 'aMethodName: anArg anArg aMessageSend: anotherArg'.
	selector := presenter selectedSelector.
	self assert: selector equals: #aMethodName:.

	"Code has invalid code (no selectors at all)"
	"selector := presenter text: 'anObjectdo : 2'.
	selector := presenter selectedSelector.
	self assert: selector equals: #noMethod"
]

{ #category : #'tests - command support' }
SpCodePresenterTest >> testSelectedSelectorForScripting [

	"Testing border cases to avoid breaking execution. The selector extraction logic should be tested in the extractor class"

	"Code presenter has nil text for some reason"

	| selector |
	presenter text: nil.
	presenter beForScripting.
	selector := presenter selectedSelector.
	self assert: selector isNil.

	"Code presenter is empty"
	presenter text: ''.
	selector := presenter selectedSelector.
	self assert: selector isNil.

	"Code has valid code"
	selector := presenter text: 'anObject do: 1 with: 2'.
	selector := presenter selectedSelector.
	self assert: selector equals: #do:with:.

	"Code has faulty code"
	selector := presenter text: 'anObject do : 1 with: 2'.
	selector := presenter selectedSelector.
	self assert: selector equals: #do.

	"Code depends on contextual information"
	selector := presenter text: 'aMethodName: anArg anArg aMessageSend: anotherArg'.
	selector := presenter selectedSelector.
	self assert: selector equals: #aMethodName:aMessageSend:.

	"Code has invalid code (no selectors at all)"
	"selector := presenter text: 'anObjectdo : 2'.
	selector := presenter selectedSelector.
	self assert: selector equals: #noMethod"
]

{ #category : #'tests - command support' }
SpCodePresenterTest >> testSelectedSelectorWithPointerAtEnd [
	"Testing border cases to avoid breaking execution. The selector extraction logic should be tested in the extractor class"
	| selector string |

	self openInstance.

	"end of text with several posibilities"
	string := 'Smalltalk allClassesAndTraits reject: #hasComment'.
	presenter text: string.
	"move cursor to end"
	presenter cursorPositionIndex: string size + 1.
	"ensure there is no selection"
	presenter clearSelection.
	"for some reason, clear selection also moved the pointer back to first position. 
	 IMO trhat should not happen, but seems to be a rubric problem. I hacke the selection by 
	 respecting the position wiyh next line."
	presenter selectionInterval: ((string size + 1) to: string size).
	selector := presenter selectedSelector.
	self assert: selector equals: #hasComment.

	"end of text with several lines"	
	string := '42 factorial.
Smalltalk allClassesAndTraits reject: #hasComment'.
	presenter text: string.
	"move cursor to end"
	presenter cursorPositionIndex: string size + 1.
	"ensure there is no selection"
	"ensure there is no selection"
	presenter clearSelection.
	presenter selectionInterval: ((string size + 1) to: string size).
	selector := presenter selectedSelector.
	self assert: selector equals: #hasComment.
	

	"Code depends on contextual information"
	selector := presenter text: 'aMethodName: anArg anArg aMessageSend: anotherArg'.
	presenter cursorPositionIndex: string size + 1.
	"ensure there is no selection"
	presenter clearSelection.
	presenter selectionInterval: ((string size + 1) to: string size).
	selector := presenter selectedSelector.
	self assert: selector equals: #aMessageSend:.
]

{ #category : #tests }
SpCodePresenterTest >> testWhenSyntaxHighlightChangedDo [
	| count result |
	count := 0.
	result := true.
	presenter
		whenSyntaxHighlightChangedDo: [ :syntaxHighlight | 
			count := count + 1.
			result := syntaxHighlight ].
	presenter withoutSyntaxHighlight.
	self assert: count equals: 1.
	self deny: result
]

{ #category : #tests }
SpCodePresenterTest >> testWhenSyntaxHighlightThemeChangedDo [
	| count result |
	
	count := 0.
	result := nil.
	presenter whenSyntaxHighlightThemeChangedDo: [ :syntaxHighlight | 
		count := count + 1.
		result := syntaxHighlight ].
	presenter syntaxHighlightTheme: 'Other'.
	
	self assert: count equals: 1.
	self assert: result equals: 'Other'
]

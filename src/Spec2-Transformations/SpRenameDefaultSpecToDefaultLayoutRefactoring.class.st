"
I can be used to convert a presenter #defaultSpec class method to a #defaultLayout class method 
"
Class {
	#name : #SpRenameDefaultSpecToDefaultLayoutRefactoring,
	#superclass : #RBAddMethodRefactoring,
	#instVars : [
		'presenterClass'
	],
	#category : #'Spec2-Transformations'
}

{ #category : #'instance creation' }
SpRenameDefaultSpecToDefaultLayoutRefactoring class >> onPresenter: aPresenterClass [

	^ self basicNew
		presenterClass: aPresenterClass;
		initialize;
		yourself

]

{ #category : #initialization }
SpRenameDefaultSpecToDefaultLayoutRefactoring >> initialize [ 
	| layoutMethod |
	layoutMethod := #defaultLayout , ((presenterClass>>#defaultSpec) ast sourceCode allButFirst: #defaultSpec size).
	self 
		addMethod: layoutMethod 
		toClass: presenterClass 
		inProtocols: 'layout' 
]

{ #category : #preconditions }
SpRenameDefaultSpecToDefaultLayoutRefactoring >> preconditions [
	| selector method |
	method := self parserClass
		parseMethod: source
		onError: [ :string :position | 
			^ RBCondition
				withBlock: [ self refactoringFailure: 'The sources could not be parsed' ] ].
	selector := method selector.
	selector ifNil: [ self refactoringFailure: 'Invalid source.' ].
	^ self emptyCondition
]

{ #category : #accessing }
SpRenameDefaultSpecToDefaultLayoutRefactoring >> presenterClass: aClass [
	| env |
	
	presenterClass := aClass.
	env := RBClassHierarchyEnvironment class: presenterClass.
	self model: (RBNamespace new 
			environment: env;
			yourself).
]

{ #category : #transforming }
SpRenameDefaultSpecToDefaultLayoutRefactoring >> transform [ 
	super transform.
	(presenterClass>>#defaultSpec) removeFromSystem
]

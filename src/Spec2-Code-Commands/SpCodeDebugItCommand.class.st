"
I'm a ""debug it"" command. 
I will debug the selection (or line) of the playground.
"
Class {
	#name : #SpCodeDebugItCommand,
	#superclass : #SpCodeSelectionCommand,
	#category : #'Spec2-Code-Commands-Base'
}

{ #category : #accessing }
SpCodeDebugItCommand class >> defaultDescription [

	^ 'Debug selection.'
]

{ #category : #default }
SpCodeDebugItCommand class >> defaultIconName [

	^ #smallDebug
]

{ #category : #default }
SpCodeDebugItCommand class >> defaultName [ 

	^ 'Debug it'
]

{ #category : #default }
SpCodeDebugItCommand class >> defaultShortcutKey [

	^ $d shift command mac 
		| $d shift control win
		| $d shift control unix
]

{ #category : #private }
SpCodeDebugItCommand >> compile: aStream for: anObject in: evalContext [
	| methodClass |

	methodClass := evalContext
		ifNil: [ anObject class ]
		ifNotNil: [ evalContext methodClass ].

	^ context class compiler
		source: aStream;
		class: methodClass;
		context: evalContext;
		requestor: context; "it should enable a visibility of current tool variables in new debugger"
		noPattern: true;
		failBlock: [ ^ nil ];
		compile
]

{ #category : #private }
SpCodeDebugItCommand >> debug: aStream [
	| method doItReceiver doItContext |

	(self context respondsTo: #doItReceiver)
		ifTrue: [ 
			doItReceiver := self context doItReceiver.
			doItContext := self context doItContext ]
		ifFalse: [ 
			doItReceiver := doItContext := nil ].
		
	method := self compile: aStream for: doItReceiver in: doItContext.
	method isReturnSpecial ifTrue: [ 
		self inform: 'Nothing to debug, the expression is optimized'.
		^ self ].
	method ifNotNil: [
		self debug: method receiver: doItReceiver in: doItContext ]
]

{ #category : #private }
SpCodeDebugItCommand >> debug: aCompiledMethod receiver: anObject in: evalContext [
	| process suspendedContext debugRequest |

	process := [ 
		aCompiledMethod
			valueWithReceiver: anObject
			arguments: (aCompiledMethod numArgs = 0 
				ifTrue: [ #() ] 
				ifFalse: [ { evalContext } ] ) ]
			newProcess.
	suspendedContext := process suspendedContext.

	debugRequest := (OupsDebugRequest newForContext: suspendedContext)
		process: process;
		compiledMethod: aCompiledMethod;
		label: 'debug it';
		yourself.
	debugRequest debugSession application: context application.
	debugRequest submit
]

{ #category : #execution }
SpCodeDebugItCommand >> execute [
	| selection |

	selection := self selectedTextOrLine.
	selection ifEmpty: [ ^ '' ].
	
	self debug: selection readStream
]

Class {
	#name : #SpExecutionByObjectCounter,
	#superclass : #ExecutionCounter,
	#category : #'Spec2-Tests-Core'
}

{ #category : #accessing }
SpExecutionByObjectCounter >> increase [
	| receiver |

	receiver := thisContext stack copy.
	count 
		at: receiver
		put: (count at: receiver ifAbsent: [ 0 ]) + 1
]

{ #category : #initialization }
SpExecutionByObjectCounter >> initialize [

	super initialize.
	count := OrderedIdentityDictionary new.
]

{ #category : #actions }
SpExecutionByObjectCounter >> install [

	link := MetaLink new 
				metaObject: self;
				selector: #increase;
				options: #(+ optionAnnounce + optionCompileOnLinkInstallation).
	node link: link.
	self class allCounters at: node put: self.
]

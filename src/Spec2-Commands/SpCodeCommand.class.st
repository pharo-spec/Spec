Class {
	#name : #SpCodeCommand,
	#superclass : #CmCommand,
	#category : #'Spec2-Commands-Code'
}

{ #category : #defaults }
SpCodeCommand class >> defaultShortcutKey [

	^ nil
]

{ #category : #converting }
SpCodeCommand >> asSpecCommand [
	| command |

	command := super asSpecCommand.
	self shortcutKey 
		ifNotNil: [ :key | command shortcutKey: key ].

	^ command
]

{ #category : #accessing }
SpCodeCommand >> shortcutKey [

	^ self class defaultShortcutKey
]

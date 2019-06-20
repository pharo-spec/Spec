"
I'm a default application for the case where no application is defined.
I'm meant to provide backwards compatibility and I SHOULD NOT BE USED REGULARLY.
"
Class {
	#name : #SpNullApplication,
	#superclass : #SpApplication,
	#category : #'Spec-Core-Base'
}

{ #category : #accessing }
SpNullApplication class >> reset [
	<script>
	
	DefaultApplication := nil
]

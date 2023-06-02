Class {
	#name : #SpStyleEnvironmentColorProxyTest,
	#superclass : #TestCase,
	#category : #'Spec2-Adapters-Morphic-Tests'
}

{ #category : #tests }
SpStyleEnvironmentColorProxyTest >> testSerializationWithFuelMaintainProxy [

 	| proxy byteArray deserialized |
	
	proxy := SpStyleEnvironmentColorProxy new
		colorSelector: #backgroundColor;
		yourself.
		
	self assert: proxy class equals: SpStyleEnvironmentColorProxy.
	
	byteArray := FLSerializer serializeToByteArray: proxy.
	deserialized := FLMaterializer materializeFromByteArray: byteArray.
	
	self assert: deserialized class equals: proxy class.
	self assert: (MirrorPrimitives fieldOf: deserialized at: 1) equals: (MirrorPrimitives fieldOf: proxy at: 1)
]

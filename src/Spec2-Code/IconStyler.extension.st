Extension { #name : 'IconStyler' }

{ #category : '*Spec2-Code' }
IconStyler class >> withSpecStaticStyler [
	"Configure the receiver with a Spec renderer and all static stylers."

	^ self new
		  stylerClasses: (self allSubclasses select: #isStaticStyler);
		  renderer: SpIconStylerRenderer new;
		  yourself
]

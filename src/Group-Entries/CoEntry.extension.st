Extension { #name : 'CoEntry' }

{ #category : '*Group-Entries' }
CoEntry >> activateOn: aCompletionContext [

	| entryContents |
	self propertyAt: #children 
		ifPresent: [ aCompletionContext openGroup: self ] 
		ifAbsent: [
			"Log the usage"
			CoAdHocUsageTracker incrementUsageFor: self contents. 
			"By default insert the contents of the entry instead of the token in the text editor"
			entryContents := self contents asSymbol separateKeywords.
			entryContents := self class spaceAfterCompletion
				                 ifTrue: [ entryContents , ' ' ]
				                 ifFalse: [ entryContents ].
			aCompletionContext replaceTokenInEditorWith: entryContents ]
]

{ #category : '*Group-Entries' }
CoEntry >> browse [ 
	^ false
]

{ #category : '*Group-Entries' }
CoEntry >> children [ 
	self propertyAt: #children ifPresent: [ ^self propertyAt: #children ]
]

{ #category : '*Group-Entries' }
CoEntry >> children: aCollection [

	self propertyAt: #children put: aCollection
]

{ #category : '*Group-Entries' }
CoEntry >> createDescription [

	| preview limit |
	limit := (self propertyAt: #children) size min: 10.

	preview := String streamContents: [ :stream |
			           1 to: limit do: [ :i |
					           stream
						           nextPutAll: ((self propertyAt: #children) at: i) displayedContents;
						           cr ] ].

	^ CoEntryDescription label: 'group' title: (self propertyAt: #prefix) , ' (' , (self propertyAt: #children) size asString , ')' description: preview
]

{ #category : '*Group-Entries' }
CoEntry >> hightlightSymbol [


	 ^ self propertyAt: #children 
		ifPresent: [ (self propertyAt: #children) ifEmpty: [ nil ] ifNotEmpty: [ (self propertyAt: #children) first hightlightSymbol ]]
		ifAbsent: [ nil ]
]

{ #category : '*Group-Entries' }
CoEntry >> isGroupEntry [

	self propertyAt: #children 
		ifPresent:  [ ^true ]
		ifAbsent: [ ^false ]
]

{ #category : '*Group-Entries' }
CoEntry >> prefix [

	^ self propertyAt: #prefix 
]

{ #category : '*Group-Entries' }
CoEntry >> prefix: aString [

	self propertyAt: #prefix put: aString
]

{ #category : '*Group-Entries' }
CoEntry class >> prefix: aString children: aCollection [

	^ self new
		  propertyAt: #prefix put: aString;
		  propertyAt: #children put: aCollection asOrderedCollection ;
		  contents: aString;
		  displayedContents: aString , ' ▸';
		  yourself
]

{ #category : '*Group-Entries' }
CoEntry >> rawLabel [

	^ 'group'
]

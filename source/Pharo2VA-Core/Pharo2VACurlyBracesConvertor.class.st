Class {
	#name : #Pharo2VACurlyBracesConvertor,
	#superclass : #RBProgramNodeVisitor,
	#category : #'Pharo2VA-Core'
}

{ #category : #visiting }
Pharo2VACurlyBracesConvertor >> visitArrayNode: anArrayNode [
	| rootNode arraySize receiverNode yourselfNode messages |
	arraySize := anArrayNode statements size.
	receiverNode := RBMessageNode receiver: (RBGlobalNode named: #Array) selector: #new: arguments: {(RBLiteralValueNode value: arraySize)}.
	messages := anArrayNode statements
		withIndexCollect: [ :statement :index | 
			RBMessageNode
				receiver: receiverNode
				selector: #at:put:
				arguments:
					{(RBLiteralValueNode value: index).
					statement} ].
	yourselfNode := RBMessageNode receiver: receiverNode selector: #yourself.
	messages add: yourselfNode.
	rootNode := RBCascadeNode new messages: messages.
	anArrayNode parent replaceNode: anArrayNode withNode: rootNode.
	self visitNode: rootNode
]

require "fileutils"

engines = %w{
camunda7_0_0
camunda7_1_0
camunda7_2_0
camunda7_3_0
activiti5_15_1
activiti5_16_3
activiti5_17_0
activiti5_18_0
activiti5_19_0
jbpm__6_0_1
jbpm__6_1_0
jbpm__6_2_0
jbpm__6_3_0
}

processes = %w{
ExclusiveGateway
ExclusiveGateway_Default
ExclusiveGatewayMixed
ExclusiveDiverging_InclusiveConverging
InclusiveGateway
InclusiveGateway_Default
InclusiveDiverging_ExclusiveConverging
ParallelGateway
ParallelDiverging_ExclusiveConverging
ParallelDiverging_InclusiveConverging
ParallelGateway_TrueParallelism
ComplexGateway
EventBasedGateway_Signals
EventBasedGateway_Timer
CallActivity_Process
CallActivity_GlobalTask
MultiInstance_SubProcess
MultiInstance_Task
MultiInstance_Sequential
MultiInstance_NoneBehavior
MultiInstance_OneBehavior
MultiInstance_AllBehavior
MultiInstance_ComplexBehavior
MultiInstance_Parallel
Loop_SubProcess
Loop_Task
Loop_ConditionOnly
Loop_Maximum
Loop_NoIteration_TestBeforeFalse
Loop_NoIteration_TestBeforeTrue
SubProcess
Transaction
AdHocSubProcess_Sequential
AdHocSubProcess_Parallel
Token_Cardinality_Explicit
Token_Cardinality_Default
Token_Cardinality_Split_Default
Token_Cardinality_Split_Explicit
SendTask
ReceiveTask
ReceiveTask_Instantiate
Cancel_Event
Compensation_BoundaryEvent_SubProcess
Compensation_EndEvent_SubProcess
Compensation_EndEvent_TopLevel
Compensation_IntermediateEvent
Compensation_StartEvent_EventSubProcess
Compensation_TriggeredByCancel
Conditional_BoundaryEvent_SubProcess_Interrupting
Conditional_BoundaryEvent_SubProcess_NonInterrupting
Conditional_IntermediateEvent
Conditional_StartEvent_EventSubProcess_Interrupting
Conditional_StartEvent_EventSubProcess_NonInterrupting
Error_BoundaryEvent_SubProcess_Interrupting
Error_BoundaryEvent_Transaction_Interrupting
Error_EndEvent_TopLevel
Error_StartEvent_EventSubProcess_Interrupting
Escalation_BoundaryEvent_SubProcess_Interrupting
Escalation_BoundaryEvent_SubProcess_NonInterrupting
Escalation_EndEvent_SubProcess
Escalation_EndEvent_TopLevel
Escalation_IntermediateThrowEvent
Escalation_StartEvent_EventSubProcess_Interrupting
Escalation_StartEvent_EventSubProcess_NonInterrupting
Link_Event
Message_StartEvent
Message_IntermediateEvent
Message_EndEvent
Signal_EndEvent_SubProcess
Signal_BoundaryEvent_SubProcess_NonInterrupting
Signal_BoundaryEvent_SubProcess_Interrupting
Signal_IntermediateEvent_ThrowAndCatch
Signal_StartEvent
Signal_EndEvent
Signal_IntermediateEvent
Signal_StartEvent_EventSubProcess_Interrupting
Signal_StartEvent_EventSubProcess_NonInterrupting
Terminate_Event
Timer_IntermediateEvent
Timer_BoundaryEvent_SubProcess_NonInterrupting
Timer_BoundaryEvent_SubProcess_Interrupting
Timer_BoundaryEvent_SubProcess_Interrupting_Activity
Timer_StartEvent_EventSubProcess_NonInterrupting
Timer_StartEvent_EventSubProcess_Interrupting
Timer_IntermediateTimeCycleEvent
Timer_BoundaryEvent_SubProcess_TimeCycle
Timer_StartEvent_TimeCycle_EventSubProcess_NonInterrupting
Multiple_Parallel_IntermediateEvent
Multiple_IntermediateEvent_ThrowFirstEventDefinition
Multiple_IntermediateEvent_ThrowLastEventDefinition
Multiple_IntermediateThrowEvent
Multiple_IntermediateEvent_MissingEvent
Multiple_Parallel_IntermediateEvent_MissingEvent
EventDefinitionRef_Error_EndEvent_TopLevel
EventDefinitionRef_Error_StartEvent_EventSubProcess_Interrupting
EventDefinitionRef_Signal_BoundaryEvent_SubProcess_NonInterrupting
EventDefinitionRef_Timer_IntermediateEvent
Lanes
Participant
SequenceFlow
SequenceFlow_Conditional
SequenceFlow_ConditionalDefault
SequenceFlow_ConditionalDefault_Normal
ParallelGateway_Conditions
ExclusiveDiverging_ParallelConverging
InclusiveDiverging_ParallelConverging
LoopTask_NegativeLoopMaximum
MultiInstanceTask_NegativeLoopCardinality
Token_StartQuantity_Two
Token_StartQuantity_Zero
Token_CompletionQuantity_Zero
DataObject_ReadWrite_String
Property_ReadWrite_String
WCP01_Sequence
WCP02_ParallelSplit
WCP03_Synchronization
WCP04_ExclusiveChoice
WCP05_SimpleMerge
WCP06_MultiChoice_InclusiveGateway
WCP06_MultiChoice_Implicit
WCP06_MultiChoice_ComplexGateway
WCP07_StructuredSynchronizingMerge
WCP08_MultiMerge
WCP09_Structured_Discriminator_ComplexGateway
WCP09_Structured_Discriminator_MultiInstance
WCP10_ArbitraryCycles
WCP11_ImplicitTermination
WCP12_MultipleInstancesWithoutSynchronization
WCP13_MultipleInstancesWithAPrioriDesignTimeKnowledge
WCP14_MultipleInstancesWithAPrioriRuntimeKnowledge
WCP16_DeferredChoice
WCP17_InterleavedParallelRouting
WCP19_CancelTask
WCP20_CancelCaseError
WCP20_CancelCaseCancel
WCP20_CancelCaseTerminate
}

Dir.glob("results").each do |f|
	FileUtils.rm_r f
end

def self.run(cmd)
	puts cmd
	puts `bash #{cmd}`
end

run "docker-remove-all-stopped-containers"

i = 1
max = engines.size * processes.size
engines.each do |engine|
	processes.each do |process|
		puts "#{i}/#{max} - #{Time.now}"
		run "betsy-#{engine} #{process}"
		run "docker-remove-all-stopped-containers"
		i += 1
	end
end



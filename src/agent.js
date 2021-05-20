import { Actor } from "@dfinity/agent"
import { idlFactory as counter_idl, canisterId as counter_id } from "dfx-generated/counter"
import { idlFactory as kanban_idl, canisterId as kanban_id } from "dfx-generated/kanban"

export let counter = {}
export let kanban = {}
export function initAgents (agent) {
  counter = Actor.createActor(counter_idl, { agent, canisterId: counter_id });
  kanban = Actor.createActor(kanban_idl, { agent, canisterId: kanban_id });
}
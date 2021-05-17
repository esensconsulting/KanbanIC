import { Actor, HttpAgent } from "@dfinity/agent"
import { idlFactory as counter_idl, canisterId as counter_id } from "dfx-generated/counter"

export let counter = {}
export function initAgents (agent) {
  counter = Actor.createActor(counter_idl, { agent, canisterId: counter_id });
  counter.canisterId = counter_id;
}
#!/bin/bash
dfx canister call kanban createProfile '("anthony", opt null)'
dfx canister call kanban createProfile '("dave", opt null)'
dfx canister --no-wallet call kanban getAllProfiles
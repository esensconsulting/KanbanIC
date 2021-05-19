#!/bin/bash

dfx canister call kanban createBoard '("testboard")'
dfx canister call kanban createColumn '("To do",0)'
dfx canister call kanban createCard '("create new logo","we should create a new logo with colors", 0)'
dfx canister --no-wallet call kanban getBoardDto '(0)'
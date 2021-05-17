cd internet-identity
npm i
dfx deploy --no-wallet --argument '(null)'
echo "VITE_INTERNET_IDENTITY_URL=http://localhost:8000/?canisterId=$(dfx canister id internet_identity)" > ../.env
cd ..
dfx deploy

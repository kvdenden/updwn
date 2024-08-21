# Deployment steps

### price feed configuration

- set PRICE_FEED_ADDRESS env variable
- set PRICE_INTERVAL env variable
- set PRICE_INITIAL_TIMESTAMP env variable (optional)

### deploy rng

- forge script script/RNG.s.sol:Deploy --broadcast --verify --slow --rpc-url base_sepolia
- set RNG_CONTRACT_ADDRESS env variable

### deploy token

- forge script script/UPDWN.s.sol:Deploy --broadcast --verify --slow --rpc-url base_sepolia
- set UPDWN_CONTRACT_ADDRESS env variable

### deploy renderer

- forge script script/Renderer.s.sol:Deploy --broadcast --verify --slow --rpc-url base_sepolia
- set RENDERER_CONTRACT_ADDRESS env variable

### deploy message broker

- forge script script/MessageBroker.s.sol:Deploy --broadcast --verify --slow --rpc-url base_sepolia
- set MESSAGE_BROKER_CONTRACT_ADDRESS env variable

### deploy price feed

- forge script script/PriceFeed.s.sol:Deploy --broadcast --verify --slow --rpc-url base_sepolia
- set PRICE_FEED_CONTRACT_ADDRESS env variable

### deploy treasury

- forge script script/Treasury.s.sol:Deploy --broadcast --verify --slow --rpc-url base_sepolia
- set TREASURY_CONTRACT_ADDRESS env variable

### deploy reward strategy

- forge script script/RewardStrategy.s.sol:Deploy --broadcast --verify --slow --rpc-url base_sepolia
- set REWARD_STRATEGY_CONTRACT_ADDRESS env variable

### deploy game engine

- forge script script/GameEngine.s.sol:Deploy --broadcast --verify --slow --rpc-url base_sepolia
- set GAME_ENGINE_CONTRACT_ADDRESS env variable

### deploy token minter

- forge script script/TokenMinter.s.sol:Deploy --broadcast --verify --slow --rpc-url base_sepolia
- set TOKEN_MINTER_CONTRACT_ADDRESS env variable

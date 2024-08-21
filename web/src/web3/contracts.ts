import { updwnAbi, tokenMinterAbi, gameEngineAbi, iPriceFeedAbi, iTreasuryAbi } from "./abi";

export const updwn = {
  address: process.env.NEXT_PUBLIC_UPDWN_CONTRACT_ADDRESS,
  abi: updwnAbi,
};

export const tokenMinter = {
  address: process.env.NEXT_PUBLIC_TOKEN_MINTER_CONTRACT_ADDRESS,
  abi: tokenMinterAbi,
};

export const gameEngine = {
  address: process.env.NEXT_PUBLIC_GAME_ENGINE_CONTRACT_ADDRESS,
  abi: gameEngineAbi,
};

export const priceFeed = {
  address: process.env.NEXT_PUBLIC_PRICE_FEED_CONTRACT_ADDRESS,
  abi: iPriceFeedAbi,
};

export const treasury = {
  address: process.env.NEXT_PUBLIC_TREASURY_CONTRACT_ADDRESS,
  abi: iTreasuryAbi,
};

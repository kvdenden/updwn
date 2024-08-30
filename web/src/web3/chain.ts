import { type Chain } from "viem";
import { base, baseSepolia, anvil } from "viem/chains";

function getChain(): Chain {
  switch (process.env.NEXT_PUBLIC_CHAIN_ID) {
    case "mainnet":
      return base;
    case "testnet":
      return baseSepolia;
    default:
      return anvil;
  }
}

function getRPC(): string {
  switch (process.env.NEXT_PUBLIC_CHAIN_ID) {
    case "mainnet":
      return `https://base-mainnet.g.alchemy.com/v2/${process.env.NEXT_PUBLIC_ALCHEMY_API_KEY}` as const;
    case "testnet":
      return `https://base-sepolia.g.alchemy.com/v2/${process.env.NEXT_PUBLIC_ALCHEMY_API_KEY}` as const;
    default:
      return "http://localhost:8545" as const;
  }
}

export const CHAIN = getChain();
export const RPC = getRPC();

export default CHAIN;

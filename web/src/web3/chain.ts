import { type Chain } from "viem";
import { base, baseSepolia } from "viem/chains";

function getChain(): Chain {
  switch (process.env.NEXT_PUBLIC_CHAIN_ID) {
    case "mainnet":
      return base;
    default:
      return baseSepolia;
  }
}

function getRPC(): string {
  switch (process.env.NEXT_PUBLIC_CHAIN_ID) {
    case "mainnet":
      return `https://base-mainnet.g.alchemy.com/v2/${process.env.NEXT_PUBLIC_ALCHEMY_API_KEY}` as const;
    default:
      return `https://base-sepolia.g.alchemy.com/v2/${process.env.NEXT_PUBLIC_ALCHEMY_API_KEY}` as const;
  }
}

export const CHAIN = getChain();
export const RPC = getRPC();

export default CHAIN;

import { createConfig } from "@ponder/core";
import { http } from "viem";
import { updwnAbi } from "./abis";

export default createConfig({
  networks: {
    base: {
      chainId: process.env.PONDER_CHAIN_ID,
      transport: http(process.env.PONDER_RPC_URL),
    },
  },
  contracts: {
    updwn: {
      network: "base",
      abi: updwnAbi,
      address: process.env.UPDWN_CONTRACT_ADDRESS,
    },
  },
});

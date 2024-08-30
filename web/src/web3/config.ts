import { http } from "wagmi";
import { getDefaultConfig } from "@rainbow-me/rainbowkit";

import { CHAIN, RPC } from "@/web3/chain";

export const config = getDefaultConfig({
  appName: "UP/DWN",
  projectId: process.env.NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID,
  chains: [CHAIN],
  transports: {
    [CHAIN.id]: http(RPC),
  },
  ssr: true, // If your dApp uses server side rendering (SSR)
});

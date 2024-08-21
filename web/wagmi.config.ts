import { defineConfig } from "@wagmi/cli";
import { foundry } from "@wagmi/cli/plugins";

export default defineConfig({
  out: "src/web3/abi.ts",
  plugins: [
    foundry({
      project: "../contracts",
      include: ["UPDWN.sol/**", "TokenMinter.sol/**", "GameEngine.sol/**", "IPriceFeed.sol/**", "ITreasury.sol/**"],
    }),
  ],
});

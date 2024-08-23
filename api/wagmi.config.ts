import { defineConfig } from "@wagmi/cli";
import { foundry } from "@wagmi/cli/plugins";

export default defineConfig({
  out: "abis/index.ts",
  plugins: [
    foundry({
      project: "../contracts",
      include: ["UPDWN.sol/**", "GameEngine.sol/**", "IPriceFeed.sol/**", "ITreasury.sol/**"],
    }),
  ],
});

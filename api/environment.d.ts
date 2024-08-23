namespace NodeJS {
  interface ProcessEnv {
    PONDER_CHAIN_ID: number;
    PONDER_RPC_URL?: string;

    UPDWN_CONTRACT_ADDRESS: `0x${string}`;
    GAME_ENGINE_CONTRACT_ADDRESS: `0x${string}`;
    PRICE_FEED_CONTRACT_ADDRESS: `0x${string}`;
    TREASURY_CONTRACT_ADDRESS: `0x${string}`;
  }
}

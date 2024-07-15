"use client";

import { ConnectButton as RainbowKitButton } from "@rainbow-me/rainbowkit";

import { Button, ButtonProps } from "@/components/ui/button";

export default function ConnectButton(props: ButtonProps) {
  return (
    <RainbowKitButton.Custom>
      {({ account, chain, openAccountModal, openChainModal, openConnectModal, mounted }) => {
        const ready = mounted;
        const connected = ready && account && chain;

        return (
          <div
            {...(!ready && {
              "aria-hidden": true,
              style: {
                opacity: 0,
                pointerEvents: "none",
                userSelect: "none",
              },
            })}
          >
            {(() => {
              if (!connected) {
                return (
                  <Button onClick={openConnectModal} {...props}>
                    Connect Wallet
                  </Button>
                );
              }

              if (chain.unsupported) {
                return (
                  <Button onClick={openChainModal} variant="destructive" {...props}>
                    Wrong network
                  </Button>
                );
              }

              return (
                <Button onClick={openAccountModal} {...props}>
                  {account.displayName}
                </Button>
              );
            })()}
          </div>
        );
      }}
    </RainbowKitButton.Custom>
  );
}

import "./globals.css";

import type { Metadata } from "next";
import localFont from "next/font/local";
import Web3Provider from "@/web3/provider";
import { cn } from "@/lib/utils";
import { ThemeProvider } from "next-themes";
import { SiteHeader } from "@/components/SiteHeader";
import { Footer } from "@/components/Footer";

const font = localFont({
  src: [
    {
      path: "./Disket-Rostype/Disket-Mono-Bold.ttf",
      style: "normal",
      weight: "700",
    },
    {
      path: "./Disket-Rostype/Disket-Mono-Regular.ttf",
      style: "normal",
      weight: "400",
    },
  ],
  variable: "--font-disket",
});

export const metadata: Metadata = {
  title: "UP/DWN",
  description:
    "UP/DWN - The NFT collection that's more than just art! Predict Ethereum prices, hold your tokens, and win big with our no-loss lottery. With 4096 unique tokens and DeFi-powered prizes, it's your ticket to endless fun and rewards. Predict. Hold. Win!",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body className={cn("min-h-screen bg-background font-disket antialiased", font.variable)}>
        <ThemeProvider attribute="class" defaultTheme="dark" disableTransitionOnChange>
          <Web3Provider>
            <SiteHeader />
            {children}
            <Footer />
          </Web3Provider>
        </ThemeProvider>
      </body>
    </html>
  );
}

import "./globals.css";

import type { Metadata } from "next";
import { Inter } from "next/font/google";

import { ThemeProvider } from "next-themes";

import Web3Provider from "@/web3/provider";
import GraphQLProvider from "@/graphql/provider";
import { cn } from "@/lib/utils";

const fontSans = Inter({ subsets: ["latin"], variable: "--font-sans" });

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
    <html lang="en" suppressHydrationWarning>
      <body className={cn("min-h-screen bg-background font-sans antialiased", fontSans.variable)}>
        <ThemeProvider attribute="class" defaultTheme="dark" disableTransitionOnChange>
          <GraphQLProvider>
            <Web3Provider>{children}</Web3Provider>
          </GraphQLProvider>
        </ThemeProvider>
      </body>
    </html>
  );
}

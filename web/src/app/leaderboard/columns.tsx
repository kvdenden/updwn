"use client";

import { ColumnDef } from "@tanstack/react-table";
import { Button } from "@/components/ui/button";
import { ChevronUp, ChevronDown } from "lucide-react";

type Users = {
  id: string;
  wallet_address: string;
  wins: number;
  claimed: number;
  nfts: number;
};

export const columns: ColumnDef<Users>[] = [
  {
    accessorKey: "wallet_address",
    header: "Player",
  },
  {
    accessorKey: "nfts",
    header: ({ column }) => {
      const isSorted = column.getIsSorted();
      return (
        <Button variant="ghost" className="pl-0 hover:bg-transparent" onClick={() => column.toggleSorting()}>
          <span style={{ fontWeight: isSorted ? "bold" : "normal", color: isSorted ? "" : "secondary" }}>
            # of NFTs
          </span>
          {isSorted === "asc" ? (
            <ChevronUp className="ml-2 h-4 w-4" />
          ) : isSorted === "desc" ? (
            <ChevronDown className="ml-2 h-4 w-4" />
          ) : (
            <ChevronDown className="ml-2 h-4 w-4 text-gray-400" />
          )}
        </Button>
      );
    },
  },
  {
    accessorKey: "wins",
    header: ({ column }) => {
      const isSorted = column.getIsSorted();
      return (
        <Button variant="ghost" className="pl-0 hover:bg-transparent" onClick={() => column.toggleSorting()}>
          <span style={{ fontWeight: isSorted ? "bold" : "normal", color: isSorted ? "" : "secondary" }}>Wins</span>
          {isSorted === "asc" ? (
            <ChevronUp className="ml-2 h-4 w-4" />
          ) : isSorted === "desc" ? (
            <ChevronDown className="ml-2 h-4 w-4" />
          ) : (
            <ChevronDown className="ml-2 h-4 w-4 text-gray-400" />
          )}
        </Button>
      );
    },
  },
  {
    accessorKey: "claimed",
    header: ({ column }) => {
      const isSorted = column.getIsSorted();
      return (
        <Button variant="ghost" className="pl-0 hover:bg-transparent" onClick={() => column.toggleSorting()}>
          <span style={{ fontWeight: isSorted ? "bold" : "normal", color: isSorted ? "" : "secondary" }}>Claimed</span>
          {isSorted === "asc" ? (
            <ChevronUp className="ml-2 h-4 w-4" />
          ) : isSorted === "desc" ? (
            <ChevronDown className="ml-2 h-4 w-4" />
          ) : (
            <ChevronDown className="ml-2 h-4 w-4 text-gray-400" />
          )}
        </Button>
      );
    },
  },
];

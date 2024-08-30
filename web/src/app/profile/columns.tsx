"use client";

import { ColumnDef } from "@tanstack/react-table";

type Actions = {
  date: string;
  action: string;
};

export const columns: ColumnDef<Actions>[] = [
  {
    accessorKey: "date",
    header: "Date",
  },
  {
    accessorKey: "action",
    header: "Action",
  },
  {
    accessorKey: "detail",
    header: "Info",
  },
];

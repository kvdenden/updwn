"use client";

import * as React from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { siteConfig } from "@/lib/siteConfig";
import { cn } from "@/lib/utils";
import { Icons } from "@/components/Icons";

export function MainNav() {
  const pathname = usePathname();

  return (
    <div className="mr-4 hidden md:flex">
      <Link href="/" className="mr-6 flex items-center space-x-2">
        <Icons.logo className="h-6 w-6" />
        <span className="hidden font-bold sm:inline-block font-disket">{siteConfig.name}</span>
      </Link>
      <nav className="flex items-center gap-6 text-sm">
        <Link
          href={"/profile"}
          className={cn("hidden text-foreground/60 transition-colors hover:text-foreground/80 md:block")}
        >
          Profile
        </Link>
        <Link
          href={"/explore"}
          className={cn("hidden text-foreground/60 transition-colors hover:text-foreground/80 md:block")}
        >
          Explore
        </Link>
        <Link
          href={"/leaderboard"}
          className={cn("hidden text-foreground/60 transition-colors hover:text-foreground/80 md:block")}
        >
          Leaderboard
        </Link>
      </nav>
    </div>
  );
}

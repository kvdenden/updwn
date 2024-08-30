import { siteConfig } from "@/lib/siteConfig";
import { TwitterLogoIcon, GitHubLogoIcon } from "@radix-ui/react-icons";
import { SiFarcaster } from "react-icons/si";

export function Footer() {
  return (
    <footer className="py-6 md:py-0 border-t border-border/40">
      <div className="container max-w-7xl px-2 flex flex-col items-center justify-between gap-4 md:h-24 md:flex-row ">
        <p className="text-balance text-center text-sm leading-loose text-muted-foreground md:text-left">
          Built by{" "}
          <a
            href={siteConfig.links.twitter}
            target="_blank"
            rel="noreferrer"
            className="font-medium underline underline-offset-4"
          >
            Studio Enden
          </a>
        </p>
        <div className="flex">
          <TwitterLogoIcon className="h-[1.8rem] w-[1.8rem]  mr-4" />
          <GitHubLogoIcon className="h-[1.8rem] w-[1.8rem]  mr-4" />
          <SiFarcaster className="h-[1.8rem] w-[1.8rem]  mr-4" />
        </div>
      </div>
    </footer>
  );
}

import { MainNav } from "@/components/MainNav";
import { MobileNav } from "@/components/MobileNav";
import { ModeToggle } from "@/components/ModeToggle";
import ConnectButton from "@/components/ConnectButton";

export function SiteHeader() {
  return (
    <header className="sticky top-0 z-50 w-full border-b border-border/40 bg-background/100 backdrop-blur supports-[backdrop-filter]:bg-background/100">
      <div className="container mx-auto px-2 flex h-14 max-w-7xl items-center">
        <MainNav />
        <MobileNav />
        <div className="flex flex-1 items-center  space-x-2 justify-end">
          <nav className="flex items-center">
            <ConnectButton />
            <div className="ml-2">
              <ModeToggle />
            </div>
          </nav>
        </div>
      </div>
    </header>
  );
}

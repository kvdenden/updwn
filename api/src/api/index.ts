import { ponder } from "@/generated";

ponder.get("/hello", (c) => {
  return c.text("Hello, world!");
});

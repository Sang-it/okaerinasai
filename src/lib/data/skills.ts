export interface SkillCategory {
  name: string;
  items: string[];
}

export const skills: SkillCategory[] = [
  {
    name: "Languages",
    items: ["Rust", "TypeScript", "C", "C++", "C#", "Go", "Python", "Haskell", "Lua", "Scala", "Elixir", "Zig"],
  },
  {
    name: "Infrastructure",
    items: ["Docker", "gRPC / Protobuf", "PostgreSQL", "ClickHouse", "Qdrant", "pgvector", "Cloudflare Workers"],
  },
  {
    name: "Web",
    items: ["SvelteKit", "SolidJS", "React", "Next.js", "Astro", "Node.js", "Bun", "Hono", "Effect-TS"],
  },
  {
    name: "Tools",
    items: ["Neovim", "Git", "Linux", "CMake", "Treesitter", "LSP", "ANTLR", "SDL2", "QEMU"],
  },
  {
    name: "AI / ML",
    items: ["NumPy", "MCP", "Vercel AI SDK", "RAG Pipelines", "Vector Search"],
  },
  {
    name: "Interests",
    items: [
      "Language Design",
      "Compilers",
      "Emulation",
      "Systems Programming",
      "OS Development",
      "Observability",
      "AI Infrastructure",
      "Formal Languages",
      "Developer Tools",
    ],
  },
];

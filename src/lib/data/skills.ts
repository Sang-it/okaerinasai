export interface SkillCategory {
  name: string;
  items: string[];
}

export const skills: SkillCategory[] = [
  {
    name: "Languages",
    items: ["Rust", "TypeScript", "C++", "Go", "Python", "Haskell", "Lua", "Swift", "Zig"],
  },
  {
    name: "Tools",
    items: ["Linux", "ClickHouse", "Docker", "Neovim", "Git"],
  },
  {
    name: "Web",
    items: ["SvelteKit", "Node.js", "Astro", "React", "Next"],
  },
  {
    name: "Interests",
    items: [
      "Language Design",
      "Compilers",
      "Emulation",
      "Systems Programming",
      "Observability",
      "Developer Tools",
    ],
  },
];

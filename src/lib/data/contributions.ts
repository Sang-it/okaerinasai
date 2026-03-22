export interface Contribution {
  slug: string;
  project: string;
  projectDescription: string;
  projectUrl: string;
  projectStars: number;
  language: string;
  pr: {
    title: string;
    number: number;
    url: string;
    state: string;
    mergedAt: string;
    description: string;
  };
  overview: string;
  area: string;
  techStack: string[];
}

export const contributions: Contribution[] = [
  {
    slug: "rmpc",
    project: "rmpc",
    projectDescription:
      "A modern, configurable, terminal-based MPD client with album art support via various terminal image protocols.",
    projectUrl: "https://github.com/mierak/rmpc",
    projectStars: 2550,
    language: "Rust",
    pr: {
      title: "feat: add block album_art support",
      number: 377,
      url: "https://github.com/mierak/rmpc/pull/377",
      state: "MERGED",
      mergedAt: "2025-05-30",
      description:
        "Added block-character based album art rendering, bringing image display to terminals without native image protocol support like Alacritty.",
    },
    overview:
      "Implemented block album art rendering for rmpc by adapting techniques from the viu project. This enables album art display in terminals that lack native image protocol support (sixel, kitty, iTerm2) by using Unicode block characters to approximate images. Tested and working on Alacritty.",
    area: "Terminal Graphics / TUI",
    techStack: ["Rust", "ratatui", "MPD", "Unicode Block Characters"],
  },
];

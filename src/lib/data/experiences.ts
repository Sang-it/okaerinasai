export interface Experience {
  role: string;
  description: string;
  company: string;
  timeline: string;
}

export const experiences: Experience[] = [
  {
    role: "Undergraduate Researcher",
    description:
      "Post-Graduate Research Fellow at CogAI Lab, building secure, scalable, containerized infrastructure for AI and software engineering research.",
    company: "Caldwell University",
    timeline: "03/2023 - 12/2025",
  },
  {
    role: "Backend Engineer Intern",
    description:
      "Built and maintained RESTful payment APIs serving 8M+ users and 350,000+ merchants across Nepal. Implemented payment gateway integrations with HMAC verification and idempotent processing. Optimized API performance through query profiling and caching on high-traffic endpoints.",
    company: "eSewa",
    timeline: "08/2024 - 02/2025",
  },
  {
    role: "Backend Engineer Intern",
    description:
      "Developed microservices on Kubernetes and Google Cloud powering ride-matching, food delivery, and courier services across Nepal and Bangladesh. Built real-time driver matching APIs with geospatial queries on MongoDB Atlas. Designed order lifecycle services with state machine tracking and OAuth 2.0-secured merchant APIs.",
    company: "Pathao",
    timeline: "04/2025 - 10/2025",
  },
];

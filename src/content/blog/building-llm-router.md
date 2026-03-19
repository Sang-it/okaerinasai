---
title: Building an LLM Router
date: '2026-02-15'
description: Intelligently distributing requests across language model providers.
---

# Building an LLM Router

I built `router`, a platform for distributing LLM requests across multiple providers. With options like OpenAI, Anthropic, and local models, choosing the right provider for each request matters for cost, latency, and quality.

The router accepts requests with the prompt, desired model characteristics, and constraints. It evaluates each provider's capabilities against the request requirements and routes to the best match. A simple question might go to a smaller, faster model. A complex reasoning task might use GPT-4. Code generation might use Claude.

Provider plugins encapsulate provider-specific logic. Each plugin implements the routing interface: `canHandle(request)` checks if the provider supports the requested features, `estimateCost(request)` returns the estimated price, `getLatency()` returns observed latency, and `execute(request)` calls the provider API. This abstraction makes it easy to add new providers.

Load balancing handles rate limits and capacity. Providers have different rate limits - some enforce requests per minute, others tokens per minute. The router tracks active requests and queues when providers are at capacity. Backpressure prevents overwhelming providers when they're slow. When a provider is down or returning errors, the router routes to alternatives.

Failover and retry logic improves reliability. If a request fails, the router can retry with the same provider (for transient failures) or try a different provider (for provider-specific issues). Circuit breakers prevent repeatedly routing to a provider that's experiencing problems, giving it time to recover.

Monitoring provides visibility into routing decisions and performance. The router logs which provider handled each request, along with latency, cost, and success/failure status. Metrics include request rate per provider, error rates, cost distribution, and latency percentiles. This data informs routing decisions and helps identify issues.

Caching reduces costs and latency for repeated requests. If two requests are identical, the router can return the cached response instead of calling the provider again. Cache invalidation is handled via TTL (time-to-live) - old cached responses expire and are removed.

The router sits between clients and LLM providers, abstracting away provider differences and making intelligent routing decisions. This allows applications to benefit from multiple providers without handling the complexity themselves.

<script lang="ts">
	import type { SvelteComponent } from 'svelte';

	let { data } = $props();
</script>

<svelte:head>
	<title>{data.metadata.title} - Sangit Manandhar</title>
	{#if data.metadata.description}
		<meta name="description" content={data.metadata.description} />
	{/if}
</svelte:head>

<article class="blog-post">
	<header class="post-header">
		<a href="/blog" class="back-link">&larr; back to blog</a>
		<h1>{data.metadata.title}</h1>
		<p class="post-date subtext">{data.metadata.date}</p>
	</header>

	<div class="post-content">
		<data.content />
	</div>
</article>

<style>
	.blog-post {
		padding: 2rem 0;
	}

	.post-header {
		margin-bottom: 2rem;
	}

	.back-link {
		font-size: var(--text-sm);
		color: var(--muted);
		font-family: var(--font-mono);
		display: inline-block;
		margin-bottom: 1rem;
	}

	.back-link:hover {
		color: var(--accent);
	}

	.post-header h1 {
		font-size: var(--text-2xl);
		margin: 0.25rem 0;
	}

	.post-date {
		font-size: var(--text-xs);
		font-family: var(--font-mono);
	}

	.post-content {
		line-height: 1.8;
		font-size: var(--text-sm);
		color: var(--muted);
	}

	.post-content :global(h1),
	.post-content :global(h2),
	.post-content :global(h3) {
		color: var(--fg);
		margin-top: 2rem;
		margin-bottom: 0.5rem;
	}

	.post-content :global(h1) {
		display: none;
	}

	.post-content :global(p) {
		margin: 1rem 0;
	}

	.post-content :global(ul),
	.post-content :global(ol) {
		margin: 1rem 0;
		padding-left: 1.5rem;
	}

	.post-content :global(li) {
		margin: 0.25rem 0;
	}

	.post-content :global(a) {
		color: var(--accent);
		border-bottom: 1px solid var(--accent);
	}

	.post-content :global(code) {
		background: var(--card-bg);
		border: 1px solid var(--border);
		padding: 0.15em 0.4em;
		font-size: 0.9em;
	}

	.post-content :global(pre) {
		margin: 1.5rem 0;
	}

	.post-content :global(pre code) {
		background: none;
		padding: 0;
	}
</style>

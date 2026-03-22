<script lang="ts">
	let { data } = $props();
	const c = data.contribution;
</script>

<svelte:head>
	<title>{c.project} contribution - Sangit Manandhar</title>
	<meta name="description" content={c.pr.description} />
</svelte:head>

<article class="contrib-detail">
	<header>
		<a href="/#contributions" class="back-link">&larr; back to contributions</a>
		<h1>{c.project}</h1>
		<p class="description">{c.projectDescription}</p>
	</header>

	<div class="meta-row">
		<div class="meta-item">
			<span class="meta-label">area</span>
			<span class="meta-value">{c.area}</span>
		</div>
		<div class="meta-item">
			<span class="meta-label">language</span>
			<span class="meta-value">{c.language}</span>
		</div>
		<div class="meta-item">
			<span class="meta-label">stars</span>
			<span class="meta-value">{c.projectStars.toLocaleString()}</span>
		</div>
		<div class="meta-item">
			<span class="meta-label">merged</span>
			<span class="meta-value">{c.pr.mergedAt}</span>
		</div>
	</div>

	<section class="section">
		<h2>Pull Request</h2>
		<div class="pr-info">
			<span class="pr-badge">{c.pr.state}</span>
			<a href={c.pr.url} target="_blank" rel="noopener noreferrer" class="pr-link">
				{c.pr.title} <span class="pr-number">#{c.pr.number}</span> &#8599;
			</a>
		</div>
		<p class="body-text">{c.pr.description}</p>
	</section>

	<section class="section">
		<h2>Overview</h2>
		<p class="body-text">{c.overview}</p>
	</section>

	<section class="section">
		<h2>Tech Stack</h2>
		<div class="tags">
			{#each c.techStack as tech}
				<span class="tag">{tech}</span>
			{/each}
		</div>
	</section>

	<div class="project-link">
		<a href={c.projectUrl} target="_blank" rel="noopener noreferrer">View project on GitHub &#8599;</a>
	</div>
</article>

<style>
	.contrib-detail {
		padding: 2rem 0;
	}

	header {
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
		color: var(--fg);
	}

	header h1 {
		font-size: var(--text-2xl);
		font-family: var(--font-mono);
		margin: 0.25rem 0;
	}

	.description {
		color: var(--muted);
		font-size: var(--text-sm);
		margin-top: 0.5rem;
	}

	.meta-row {
		display: flex;
		flex-wrap: wrap;
		border: 1px solid var(--border);
		margin-bottom: 2rem;
	}

	.meta-item {
		flex: 1;
		min-width: 120px;
		padding: 0.75rem 1rem;
		border-right: 1px solid var(--border);
		display: flex;
		flex-direction: column;
		gap: 0.25rem;
	}

	.meta-item:last-child {
		border-right: none;
	}

	.meta-label {
		font-size: var(--text-xs);
		color: var(--muted);
		text-transform: lowercase;
	}

	.meta-value {
		font-size: var(--text-sm);
		color: var(--fg);
	}

	.section {
		margin-bottom: 2rem;
	}

	.section h2 {
		font-size: var(--text-base);
		font-family: var(--font-mono);
		margin-bottom: 0.75rem;
		color: var(--fg);
	}

	.body-text {
		color: var(--muted);
		font-size: var(--text-sm);
		line-height: 1.7;
	}

	.pr-info {
		display: flex;
		align-items: center;
		gap: 0.75rem;
		margin-bottom: 0.75rem;
		flex-wrap: wrap;
	}

	.pr-badge {
		font-size: var(--text-xs);
		font-family: var(--font-mono);
		padding: 0.15rem 0.4rem;
		border: 1px solid var(--border);
		color: var(--fg);
		text-transform: lowercase;
	}

	.pr-link {
		font-size: var(--text-sm);
		font-family: var(--font-mono);
		color: var(--fg);
	}

	.pr-link:hover {
		color: var(--accent);
	}

	.pr-number {
		color: var(--muted);
	}

	.tags {
		display: flex;
		flex-wrap: wrap;
		gap: 0.5rem;
	}

	.tag {
		font-size: var(--text-xs);
		color: var(--muted);
		padding: 0.25rem 0.6rem;
		border: 1px solid var(--border);
		font-family: var(--font-mono);
	}

	.project-link {
		border-top: 1px solid var(--border);
		padding-top: 1.5rem;
	}

	.project-link a {
		font-size: var(--text-sm);
		color: var(--fg);
		border: 1px solid var(--border);
		padding: 0.5rem 1rem;
		transition: border-color 0.15s;
	}

	.project-link a:hover {
		border-color: var(--fg);
		border-bottom: 1px solid var(--fg);
	}

	@media (max-width: 600px) {
		.meta-row {
			flex-direction: column;
		}

		.meta-item {
			border-right: none;
			border-bottom: 1px solid var(--border);
		}

		.meta-item:last-child {
			border-bottom: none;
		}
	}
</style>

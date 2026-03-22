<script lang="ts">
	let { data } = $props();
	const p = data.project;
</script>

<svelte:head>
	<title>{p.name} - Sangit Manandhar</title>
	<meta name="description" content={p.description} />
</svelte:head>

<article class="project-detail">
	<header>
		<a href="/#projects" class="back-link">&larr; back to projects</a>
		<h1>{p.name}</h1>
		<p class="description">{p.description}</p>
	</header>

	<div class="meta-row">
		<div class="meta-item">
			<span class="meta-label">area</span>
			<span class="meta-value">{p.area}</span>
		</div>
		<div class="meta-item">
			<span class="meta-label">language</span>
			<span class="meta-value">{p.language}</span>
		</div>
		<div class="meta-item">
			<span class="meta-label">loc</span>
			<span class="meta-value">{p.loc}</span>
		</div>
		<div class="meta-item">
			<span class="meta-label">created</span>
			<span class="meta-value">{p.createdAt}</span>
		</div>
	</div>

	<section class="section">
		<h2>Overview</h2>
		<p class="body-text">{p.overview}</p>
	</section>

	<section class="section">
		<h2>Languages</h2>
		<div class="lang-bar">
			{#each p.languages as lang}
				<div
					class="lang-segment"
					style="width: {lang.percentage}%"
					title="{lang.name} — {lang.percentage}%"
				></div>
			{/each}
		</div>
		<div class="lang-list">
			{#each p.languages as lang}
				<div class="lang-item">
					<span class="lang-name">{lang.name}</span>
					<span class="lang-pct">{lang.percentage}%</span>
				</div>
			{/each}
		</div>
	</section>

	<section class="section">
		<h2>Features</h2>
		<ul class="detail-list">
			{#each p.features as feature}
				<li>{feature}</li>
			{/each}
		</ul>
	</section>

	<section class="section">
		<h2>Use Cases</h2>
		<ul class="detail-list">
			{#each p.useCases as useCase}
				<li>{useCase}</li>
			{/each}
		</ul>
	</section>

	<section class="section">
		<h2>Tech Stack</h2>
		<div class="tags">
			{#each p.techStack as tech}
				<span class="tag">{tech}</span>
			{/each}
		</div>
	</section>

	<div class="project-link">
		<a href={p.url} target="_blank" rel="noopener noreferrer">View on GitHub &#8599;</a>
	</div>
</article>

<style>
	.project-detail {
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

	.lang-bar {
		display: flex;
		height: 6px;
		border: 1px solid var(--border);
		overflow: hidden;
		margin-bottom: 0.75rem;
	}

	.lang-segment {
		background: var(--fg);
		border-right: 1px solid var(--bg);
	}

	.lang-segment:last-child {
		border-right: none;
	}

	.lang-segment:nth-child(2) {
		opacity: 0.6;
	}

	.lang-segment:nth-child(3) {
		opacity: 0.35;
	}

	.lang-segment:nth-child(4) {
		opacity: 0.2;
	}

	.lang-list {
		display: flex;
		flex-wrap: wrap;
		gap: 1rem;
	}

	.lang-item {
		display: flex;
		align-items: center;
		gap: 0.5rem;
		font-size: var(--text-sm);
	}

	.lang-name {
		color: var(--fg);
	}

	.lang-pct {
		color: var(--muted);
		font-size: var(--text-xs);
	}

	.detail-list {
		list-style: none;
		padding: 0;
	}

	.detail-list li {
		color: var(--muted);
		font-size: var(--text-sm);
		line-height: 1.6;
		padding: 0.35rem 0;
		border-bottom: 1px solid var(--border);
	}

	.detail-list li:last-child {
		border-bottom: none;
	}

	.detail-list li::before {
		content: '— ';
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

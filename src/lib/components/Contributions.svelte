<script lang="ts">
	import { contributions } from '$lib/data/contributions';
</script>

<section id="contributions" class="contributions-section">
	<h2 class="section-title">Contributions</h2>

	<div class="contributions-list">
		{#each contributions as contrib}
			<a href={contrib.pr.url} target="_blank" rel="noopener noreferrer" class="contrib-card bordered">
				<div class="contrib-header">
					<div class="contrib-project">
						<span class="contrib-name">{contrib.project}</span>
						<span class="contrib-stars">
							<svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
								<polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2" />
							</svg>
							{contrib.projectStars}
						</span>
					</div>
					<span class="contrib-lang">{contrib.language}</span>
				</div>
				<p class="contrib-project-desc">{contrib.projectDescription}</p>

				<div class="contrib-pr">
					<span class="pr-badge">{contrib.pr.state}</span>
					<span class="pr-title">{contrib.pr.title}</span>
					<span class="pr-number">#{contrib.pr.number}</span>
				</div>

				<p class="contrib-overview">{contrib.overview}</p>

				<div class="contrib-meta">
					<span class="contrib-area">{contrib.area}</span>
					<span class="contrib-date">{contrib.pr.mergedAt}</span>
				</div>

				<div class="contrib-tech">
					{#each contrib.techStack as tech}
						<span class="contrib-tag">{tech}</span>
					{/each}
				</div>
			</a>
		{/each}
	</div>
</section>

<style>
	.contributions-section {
		padding: 1rem 0;
	}

	.contributions-list {
		display: flex;
		flex-direction: column;
		gap: 1rem;
	}

	.contrib-card {
		display: block;
		padding: 1.25rem;
		transition: border-color 0.15s;
		text-decoration: none;
		color: var(--fg);
	}

	.contrib-card:hover {
		border-color: var(--accent);
		border-bottom: 1px solid var(--accent);
	}

	.contrib-header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-bottom: 0.35rem;
	}

	.contrib-project {
		display: flex;
		align-items: center;
		gap: 0.75rem;
	}

	.contrib-name {
		font-weight: var(--weight-bold);
		font-family: var(--font-mono);
	}

	.contrib-stars {
		display: flex;
		align-items: center;
		gap: 0.25rem;
		font-size: var(--text-xs);
		color: var(--muted);
	}

	.contrib-lang {
		font-size: var(--text-xs);
		color: var(--muted);
		font-family: var(--font-mono);
	}

	.contrib-project-desc {
		font-size: var(--text-sm);
		color: var(--muted);
		margin: 0 0 0.75rem;
		line-height: 1.5;
	}

	.contrib-pr {
		display: flex;
		align-items: center;
		gap: 0.5rem;
		margin-bottom: 0.5rem;
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

	.pr-title {
		font-size: var(--text-sm);
		font-family: var(--font-mono);
		color: var(--fg);
	}

	.pr-number {
		font-size: var(--text-xs);
		color: var(--muted);
	}

	.contrib-overview {
		font-size: var(--text-sm);
		color: var(--muted);
		line-height: 1.6;
		margin: 0 0 0.75rem;
	}

	.contrib-meta {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-bottom: 0.75rem;
	}

	.contrib-area {
		font-size: var(--text-xs);
		color: var(--muted);
	}

	.contrib-date {
		font-size: var(--text-xs);
		color: var(--muted);
	}

	.contrib-tech {
		display: flex;
		flex-wrap: wrap;
		gap: 0.5rem;
	}

	.contrib-tag {
		font-size: var(--text-xs);
		color: var(--muted);
		padding: 0.2rem 0.5rem;
		border: 1px solid var(--border);
		font-family: var(--font-mono);
	}
</style>
